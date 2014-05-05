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
 * @version Generated by ModuleStudio 0.5.5 (http://modulestudio.de) at Tue Aug 28 11:39:22 CEST 2012.
 */

/**
 * Survey display block class.
 */
class SurveyManager_Block_Display extends Zikula_Controller_AbstractBlock
{
    /**
     * Initialise the block.
     */
    public function init()
    {
        SecurityUtil::registerPermissionSchema('SurveyManager:DisplayBlock:', 'Block title::');
    }
    
    /**
     * Get information on the block.
     *
     * @return array The block information
     */
    public function info()
    {
        $requirementMessage = '';
        // check if the module is available at all
        if (!ModUtil::available('SurveyManager')) {
            $requirementMessage .= $this->__('Notice: This block will not be displayed until you activate the SurveyManager module.');
        }
    
        return array('module'          => 'SurveyManager',
                     'text_type'       => $this->__('SurveyManager survey display'),
                     'text_type_long'  => $this->__('Display a mini form / survey.'),
                     'allow_multiple'  => false,
                     'form_content'    => false,
                     'form_refresh'    => false,
                     'show_preview'    => true,
                     'admin_tableless' => true,
                     'requirement'     => $requirementMessage);
    }

    /**
     * Display the block.
     *
     * @param array $blockinfo the blockinfo structure
     *
     * @return string output of the rendered block
     */
    public function display($blockinfo)
    {
        // only show block content if the user has the required permissions
        if (!SecurityUtil::checkPermission('SurveyManager:DisplayBlock:', "$blockinfo[title]::", ACCESS_OVERVIEW)) {
            return false;
        }
    
        // check if the module is available at all
        if (!ModUtil::available('SurveyManager')) {
            return false;
        }
    
        // get current block content
        $vars = BlockUtil::varsFromContent($blockinfo['content']);
        $vars['bid'] = $blockinfo['bid'];

        if (empty($vars['id']) || !is_numeric($vars['id'])) {
            return false;
        }

        ModUtil::initOOModule('SurveyManager');
    
        $objectType = $vars['objectType'] = 'survey';

        $entityManager = $this->serviceManager->getService('doctrine.entitymanager');
        $repository = $entityManager->getRepository('SurveyManager_Entity_' . ucfirst($objectType));

        $this->view->setCaching(Zikula_View::CACHE_ENABLED);
        $this->view->setCacheId('block_' . $blockinfo['bid']);

        $template = $this->getDisplayTemplate($vars);
    
        // if page is cached return cached content
        if ($this->view->is_cached($template)) {
            $blockinfo['content'] = $this->view->fetch($template);
            return BlockUtil::themeBlock($blockinfo);
        }

        $id = $vars['id'];

        $survey = ModUtil::apiFunc('SurveyManager', 'selection', 'getEntity', array('ot' => 'survey', 'id' => $id));

        // get survey pages with questions
        $surveyPages = ModUtil::apiFunc('SurveyManager', 'selection', 'getEntities', array('ot' => 'page', 'where' => 'tblSurvey.id = \'' . $id . '\''));

        $firstPage = reset($surveyPages);
        $page = $firstPage['id'];

        $helper = new SurveyManager_Util_Manual($this->serviceManager);

        // select questions from first page
        $questions = array();
        $questionHandlers = array();
        foreach ($surveyPages as $surveyPage) {
            if ($surveyPage['id'] != $page) {
                continue;
            }
            foreach ($surveyPage['questions'] as $question) {
                $questions[$question['id']] = $question;

                $questionTypeClassName = $helper->getQuestionTypeHandler($question['questionType']);
                if (!isset($questionHandlers[$question['questionType']])) {
                    $questionHandlers[$question['questionType']] = new $questionTypeClassName($this->serviceManager);
                }
            }
            break;
        }

        $this->view->setCaching(Zikula_View::CACHE_DISABLED);

        // assign block vars and fetched data
        $this->view->assign('vars', $vars)
                   ->assign('survey', $survey)
                   ->assign('page', $page)
                   ->assign('questions', $questions)
                   ->assign('questionHandlers', $questionHandlers)
                   ->assign('id', $id)
                   ->assign('expandedSurveys', SessionUtil::getVar('SM_admin_expanded_surveys'))
                   ->assign('expandedPages', SessionUtil::getVar('SM_admin_expanded_pages'))
                   ->assign('expandedQuestions', SessionUtil::getVar('SM_admin_expanded_questions'))
                   ->assign($repository->getAdditionalTemplateParameters('block'))
                   ->assign('maxFileSizeB', DataUtil::formatForDisplay($this->getVar('maxFileSizeKb') * 1024));

        // set a block title
        if (empty($blockinfo['title'])) {
            $blockinfo['title'] = $this->__('Survey');
        }

        $output = $this->view->fetch($template);
    
        $blockinfo['content'] = $output;
    
        // return the block to the theme
        return BlockUtil::themeBlock($blockinfo);
    }

    /**
     * Returns the template used for output.
     *
     * @param array $vars List of block variables.
     *
     * @return string the template path.
     */
    protected function getDisplayTemplate($vars)
    {
        $template = 'block/display.tpl';
        return $template;
    }

    /**
     * Modify block settings.
     *
     * @param array $blockinfo the blockinfo structure
     *
     * @return string output of the block editing form.
     */
    public function modify($blockinfo)
    {
        // Get current content
        $vars = BlockUtil::varsFromContent($blockinfo['content']);

        $surveys = ModUtil::apiFunc('SurveyManager', 'selection', 'getEntities', array('ot' => 'survey'));

        $this->view->setCaching(Zikula_View::CACHE_DISABLED);

        // assign the approriate values
        $this->view->assign('id', $vars['id'])
                   ->assign('surveys', $surveys);

        // Return the output that has been generated by this function
        return $this->view->fetch('block/display_modify.tpl');
    }

    /**
     * Update block settings.
     *
     * @param array $blockinfo the blockinfo structure
     *
     * @return array the modified blockinfo structure.
     */
    public function update($blockinfo)
    {
        // Get current content
        $vars = BlockUtil::varsFromContent($blockinfo['content']);
    
        $vars['id'] = (int) $this->request->request->filter('id', 0, FILTER_VALIDATE_INT);

        // write back the new contents
        $blockinfo['content'] = BlockUtil::varsToContent($vars);
    
        // clear the block cache
        $this->view->clear_all_cache();

        return $blockinfo;
    }
}