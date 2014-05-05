'use strict';

var currentSurveyManagerEditor = null;
var currentSurveyManagerInput = null;

/**
 * Returns the attributes used for the popup window. 
 * @return {String}
 */
function getPopupAttributes()
{
    var pWidth, pHeight;

    pWidth = screen.width * 0.75;
    pHeight = screen.height * 0.66;

    return 'width=' + pWidth + ',height=' + pHeight + ',scrollbars,resizable';
}

/**
 * Open a popup window with the finder triggered by a Xinha button.
 */
function SurveyManagerFinderXinha(editor, surveymanURL)
{
    var popupAttributes;

    // Save editor for access in selector window
    currentSurveyManagerEditor = editor;

    popupAttributes = getPopupAttributes();
    window.open(surveymanURL, '', popupAttributes);
}

/**
 * Open a popup window with the finder triggered by a CKEditor button.
 */
function SurveyManagerFinderCKEditor(editor, surveymanURL)
{
    // Save editor for access in selector window
    currentSurveyManagerEditor = editor;

    editor.popup(
        Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=SurveyManager&type=external&func=finder&editor=ckeditor',
        /*width*/ '80%', /*height*/ '70%',
        'location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,resizable=yes,scrollbars=yes'
    );
}



var surveymanager = {};

surveymanager.finder = {};

surveymanager.finder.onLoad = function (baseId, selectedId)
{
    $$('div.categoryselector select').invoke('observe', 'change', surveymanager.finder.onParamChanged);
    $('surveyManagerSort').observe('change', surveymanager.finder.onParamChanged);
    $('surveyManagerSortDir').observe('change', surveymanager.finder.onParamChanged);
    $('surveyManagerPageSize').observe('change', surveymanager.finder.onParamChanged);
    $('surveyManagerSearchGo').observe('click', surveymanager.finder.onParamChanged);
    $('surveyManagerSearchGo').observe('keypress', surveymanager.finder.onParamChanged);
    $('surveyManagerSubmit').addClassName('z-hide');
    $('surveyManagerCancel').observe('click', surveymanager.finder.handleCancel);
};

surveymanager.finder.onParamChanged = function ()
{
    $('surveyManagerSelectorForm').submit();
};

surveymanager.finder.handleCancel = function ()
{
    var editor, w;

    editor = $F('editorName');
    if (editor === 'xinha') {
        w = parent.window;
        window.close();
        w.focus();
    } else if (editor === 'tinymce') {
        surveymanClosePopup();
    } else if (editor === 'ckeditor') {
        surveymanClosePopup();
    } else {
        alert('Close Editor: ' + editor);
    }
};


function getPasteSnippet(mode, itemId)
{
    var itemUrl, itemTitle, itemDescription, pasteMode;

    itemUrl = $F('url' + itemId);
    itemTitle = $F('title' + itemId);
    itemDescription = $F('desc' + itemId);
    pasteMode = $F('surveyManagerPasteAs');

    if (pasteMode === '2' || pasteMode !== '1') {
        return itemId;
    }

    // return link to item
    if (mode === 'url') {
        // plugin mode
        return itemUrl;
    } else {
        // editor mode
        return '<a href="' + itemUrl + '" title="' + itemDescription + '">' + itemTitle + '</a>';
    }
}


// User clicks on "select item" button
surveymanager.finder.selectItem = function (itemId)
{
    var editor, html;

    editor = $F('editorName');
    if (editor === 'xinha') {
        if (window.opener.currentSurveyManagerEditor !== null) {
            html = getPasteSnippet('html', itemId);

            window.opener.currentSurveyManagerEditor.focusEditor();
            window.opener.currentSurveyManagerEditor.insertHTML(html);
        } else {
            html = getPasteSnippet('url', itemId);
            var currentInput = window.opener.currentSurveyManagerInput;

            if (currentInput.tagName === 'INPUT') {
                // Simply overwrite value of input elements
                currentInput.value = html;
            } else if (currentInput.tagName === 'TEXTAREA') {
                // Try to paste into textarea - technique depends on environment
                if (typeof document.selection !== 'undefined') {
                    // IE: Move focus to textarea (which fortunately keeps its current selection) and overwrite selection
                    currentInput.focus();
                    window.opener.document.selection.createRange().text = html;
                } else if (typeof currentInput.selectionStart !== 'undefined') {
                    // Firefox: Get start and end points of selection and create new value based on old value
                    var startPos = currentInput.selectionStart;
                    var endPos = currentInput.selectionEnd;
                    currentInput.value = currentInput.value.substring(0, startPos)
                                        + html
                                        + currentInput.value.substring(endPos, currentInput.value.length);
                } else {
                    // Others: just append to the current value
                    currentInput.value += html;
                }
            }
        }
    } else if (editor === 'tinymce') {
        html = getPasteSnippet('html', itemId);
        window.opener.tinyMCE.activeEditor.execCommand('mceInsertContent', false, html);
        // other tinymce commands: mceImage, mceInsertLink, mceReplaceContent, see http://www.tinymce.com/wiki.php/Command_identifiers
    } else if (editor === 'ckeditor') {
        /** to be done*/
    } else {
        alert('Insert into Editor: ' + editor);
    }
    surveymanClosePopup();
};


function surveymanClosePopup()
{
    window.opener.focus();
    window.close();
}




//=============================================================================
// SurveyManager item selector for Forms
//=============================================================================

surveymanager.itemSelector = {};
surveymanager.itemSelector.items = {};
surveymanager.itemSelector.baseId = 0;
surveymanager.itemSelector.selectedId = 0;

surveymanager.itemSelector.onLoad = function (baseId, selectedId)
{
    surveymanager.itemSelector.baseId = baseId;
    surveymanager.itemSelector.selectedId = selectedId;

    // required as a changed object type requires a new instance of the item selector plugin
    $('surveyManagerObjectType').observe('change', surveymanager.itemSelector.onParamChanged);

    if ($(baseId + '_catidMain') != undefined) {
        $(baseId + '_catidMain').observe('change', surveymanager.itemSelector.onParamChanged);
    } else if ($(baseId + '_catidsMain') != undefined) {
        $(baseId + '_catidsMain').observe('change', surveymanager.itemSelector.onParamChanged);
    }
    $(baseId + 'Id').observe('change', surveymanager.itemSelector.onItemChanged);
    $(baseId + 'Sort').observe('change', surveymanager.itemSelector.onParamChanged);
    $(baseId + 'SortDir').observe('change', surveymanager.itemSelector.onParamChanged);
    $('surveyManagerSearchGo').observe('click', surveymanager.itemSelector.onParamChanged);
    $('surveyManagerSearchGo').observe('keypress', surveymanager.itemSelector.onParamChanged);

    surveymanager.itemSelector.getItemList();
};

surveymanager.itemSelector.onParamChanged = function ()
{
    $('ajax_indicator').removeClassName('z-hide');

    surveymanager.itemSelector.getItemList();
};

surveymanager.itemSelector.getItemList = function ()
{
    var baseId, pars, request;

    baseId = surveymanager.itemSelector.baseId;
    pars = 'ot=' + baseId + '&';
    if ($(baseId + '_catidMain') != undefined) {
        pars += 'catidMain=' + $F(baseId + '_catidMain') + '&';
    } else if ($(baseId + '_catidsMain') != undefined) {
        pars += 'catidsMain=' + $F(baseId + '_catidsMain') + '&';
    }
    pars += 'sort=' + $F(baseId + 'Sort') + '&' +
            'sortdir=' + $F(baseId + 'SortDir') + '&' +
            'searchterm=' + $F(baseId + 'SearchTerm');

    request = new Zikula.Ajax.Request(
        Zikula.Config.baseURL + 'ajax.php?module=SurveyManager&func=getItemListFinder',
        {
            method: 'post',
            parameters: pars,
            onFailure: function(req) {
                Zikula.showajaxerror(req.getMessage());
            },
            onSuccess: function(req) {
                var baseId;
                baseId = surveymanager.itemSelector.baseId;
                surveymanager.itemSelector.items[baseId] = req.getData();
                $('ajax_indicator').addClassName('z-hide');
                surveymanager.itemSelector.updateItemDropdownEntries();
                surveymanager.itemSelector.updatePreview();
            }
        }
    );
};

surveymanager.itemSelector.updateItemDropdownEntries = function ()
{
    var baseId, itemSelector, items, i, item;

    baseId = surveymanager.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    itemSelector.length = 0;

    items = surveymanager.itemSelector.items[baseId];
    for (i = 0; i < items.length; ++i) {
        item = items[i];
        itemSelector.options[i] = new Option(item.title, item.id, false);
    }

    if (surveymanager.itemSelector.selectedId > 0) {
        $(baseId + 'Id').value = surveymanager.itemSelector.selectedId;
    }
};

surveymanager.itemSelector.updatePreview = function ()
{
    var baseId, items, selectedElement, i;

    baseId = surveymanager.itemSelector.baseId;
    items = surveymanager.itemSelector.items[baseId];

    $(baseId + 'PreviewContainer').addClassName('z-hide');

    if (items.length === 0) {
        return;
    }

    selectedElement = items[0];
    if (surveymanager.itemSelector.selectedId > 0) {
        for (var i = 0; i < items.length; ++i) {
            if (items[i].id === surveymanager.itemSelector.selectedId) {
                selectedElement = items[i];
                break;
            }
        }
    }

    if (selectedElement !== null) {
        $(baseId + 'PreviewContainer').update(window.atob(selectedElement.previewInfo))
                                      .removeClassName('z-hide');
    }
};

surveymanager.itemSelector.onItemChanged = function ()
{
    var baseId, itemSelector, preview;

    baseId = surveymanager.itemSelector.baseId;
    itemSelector = $(baseId + 'Id');
    preview = window.atob(surveymanager.itemSelector.items[baseId][itemSelector.selectedIndex].previewInfo);

    $(baseId + 'PreviewContainer').update(preview);
    surveymanager.itemSelector.selectedId = $F(baseId + 'Id');
};
