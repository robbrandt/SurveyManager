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
 * Selection api implementation class.
 */
class SurveyManager_Api_Selection extends SurveyManager_Api_Base_Selection
{
    /**
     * Retrieves a certain survey and collects question and response data.
     *
     * @return mixed Desired entity object or null.
     */
    public function getSurveyWithData($args)
    {
        if (!isset($args['id'])) {
            return LogUtil::registerArgsError();
        }

        $id = (int) $args['id'];
        $includeResponses = isset($args['includeResponses']) ? (bool) $args['includeResponses'] : false;

        // Load the survey data
        $survey = $this->getEntity(array('ot' => 'survey', 'id' => $id));

        $responsesWithData = null;
        if ($includeResponses) {
            $where = 'tblSurvey.id = \'' . $id . '\'';
            $responsesWithData = $this->getEntities(array('ot' => 'response', 'where' => $where));
        }

        // Load all the page questions
        foreach ($survey['pages'] as $k => $page) {
            $where = 'tblPage.id = \'' . $page['id'] . '\'';
            $questions = $this->getEntities(array('ot' => 'question', 'where' => $where));

            if ($includeResponses) {
                // Go through all the questions' responses
                // and assign response data to according questions
                foreach ($questions as $l => $question) {
                    $questionResponses = array();
                    foreach ($responsesWithData as $response) {
                        foreach ($response['answers'] as $responseData) {
                            if ($responseData['question']['id'] != $question['id']) {
                                continue;
                            }

                            $questionResponses[$response['id']]['datum'] = reset($responseData);
                        }
                    }
            
                    // Assign
                    $questions[$l]['responses'] = $questionResponses;
                }
            }
                
            // Assign
//             if (!empty($questions)) {
//                 $survey['pages'][$k]['questions'] = $questions;
//             }
        }

        return $survey;
    }
}
