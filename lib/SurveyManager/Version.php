<?php
/**
 * SurveyManager.
 *
 * @copyright Zikula Development Team (Zikula)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package SurveyManager
 * @author Zikula Development Team <info@zikula.org>.
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.6.2 (http://modulestudio.de) at Fri Mar 28 23:17:41 CET 2014.
 */

/**
 * Version information implementation class.
 */
class SurveyManager_Version extends SurveyManager_Base_Version
{
    // custom enhancements can go here
    /**
    * Retrieves meta data information for this application.
    *
    * @return array List of meta data.
    */
    public function getMetaData()
    {
        $meta = parent::getMetaData();
        $meta['description'] = $this->__('Flexible surveyor.');
        /*
         $additionalPermissionSchema = array(
        'SurveyManager::Survey'   => 'Name::Survey ID',
        'SurveyManager::Page'     => 'Name::Page ID',
        'SurveyManager::Question' => 'Name::Question ID',
        'SurveyManager::Response' => ':IP Address:Response ID',
        'SurveyManager::Datum'    => '::Datum ID',
        'SurveyManager::Respond'  => '::'
        );
    
        $meta['securityschema'] = array_merge($meta['securityschema'], $additionalPermissionSchema);
        */
        return $meta;
    }
}
