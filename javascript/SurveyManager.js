'use strict';

var surveymanContextMenu;

surveymanContextMenu = Class.create(Zikula.UI.ContextMenu, {
    selectMenuItem: function ($super, event, item, item_container) {
        // open in new tab / window when right-clicked
        if (event.isRightClick()) {
            item.callback(this.clicked, true);
            event.stop(); // close the menu
            return;
        }
        // open in current window when left-clicked
        return $super(event, item, item_container);
    }
});

/**
 * Initialises the context menu for item actions.
 */
function surveymanInitItemActions(objectType, func, containerId)
{
    var triggerId, contextMenu, icon;

    triggerId = containerId + 'Trigger';

    // attach context menu
    contextMenu = new surveymanContextMenu(triggerId, { leftClick: true, animation: false });

    // process normal links
    $$('#' + containerId + ' a').each(function (elem) {
        // hide it
        elem.addClassName('z-hide');
        // determine the link text
        var linkText = '';
        if (func === 'display') {
            linkText = elem.innerHTML;
        } else if (func === 'view') {
            elem.select('img').each(function (imgElem) {
                linkText = imgElem.readAttribute('alt');
            });
        }

        // determine the icon
        icon = '';
        if (func === 'display') {
            if (elem.hasClassName('z-icon-es-preview')) {
                icon = 'xeyes.png';
            } else if (elem.hasClassName('z-icon-es-display')) {
                icon = 'kview.png';
            } else if (elem.hasClassName('z-icon-es-edit')) {
                icon = 'edit';
            } else if (elem.hasClassName('z-icon-es-saveas')) {
                icon = 'filesaveas';
            } else if (elem.hasClassName('z-icon-es-delete')) {
                icon = '14_layer_deletelayer';
            } else if (elem.hasClassName('z-icon-es-back')) {
                icon = 'agt_back';
            }
            if (icon !== '') {
                icon = Zikula.Config.baseURL + 'images/icons/extrasmall/' + icon + '.png';
            }
        } else if (func === 'view') {
            elem.select('img').each(function (imgElem) {
                icon = imgElem.readAttribute('src');
            });
        }
        if (icon !== '') {
            icon = '<img src="' + icon + '" width="16" height="16" alt="' + linkText + '" /> ';
        }

        contextMenu.addItem({
            label: icon + linkText,
            callback: function (selectedMenuItem, isRightClick) {
                var url;

                url = elem.readAttribute('href');
                if (isRightClick) {
                    window.open(url);
                } else {
                    window.location = url;
                }
            }
        });
    });
    $(triggerId).removeClassName('z-hide');
}

function surveymanCapitaliseFirstLetter(string)
{
    return string.charAt(0).toUpperCase() + string.slice(1);
}

/**
 * Submits a quick navigation form.
 */
function surveymanSubmitQuickNavForm(objectType)
{
    $('surveymanager' + surveymanCapitaliseFirstLetter(objectType) + 'QuickNavForm').submit();
}

/**
 * Initialise the quick navigation panel in list views.
 */
function surveymanInitQuickNavigation(objectType, controller)
{
    if ($('surveymanager' + surveymanCapitaliseFirstLetter(objectType) + 'QuickNavForm') == undefined) {
        return;
    }

    if ($('catid') != undefined) {
        $('catid').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
    }
    if ($('sortby') != undefined) {
        $('sortby').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
    }
    if ($('sortdir') != undefined) {
        $('sortdir').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
    }
    if ($('num') != undefined) {
        $('num').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
    }

    switch (objectType) {
    case 'survey':
        if ($('workflowState') != undefined) {
            $('workflowState').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
        }
        if ($('useCaptcha') != undefined) {
            $('useCaptcha').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
        }
        if ($('archived') != undefined) {
            $('archived').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
        }
        if ($('template') != undefined) {
            $('template').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
        }
        break;
    case 'page':
        if ($('survey') != undefined) {
            $('survey').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
        }
        if ($('workflowState') != undefined) {
            $('workflowState').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
        }
        break;
    case 'question':
        if ($('page') != undefined) {
            $('page').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
        }
        if ($('workflowState') != undefined) {
            $('workflowState').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
        }
        if ($('required') != undefined) {
            $('required').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
        }
        break;
    case 'response':
        if ($('survey') != undefined) {
            $('survey').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
        }
        if ($('workflowState') != undefined) {
            $('workflowState').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
        }
        if ($('featured') != undefined) {
            $('featured').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
        }
        break;
    case 'responseData':
        if ($('response') != undefined) {
            $('response').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
        }
        if ($('question') != undefined) {
            $('question').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
        }
        if ($('workflowState') != undefined) {
            $('workflowState').observe('change', function () { surveymanSubmitQuickNavForm(objectType); });
        }
        break;
    default:
        break;
    }
}

/**
 * Helper function to create new Zikula.UI.Window instances.
 * For edit forms we use "iframe: true" to ensure file uploads work without problems.
 * For all other windows we use "iframe: false" because we want the escape key working.
 */
function surveymanInitInlineWindow(containerElem, title)
{
    var newWindow;

    // show the container (hidden for users without JavaScript)
    containerElem.removeClassName('z-hide');

    // define the new window instance
    newWindow = new Zikula.UI.Window(
        containerElem,
        {
            minmax: true,
            resizable: true,
            title: title,
            width: 600,
            initMaxHeight: 400,
            modal: false,
            iframe: false
        }
    );

    // return the instance
    return newWindow;
}


/**
 * Initialise ajax-based toggle for boolean fields.
 */
function surveymanInitToggle(objectType, fieldName, itemId)
{
    var idSuffix = fieldName.charAt(0).toUpperCase() + fieldName.slice(1) + itemId;
    if ($('toggle' + idSuffix) == undefined) {
        return;
    }
    $('toggle' + idSuffix).observe('click', function() {
        surveymanToggleFlag(objectType, fieldName, itemId);
    }).removeClassName('z-hide');
}


/**
 * Toggle a certain flag for a given item.
 */
function surveymanToggleFlag(objectType, fieldName, itemId)
{
    fieldName = fieldName.charAt(0).toLowerCase() + fieldName.slice(1);
    var pars = 'ot=' + objectType + '&field=' + fieldName + '&id=' + itemId;

    new Zikula.Ajax.Request(
        Zikula.Config.baseURL + 'ajax.php?module=SurveyManager&func=toggleFlag',
        {
            method: 'post',
            parameters: pars,
            onComplete: function(req) {
                if (!req.isSuccess()) {
                    Zikula.UI.Alert(req.getMessage(), Zikula.__('Error', 'module_surveymanager_js'));
                    return;
                }
                var data = req.getData();
                /*if (data.message) {
                    Zikula.UI.Alert(data.message, Zikula.__('Success', 'module_surveymanager_js'));
                }*/

                var idSuffix = fieldName + '_' + itemId;
                idSuffix = idSuffix.toLowerCase();
                var state = data.state;
                if (state === true) {
                    $('no' + idSuffix).addClassName('z-hide');
                    $('yes' + idSuffix).removeClassName('z-hide');
                } else {
                    $('yes' + idSuffix).addClassName('z-hide');
                    $('no' + idSuffix).removeClassName('z-hide');
                }
            }
        }
    );
}
