<?php
/**
 * SurveyManager.
 *
 * @copyright Zikula Development Team (Zikula)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package SurveyManager
 * @author Zikula Development Team <info@zikula.org>.
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.6.2 (http://modulestudio.de).
 */

/**
 * Validator class for encapsulating entity validation methods.
 *
 * This is the base validation class for response data entities.
 */
class SurveyManager_Entity_Validator_Base_ResponseData extends SurveyManager_Validator
{
    /**
     * Performs all validation rules.
     *
     * @return mixed either array with error information or true on success
     */
    public function validateAll()
    {
        $errorInfo = array('message' => '', 'code' => 0, 'debugArray' => array());
        $dom = ZLanguage::getModuleDomain('SurveyManager');
        if (!$this->isStringNotEmpty('workflowState')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('workflow state'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('responseValue', 5000)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('response value', 5000), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotEmpty('responseValue')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('response value'), $dom);
            return $errorInfo;
        }
        if (!$this->isValidInteger('grade')) {
            $errorInfo['message'] = __f('Error! Field value may only contain digits (%s).', array('grade'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotLongerThan('grade', 2)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('grade', 2), $dom);
            return $errorInfo;
        }
        if (!$this->isValidInteger('correctness')) {
            $errorInfo['message'] = __f('Error! Field value may only contain digits (%s).', array('correctness'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotLongerThan('correctness', 2)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('correctness', 2), $dom);
            return $errorInfo;
        }
    
        return true;
    }
    
    /**
     * Check for unique values.
     *
     * This method determines if there already exist response datas with the same response data.
     *
     * @param string $fieldName The name of the property to be checked
     * @return boolean result of this check, true if the given response data does not already exist
     */
    public function isUniqueValue($fieldName)
    {
        if ($this->entity[$fieldName] === '') {
            return false;
        }
    
        $entityClass = 'SurveyManager_Entity_ResponseData';
        $serviceManager = ServiceUtil::getManager();
        $entityManager = $serviceManager->getService('doctrine.entitymanager');
        $repository = $entityManager->getRepository($entityClass);
    
        $excludeid = $this->entity['id'];
    
        return $repository->detectUniqueState($fieldName, $this->entity[$fieldName], $excludeid);
    }
    
    /**
     * Get entity.
     *
     * @return Zikula_EntityAccess
     */
    public function getEntity()
    {
        return $this->entity;
    }
    
    /**
     * Set entity.
     *
     * @param Zikula_EntityAccess $entity.
     *
     * @return void
     */
    public function setEntity(Zikula_EntityAccess $entity = null)
    {
        $this->entity = $entity;
    }
    
}
