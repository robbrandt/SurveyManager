{* Purpose of this template: Display a popup selector of surveys for scribite integration *}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{lang}" lang="{lang}">
<head>
    <title>{gt text='Search and select survey'}</title>
    <link type="text/css" rel="stylesheet" href="{$baseurl}style/core.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/SurveyManager/style/style.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/SurveyManager/style/finder.css" />
    {assign var='ourEntry' value=$modvars.ZConfig.entrypoint}
    <script type="text/javascript">/* <![CDATA[ */
        if (typeof(Zikula) == 'undefined') {var Zikula = {};}
        Zikula.Config = {'entrypoint': '{{$ourEntry|default:'index.php'}}', 'baseURL': '{{$baseurl}}'}; /* ]]> */</script>
        <script type="text/javascript" src="{$baseurl}javascript/ajax/proto_scriptaculous.combined.min.js"></script>
        <script type="text/javascript" src="{$baseurl}javascript/helpers/Zikula.js"></script>
        <script type="text/javascript" src="{$baseurl}javascript/livepipe/livepipe.combined.min.js"></script>
        <script type="text/javascript" src="{$baseurl}javascript/helpers/Zikula.UI.js"></script>
        <script type="text/javascript" src="{$baseurl}javascript/helpers/Zikula.ImageViewer.js"></script>
    <script type="text/javascript" src="{$baseurl}modules/SurveyManager/javascript/SurveyManager_finder.js"></script>
{if $editorName eq 'tinymce'}
    <script type="text/javascript" src="{$baseurl}modules/Scribite/includes/tinymce/tiny_mce_popup.js"></script>
{/if}
</head>
<body>
    <p>{gt text='Switch to'}:
    <a href="{modurl modname='SurveyManager' type='external' func='finder' objectType='page' editor=$editorName}" title="{gt text='Search and select page'}">{gt text='Pages'}</a> | 
    <a href="{modurl modname='SurveyManager' type='external' func='finder' objectType='question' editor=$editorName}" title="{gt text='Search and select question'}">{gt text='Questions'}</a> | 
    <a href="{modurl modname='SurveyManager' type='external' func='finder' objectType='response' editor=$editorName}" title="{gt text='Search and select response'}">{gt text='Responses'}</a> | 
    <a href="{modurl modname='SurveyManager' type='external' func='finder' objectType='responseData' editor=$editorName}" title="{gt text='Search and select response data'}">{gt text='Response datas'}</a>
    </p>
    <form action="{$ourEntry|default:'index.php'}" id="surveyManagerSelectorForm" method="get" class="z-form">
    <div>
        <input type="hidden" name="module" value="SurveyManager" />
        <input type="hidden" name="type" value="external" />
        <input type="hidden" name="func" value="finder" />
        <input type="hidden" name="objectType" value="{$objectType}" />
        <input type="hidden" name="editor" id="editorName" value="{$editorName}" />

        <fieldset>
            <legend>{gt text='Search and select survey'}</legend>

            <div class="z-formrow">
                <label for="surveyManagerPasteAs">{gt text='Paste as'}:</label>
                    <select id="surveyManagerPasteAs" name="pasteas">
                        <option value="1">{gt text='Link to the survey'}</option>
                        <option value="2">{gt text='ID of survey'}</option>
                    </select>
            </div>
            <br />

            <div class="z-formrow">
                <label for="surveyManagerObjectId">{gt text='Survey'}:</label>
                    <div id="surveymanagerItemContainer">
                        <ul>
                        {foreach item='survey' from=$items}
                            <li>
                                <a href="#" onclick="surveymanager.finder.selectItem({$survey.id})" onkeypress="surveymanager.finder.selectItem({$survey.id})">{$survey->getTitleFromDisplayPattern()}</a>
                                <input type="hidden" id="url{$survey.id}" value="{modurl modname='SurveyManager' type='user' func='display' ot='survey' id=$survey.id slug=$survey.slug fqurl=true}" />
                                <input type="hidden" id="title{$survey.id}" value="{$survey->getTitleFromDisplayPattern()|replace:"\"":""}" />
                                <input type="hidden" id="desc{$survey.id}" value="{capture assign='description'}{if $survey.description ne ''}{$survey.description}{/if}
                                {/capture}{$description|strip_tags|replace:"\"":""}" />
                            </li>
                        {foreachelse}
                            <li>{gt text='No entries found.'}</li>
                        {/foreach}
                        </ul>
                    </div>
            </div>

            <div class="z-formrow">
                <label for="surveyManagerSort">{gt text='Sort by'}:</label>
                    <select id="surveyManagerSort" name="sort" style="width: 150px" class="z-floatleft" style="margin-right: 10px">
                    <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
                    <option value="workflowState"{if $sort eq 'workflowState'} selected="selected"{/if}>{gt text='Workflow state'}</option>
                    <option value="name"{if $sort eq 'name'} selected="selected"{/if}>{gt text='Name'}</option>
                    <option value="description"{if $sort eq 'description'} selected="selected"{/if}>{gt text='Description'}</option>
                    <option value="thankYou"{if $sort eq 'thankYou'} selected="selected"{/if}>{gt text='Thank you'}</option>
                    <option value="thankYouTitle"{if $sort eq 'thankYouTitle'} selected="selected"{/if}>{gt text='Thank you title'}</option>
                    <option value="thankYouAlternativeUrl"{if $sort eq 'thankYouAlternativeUrl'} selected="selected"{/if}>{gt text='Thank you alternative url'}</option>
                    <option value="weight"{if $sort eq 'weight'} selected="selected"{/if}>{gt text='Weight'}</option>
                    <option value="maxPerIp"{if $sort eq 'maxPerIp'} selected="selected"{/if}>{gt text='Max per ip'}</option>
                    <option value="maxPerUserId"{if $sort eq 'maxPerUserId'} selected="selected"{/if}>{gt text='Max per user id'}</option>
                    <option value="useCaptcha"{if $sort eq 'useCaptcha'} selected="selected"{/if}>{gt text='Use captcha'}</option>
                    <option value="recipients"{if $sort eq 'recipients'} selected="selected"{/if}>{gt text='Recipients'}</option>
                    <option value="responseSubject"{if $sort eq 'responseSubject'} selected="selected"{/if}>{gt text='Response subject'}</option>
                    <option value="confirmationSubject"{if $sort eq 'confirmationSubject'} selected="selected"{/if}>{gt text='Confirmation subject'}</option>
                    <option value="confirmationBody"{if $sort eq 'confirmationBody'} selected="selected"{/if}>{gt text='Confirmation body'}</option>
                    <option value="archived"{if $sort eq 'archived'} selected="selected"{/if}>{gt text='Archived'}</option>
                    <option value="template"{if $sort eq 'template'} selected="selected"{/if}>{gt text='Template'}</option>
                    <option value="addition1"{if $sort eq 'addition1'} selected="selected"{/if}>{gt text='Addition1'}</option>
                    <option value="addition2"{if $sort eq 'addition2'} selected="selected"{/if}>{gt text='Addition2'}</option>
                    <option value="addition3"{if $sort eq 'addition3'} selected="selected"{/if}>{gt text='Addition3'}</option>
                    <option value="addition4"{if $sort eq 'addition4'} selected="selected"{/if}>{gt text='Addition4'}</option>
                    <option value="addition5"{if $sort eq 'addition5'} selected="selected"{/if}>{gt text='Addition5'}</option>
                    <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
                    <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
                    <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
                    </select>
                    <select id="surveyManagerSortDir" name="sortdir" style="width: 100px">
                        <option value="asc"{if $sortdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
                        <option value="desc"{if $sortdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
                    </select>
            </div>

            <div class="z-formrow">
                <label for="surveyManagerPageSize">{gt text='Page size'}:</label>
                    <select id="surveyManagerPageSize" name="num" style="width: 50px; text-align: right">
                        <option value="5"{if $pager.itemsperpage eq 5} selected="selected"{/if}>5</option>
                        <option value="10"{if $pager.itemsperpage eq 10} selected="selected"{/if}>10</option>
                        <option value="15"{if $pager.itemsperpage eq 15} selected="selected"{/if}>15</option>
                        <option value="20"{if $pager.itemsperpage eq 20} selected="selected"{/if}>20</option>
                        <option value="30"{if $pager.itemsperpage eq 30} selected="selected"{/if}>30</option>
                        <option value="50"{if $pager.itemsperpage eq 50} selected="selected"{/if}>50</option>
                        <option value="100"{if $pager.itemsperpage eq 100} selected="selected"{/if}>100</option>
                    </select>
            </div>

            <div class="z-formrow">
                <label for="surveyManagerSearchTerm">{gt text='Search for'}:</label>
                    <input type="text" id="surveyManagerSearchTerm" name="searchterm" style="width: 150px" class="z-floatleft" style="margin-right: 10px" />
                    <input type="button" id="surveyManagerSearchGo" name="gosearch" value="{gt text='Filter'}" style="width: 80px" />
            </div>
            
            <div style="margin-left: 6em">
                {pager display='page' rowcount=$pager.numitems limit=$pager.itemsperpage posvar='pos' template='pagercss.tpl' maxpages='10'}
            </div>
            <input type="submit" id="surveyManagerSubmit" name="submitButton" value="{gt text='Change selection'}" />
            <input type="button" id="surveyManagerCancel" name="cancelButton" value="{gt text='Cancel'}" />
            <br />
        </fieldset>
    </div>
    </form>

    <script type="text/javascript">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            surveymanager.finder.onLoad();
        });
    /* ]]> */
    </script>

    {*
    <div class="surveymanager-finderform">
        <fieldset>
            {modfunc modname='SurveyManager' type='admin' func='edit'}
        </fieldset>
    </div>
    *}
</body>
</html>
