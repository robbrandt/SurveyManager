<?php
/**
 * SurveyManager.
 *
 * @copyright Zikula Development Team
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package SurveyManager
 * @author Zikula Development Team <info@zikula.org>.
 * @link http://zikula.org
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.5.5 (http://modulestudio.de) at Thu Aug 30 15:09:35 CEST 2012.
 */

/**
 * This handler class handles the page events of the Form called by the surveyManager_admin_edit() function.
 * It aims on the response object type.
 */
class SurveyManager_Form_Handler_Admin_Response_Edit extends SurveyManager_Form_Handler_Admin_Response_Base_Edit
{
    private $questionHandlers;

    /**
     * Initialize form handler.
     *
     * This method takes care of all necessary initialisation of our data and form states.
     *
     * @param Zikula_Form_View $view The form view instance.
     *
     * @return boolean False in case of initialization errors, otherwise true.
     */
    public function initialize(Zikula_Form_View $view)
    {
        parent::initialize($view);

        $response = $this->view->get_template_vars('response');

        // Select survey pages with questions
        $surveyPages = $this->selectEntities(array('ot' => 'page', 'where' => 'tblSurvey.id = \'' . $response['survey']['id'] . '\''));

        $serviceManager = ServiceUtil::getManager();
        $helper = new SurveyManager_Util_Manual($serviceManager);

        $questionsWithResponseData = array();
        $this->questionHandlers = array();
        foreach ($surveyPages as $page) {
            foreach ($page['questions'] as $k => $question) {
                $questionsWithResponseData[$question['id']] = $page['questions'][$k];

                if (!isset($this->questionHandlers[$question['questionType']])) {
                    $questionTypeClassName = $helper->getQuestionTypeHandler($question['questionType']);
                    $this->questionHandlers[$question['questionType']] = new $questionTypeClassName($serviceManager);
                }
            }
        }

        // Add response data to questions
        foreach ($response['answers'] as $datum) {
            $questionsWithResponseData[$datum['question']['id']]['response'] = stripslashes($datum['responseValue']);
        }

        $this->view->assign('questions', $questionsWithResponseData)
                   ->assign('questionHandlers', $this->questionHandlers)
                   ->assign('maxFileSizeB', DataUtil::formatForDisplay($this->getVar('maxFileSizeKb') * 1024));

        // everything okay, no initialization errors occured
        return true;
    }

    /**
     * Command event handler.
     *
     * This event handler is called when a command is issued by the user.
     *
     * @param Zikula_Form_View $view The form view instance.
     * @param array            $args Additional arguments.
     *
     * @return mixed Redirect or false on errors.
     */
    public function handleCommand(Zikula_Form_View $view, &$args)
    {
        if ($args['commandName'] != 'update') {
            $result = parent::handleCommand($view, $args);
            if ($result === false) {
                return $result;
            }
        }

        $responseId = (int) $this->request->request->filter('id', 0, FILTER_VALIDATE_INT);
        $responseIsFeatured = (bool) $this->request->request->get('response_featured', false);

        $response = $this->entityRef;//ModUtil::apiFunc($this->name, 'selection', 'getEntity', array('ot' => $this->objectType, 'id' => $responseId));
        $oldDataPerQuestion = array();
        foreach ($response['answers'] as $datum) {
            $oldDataPerQuestion[$datum['question']['id']] = $datum;
        }

        // Fetch the survey
        $surveyId = $response['survey']['id'];
        $survey = ModUtil::apiFunc($this->name, 'selection', 'getEntity', array('ot' => 'survey', 'id' => $surveyId));

        // Fetch pages with questions
        $surveyPages = $this->selectEntities(array('ot' => 'page', 'where' => 'tblSurvey.id = \'' . $survey['id'] . '\''));
        $questions = array();
        foreach ($surveyPages as $surveyPage) {
            foreach ($surveyPage['questions'] as $question) {
                $questions[$question['id']] = $question;
            }
        }

        // Fetch the data that was entered in this step
        $newResponseData = FormUtil::getPassedValue('responses', array(), 'POST');
        $deleteFiles = FormUtil::getPassedValue('delete_files', array(), 'POST');

        $serviceManager = ServiceUtil::getManager();
        $helper = new SurveyManager_Util_Manual($serviceManager);

        // response value post processing
        $additionalOptions = array('deleteFiles' => $deleteFiles);
        foreach ($questions as $question) {
            $questionId = $question['id'];
            $oldDatum = $oldDataPerQuestion[$questionId];

            if (!isset($this->questionHandlers[$question['questionType']])) {
                $questionTypeClassName = $helper->getQuestionTypeHandler($question['questionType']);
                $this->questionHandlers[$question['questionType']] = new $questionTypeClassName($serviceManager);
            }

            $questionHandler = $this->questionHandlers[$question['questionType']];
            $newResponseData[$questionId] = $questionHandler->processPostEdit($question, $newResponseData[$questionId], $oldDatum['responseValue'], $additionalOptions);
            $newResponseData[$questionId] = $questionHandler->formatValue($question, $newResponseData[$questionId]);

            // Now, for every questions, update the data.
            if (!isset($newResponseData[$questionId]) || empty($newResponseData[$questionId])) {
                continue;
            }

            // Was there an existing datum?
            $newDatum = null;
            if (isset($oldDataPerQuestion[$questionId])) {
                $newDatum = $oldDatum;
            } else {
                // No existing datum
                $newDatum = new SurveyManager_Entity_ResponseData();
                $question->addAnswers($newDatum);
                $response->addAnswers($newDatum);
            }
            $newDatum->setResponseValue($newResponseData[$questionId]);
            $this->entityManager->persist($newDatum);
        }

        if (empty($responseIsFeatured)) {
            $responseIsFeatured = false;
        }

        // Update the response
        $response->setFeatured($responseIsFeatured);
        $this->entityManager->persist($response);

        // Save changes
        $this->entityManager->flush();

        // Update featured orders
        $this->updateFeaturedOrders($surveyId, $responseId, $responseIsFeatured);

        return $this->view->redirect($this->getRedirectUrl($args));
    }

    private function updateFeaturedOrders($surveyId, $responseId, $responseIsFeatured)
    {
        $featuredOrders = $this->getVar('featuredOrders');
        if (!is_array($featuredOrders)) {
            $featuredOrders = array();
        }

        $featuredOrder = $featuredOrders[$surveyId];
        if (empty($featuredOrder) || !is_array($featuredOrder)) {
            $siblings = $this->selectEntities(array('ot' => 'response', 'where' => 'tblSurvey.id = \'' . $surveyId . '\''));
            $featuredOrder = array();
            foreach ($siblings as $sibling) {
                $featuredOrder[] = $sibling['id'];
            }
        }

        $key = array_search($responseId, $featuredOrder);

        if ($responseIsFeatured) {
            // This response is featured, add to list if not existing yet
            if ($key === false) {
                $featuredOrder[count($featuredOrder)] = $responseId;
            }
        } else {
            // This response is not featured, remove it from the list
            if ($key !== false) {
                unset($featuredOrder[$key]);
            }
        }

        $featuredOrders[$surveyId] = array_values($featuredOrder);
        $this->setVar('featuredOrders', $featuredOrders);
    }

    private function selectEntities($selectionArgs)
    {
        return ModUtil::apiFunc($this->name, 'selection', 'getEntities', $selectionArgs);
    }
}
