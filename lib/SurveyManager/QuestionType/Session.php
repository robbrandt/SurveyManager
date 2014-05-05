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
 * Question type class for sessions.
 */
class SurveyManager_QuestionType_Session extends SurveyManager_AbstractQuestionType
{
    /**
     * Returns the question type code.
     */
    public function getID()
    {
        return 'session';
    }

    /**
     * Returns the question type name.
     */
    public function getName()
    {
        return $this->__('Session');
    }

    /**
     * Returns the question type category.
     */
    public function getGroup()
    {
        return $this->__('Education');
    }

    /**
     * Returns label or description for editing.
     */
    public function getEditIntro($question, $withDescription = false, $context = '')
    {
        if ($context == 'admin_response_edit') {
            return parent::getEditIntro($question, $withDescription, $context);
        }

        return '';
    }

    /**
     * Returns the editing ui component(s).
     */
    public function getEditInput($question, $response, $context = '')
    {
        if ($context == 'admin_response_edit') {
            return $this->getEditInputDefault($question, $response, $context);
        }
        // create hidden fields for display in user area and block
        $output = '';
        foreach ($question['questionValues'] as $valueKey => $value) {
            $output .= $this->getHiddenInput($question, $value);
        }
        return $output;
    }

    /**
     * Checks if a given value is correct.
     */
    public function validateInput($question, $inputValue)
    {
        return true;
    }
}
