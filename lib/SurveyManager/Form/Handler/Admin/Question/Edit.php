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
 * @version Generated by ModuleStudio 0.5.5 (http://modulestudio.de) at Tue Aug 21 20:13:14 CEST 2012.
 */

/**
 * This handler class handles the page events of the Form called by the surveyManager_admin_edit() function.
 * It aims on the question object type.
 */
class SurveyManager_Form_Handler_Admin_Question_Edit extends SurveyManager_Form_Handler_Admin_Question_Base_Edit
{
    /**
     * Post-initialise hook.
     *
     * @return void
     */
    public function postInitialize()
    {
        parent::postInitialize();

        $question = $this->view->get_template_vars('question');

        $helper = new SurveyManager_Util_Manual(ServiceUtil::getManager());
        $question['questionTypeItems'] = $helper->getListOfQuestionTypes();
        $question['questionValues'] = implode("\r\n", $question['questionValues']);
        $question['correctValues'] = implode("\r\n", $question['correctValues']);

        $parentPage = ModUtil::apiFunc($this->name, 'selection', 'getEntity', array('ot' => 'page', 'id' => $question['page']['id']));

        $parentSurvey = ModUtil::apiFunc($this->name, 'selection', 'getSurveyWithData', array('id' => $parentPage['survey']['id']));

        $this->view->assign('question', $question)
                   ->assign('parentSurvey', $parentSurvey)
                   ->assign('parentPage', $parentPage);
    }

    /**
     * Get the default redirect url. Required if no returnTo parameter has been supplied.
     * This method is called in handleCommand so we know which command has been performed.
     *
     * @param array  $args List of arguments.
     *
     * @return string The default redirect url.
     */
    protected function getDefaultReturnUrl($args)
    {
        // redirect to the list of pages
        $viewArgs = array('ot' => 'survey');
        $url = ModUtil::url($this->name, 'admin', 'view', $viewArgs);
    
        return $url;
    }

    /**
     * Input data processing called by handleCommand method.
     *
     * @param Zikula_Form_View $view The form view instance.
     * @param array            $args Additional arguments.
     *
     * @return array form data after processing.
     */
    public function fetchInputData(Zikula_Form_View $view, &$args)
    {
        $otherFormData = parent::fetchInputData($view, $args);

        // get treated entity reference from persisted member var
        $entity = $this->entityRef;

        if ($this->mode == 'create') {
            // Find the maximum current weight
            $where = 'tblPage.id = \'' . $entity['page']['id'] . '\'';
            $questions = ModUtil::apiFunc($this->name, 'selection', 'getEntities', array('ot' => 'question', 'where' => $where));

            $maxWeight = -1;
            foreach ($questions as $question) {
                $maxWeight = max($question['weight'], $maxWeight);
            }
            $maxWeight++;
            $entity->setWeight($maxWeight);
        }

        if (empty($entity['required'])) {
            $entity->setRequired(false);
        }
        $entity['dependencies'] = FormUtil::getPassedValue('dependencies', array(), 'POST');

        $questionValues = $entity->getQuestionValues();
        $questionValues = str_replace("\r", "\n", $questionValues);
        $questionValues = str_replace("\n\n", "\n", $questionValues);
        $questionValues = explode("\n", $questionValues);

        foreach ($questionValues as $key => $value) {
            if (!empty($value)) {
                continue;
            }
            unset($questionValues[$key]);
        }
        $entity->setQuestionValues($questionValues);

        $correctValues = $entity->getCorrectValues();
        $correctValues = str_replace("\r", "\n", $correctValues);
        $correctValues = str_replace("\n\n", "\n", $correctValues);
        $correctValues = explode("\n", $correctValues);

        foreach ($correctValues as $key => $value) {
            if (!empty($value)) {
                continue;
            }
            unset($correctValues[$key]);
        }
        $entity->setCorrectValues($correctValues);


        // save updated entity
        $this->entityRef = $entity;

        return $otherFormData;
    }
}
