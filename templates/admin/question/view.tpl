{* purpose of this template: questions view view in admin area *}
{include file='admin/header.tpl'}
<div class="surveymanager-question surveymanager-view">
    {gt text='Question list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='view' size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>

    {if $canBeCreated}
        {checkpermissionblock component='SurveyManager:Question:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create question' assign='createTitle'}
            <a href="{modurl modname='SurveyManager' type='admin' func='edit' ot='question'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='SurveyManager' type='admin' func='view' ot='question'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='SurveyManager' type='admin' func='view' ot='question' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='admin/question/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    <form action="{modurl modname='SurveyManager' type='admin' func='handleSelectedEntries'}" method="post" id="questionsViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
            <input type="hidden" name="ot" value="question" />
            <table class="z-datatable">
                <colgroup>
                    <col id="cSelect" />
                    <col id="cName" />
                    <col id="cDescription" />
                    <col id="cWeight" />
                    <col id="cQuestionType" />
                    <col id="cRequired" />
                    <col id="cPage" />
                    <col id="cItemActions" />
                </colgroup>
                <thead>
                <tr>
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="toggleQuestions" />
                    </th>
                    <th id="hName" scope="col" class="z-left">
                        {sortlink __linktext='Name' currentsort=$sort modname='SurveyManager' type='admin' func='view' ot='question' sort='name' sortdir=$sdir all=$all own=$own page=$page workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize required=$required}
                    </th>
                    <th id="hDescription" scope="col" class="z-left">
                        {sortlink __linktext='Description' currentsort=$sort modname='SurveyManager' type='admin' func='view' ot='question' sort='description' sortdir=$sdir all=$all own=$own page=$page workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize required=$required}
                    </th>
                    <th id="hWeight" scope="col" class="z-right">
                        {sortlink __linktext='Weight' currentsort=$sort modname='SurveyManager' type='admin' func='view' ot='question' sort='weight' sortdir=$sdir all=$all own=$own page=$page workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize required=$required}
                    </th>
                    <th id="hQuestionType" scope="col" class="z-left">
                        {sortlink __linktext='Question type' currentsort=$sort modname='SurveyManager' type='admin' func='view' ot='question' sort='questionType' sortdir=$sdir all=$all own=$own page=$page workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize required=$required}
                    </th>
                    <th id="hRequired" scope="col" class="z-center">
                        {sortlink __linktext='Required' currentsort=$sort modname='SurveyManager' type='admin' func='view' ot='question' sort='required' sortdir=$sdir all=$all own=$own page=$page workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize required=$required}
                    </th>
                    <th id="hPage" scope="col" class="z-left">
                        {sortlink __linktext='Page' currentsort=$sort modname='SurveyManager' type='admin' func='view' ot='question' sort='page' sortdir=$sdir all=$all own=$own page=$page workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize required=$required}
                    </th>
                    <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
                </tr>
                </thead>
                <tbody>
            
            {foreach item='question' from=$items}
                <tr class="{cycle values='z-odd, z-even'}">
                    <td headers="hselect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$question.id}" class="questions-checkbox" />
                    </td>
                    <td headers="hName" class="z-left">
                        {$question.name|notifyfilters:'surveymanager.filterhook.questions'}
                    </td>
                    <td headers="hDescription" class="z-left">
                        {$question.description}
                    </td>
                    <td headers="hWeight" class="z-right">
                        {$question.weight}
                    </td>
                    <td headers="hQuestionType" class="z-left">
                        {$question.questionType}
                    </td>
                    <td headers="hRequired" class="z-center">
                        {$question.required|yesno:true}
                    </td>
                    <td headers="hPage" class="z-left">
                        {if isset($question.Page) && $question.Page ne null}
                            <a href="{modurl modname='SurveyManager' type='user' func='display' ot='page' id=$question.Page.id}">{strip}
                              {$question.Page->getTitleFromDisplayPattern()|default:""}
                            {/strip}</a>
                            <a id="pageItem{$question.id}_rel_{$question.Page.id}Display" href="{modurl modname='SurveyManager' type='user' func='display' ot='page' id=$question.Page.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
                            <script type="text/javascript">
                            /* <![CDATA[ */
                                document.observe('dom:loaded', function() {
                                    surveymanInitInlineWindow($('pageItem{{$question.id}}_rel_{{$question.Page.id}}Display'), '{{$question.Page->getTitleFromDisplayPattern()|replace:"'":""}}');
                                });
                            /* ]]> */
                            </script>
                        {else}
                            {gt text='Not set.'}
                        {/if}
                    </td>
                    <td id="itemActions{$question.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                        {if count($question._actions) gt 0}
                            {foreach item='option' from=$question._actions}
                                <a href="{$option.url.type|surveymanagerActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                            {/foreach}
                            {icon id="itemActions`$question.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                            <script type="text/javascript">
                            /* <![CDATA[ */
                                document.observe('dom:loaded', function() {
                                    surveymanInitItemActions('question', 'view', 'itemActions{{$question.id}}');
                                });
                            /* ]]> */
                            </script>
                        {/if}
                    </td>
                </tr>
            {foreachelse}
                <tr class="z-admintableempty">
                  <td class="z-left" colspan="8">
                {gt text='No questions found.'}
                  </td>
                </tr>
            {/foreach}
            
                </tbody>
            </table>
            
            {if !isset($showAllEntries) || $showAllEntries ne 1}
                {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='SurveyManager' type='admin' func='view' ot='question'}
            {/if}
            <fieldset>
                <label for="surveyManagerAction">{gt text='With selected questions'}</label>
                <select id="surveyManagerAction" name="action">
                    <option value="">{gt text='Choose action'}</option>
                    <option value="delete" title="{gt text='Delete content permanently.'}">{gt text='Delete'}</option>
                </select>
                <input type="submit" value="{gt text='Submit'}" />
            </fieldset>
        </div>
    </form>

</div>
{include file='admin/footer.tpl'}

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
    {{* init the "toggle all" functionality *}}
    if ($('toggleQuestions') != undefined) {
        $('toggleQuestions').observe('click', function (e) {
            Zikula.toggleInput('questionsViewForm');
            e.stop()
        });
    }
    });
/* ]]> */
</script>
