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
 * Event handler implementation class for user logout events.
 */
class SurveyManager_Listener_UserLogout extends SurveyManager_Listener_Base_UserLogout
{
    /**
     * Listener for the `module.users.ui.logout.succeeded` event.
     *
     * Occurs right after a successful logout.
     * All handlers are notified.
     * The event's subject contains the user's user record.
     * Args contain array of `array('authentication_method' => $authenticationMethod,
     *                              'uid'                   => $uid));`
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function succeeded(Zikula_Event $event)
    {
        parent::succeeded($event);
    }
}
