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
 * Event handler implementation class for frontend controller interaction events.
 */
class SurveyManager_Listener_FrontController extends SurveyManager_Listener_Base_FrontController
{
    /**
     * Listener for the `frontcontroller.predispatch` event.
     *
     * Runs before the front controller does any work.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function preDispatch(Zikula_Event $event)
    {
        parent::preDispatch($event);
    }
}
