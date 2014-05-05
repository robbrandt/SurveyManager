// SurveyManager plugin for Xinha
// developed by Zikula Development Team
//
// requires SurveyManager module (http://zikula.org)
//
// Distributed under the same terms as xinha itself.
// This notice MUST stay intact for use (see license.txt).

'use strict';

function SurveyManager(editor) {
    var cfg, self;

    this.editor = editor;
    cfg = editor.config;
    self = this;

    cfg.registerButton({
        id       : 'SurveyManager',
        tooltip  : 'Insert SurveyManager object',
     // image    : _editor_url + 'plugins/SurveyManager/img/ed_SurveyManager.gif',
        image    : '/images/icons/extrasmall/favorites.png',
        textMode : false,
        action   : function (editor) {
            var url = Zikula.Config.baseURL + 'index.php'/*Zikula.Config.entrypoint*/ + '?module=SurveyManager&type=external&func=finder&editor=xinha';
            SurveyManagerFinderXinha(editor, url);
        }
    });
    cfg.addToolbarElement('SurveyManager', 'insertimage', 1);
}

SurveyManager._pluginInfo = {
    name          : 'SurveyManager for xinha',
    version       : '2.0.0',
    developer     : 'Zikula Development Team',
    developer_url : 'http://zikula.org',
    sponsor       : 'ModuleStudio 0.6.2',
    sponsor_url   : 'http://modulestudio.de',
    license       : 'htmlArea'
};
