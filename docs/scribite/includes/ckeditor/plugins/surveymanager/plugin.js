CKEDITOR.plugins.add('SurveyManager', {
    requires: 'popup',
    lang: 'en,nl,de',
    init: function (editor) {
        editor.addCommand('insertSurveyManager', {
            exec: function (editor) {
                var url = Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=SurveyManager&type=external&func=finder&editor=ckeditor';
                // call method in SurveyManager_Finder.js and also give current editor
                SurveyManagerFinderCKEditor(editor, url);
            }
        });
        editor.ui.addButton('surveymanager', {
            label: 'Insert SurveyManager object',
            command: 'insertSurveyManager',
         // icon: this.path + 'images/ed_surveymanager.png'
            icon: '/images/icons/extrasmall/favorites.png'
        });
    }
});
