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

use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;
use Gedmo\Mapping\Annotation as Gedmo;
use DoctrineExtensions\StandardFields\Mapping\Annotation as ZK;

/**
 * Entity class that defines the entity structure and behaviours.
 *
 * This is the concrete entity class for page entities.
 * @ORM\Entity(repositoryClass="SurveyManager_Entity_Repository_Page")
  * @ORM\Table(name="surveyman_page",
  *     indexes={
 *         @ORM\Index(name="weightindex", columns={"weight"}),
 *         @ORM\Index(name="workflowstateindex", columns={"workflowState"})
  *     }
  * )
 * @ORM\HasLifecycleCallbacks
 */
class SurveyManager_Entity_Page extends SurveyManager_Entity_Base_Page
{
    // feel free to add your own methods here

    
    /**
     * Post-Process the data after the entity has been constructed by the entity manager.
     *
     * @ORM\PostLoad
     * @see SurveyManager_Entity_Page::performPostLoadCallback()
     * @return void.
     */
    public function postLoadCallback()
    {
        $this->performPostLoadCallback();
    }
    
    /**
     * Pre-Process the data prior to an insert operation.
     *
     * @ORM\PrePersist
     * @see SurveyManager_Entity_Page::performPrePersistCallback()
     * @return void.
     */
    public function prePersistCallback()
    {
        $this->performPrePersistCallback();
    }
    
    /**
     * Post-Process the data after an insert operation.
     *
     * @ORM\PostPersist
     * @see SurveyManager_Entity_Page::performPostPersistCallback()
     * @return void.
     */
    public function postPersistCallback()
    {
        $this->performPostPersistCallback();
    }
    
    /**
     * Pre-Process the data prior a delete operation.
     *
     * @ORM\PreRemove
     * @see SurveyManager_Entity_Page::performPreRemoveCallback()
     * @return void.
     */
    public function preRemoveCallback()
    {
        $this->performPreRemoveCallback();
    }
    
    /**
     * Post-Process the data after a delete.
     *
     * @ORM\PostRemove
     * @see SurveyManager_Entity_Page::performPostRemoveCallback()
     * @return void
     */
    public function postRemoveCallback()
    {
        $this->performPostRemoveCallback();
    }
    
    /**
     * Pre-Process the data prior to an update operation.
     *
     * @ORM\PreUpdate
     * @see SurveyManager_Entity_Page::performPreUpdateCallback()
     * @return void.
     */
    public function preUpdateCallback()
    {
        $this->performPreUpdateCallback();
    }
    
    /**
     * Post-Process the data after an update operation.
     *
     * @ORM\PostUpdate
     * @see SurveyManager_Entity_Page::performPostUpdateCallback()
     * @return void.
     */
    public function postUpdateCallback()
    {
        $this->performPostUpdateCallback();
    }
    
    /**
     * Pre-Process the data prior to a save operation.
     *
     * @ORM\PrePersist
     * @ORM\PreUpdate
     * @see SurveyManager_Entity_Page::performPreSaveCallback()
     * @return void.
     */
    public function preSaveCallback()
    {
        $this->performPreSaveCallback();
    }
    
    /**
     * Post-Process the data after a save operation.
     *
     * @ORM\PostPersist
     * @ORM\PostUpdate
     * @see SurveyManager_Entity_Page::performPostSaveCallback()
     * @return void.
     */
    public function postSaveCallback()
    {
        $this->performPostSaveCallback();
    }
    
}
