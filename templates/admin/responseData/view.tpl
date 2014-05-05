{* purpose of this template: response datas view view in admin area *}
{include file='admin/header.tpl'}
<div class="surveymanager-responsedata surveymanager-view">
    {gt text='Response data list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='view' size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>

    {if $canBeCreated}
        {checkpermissionblock component='SurveyManager:ResponseData:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create response data' assign='createTitle'}
            <a href="{modurl modname='SurveyManager' type='admin' func='edit' ot='responseData'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='SurveyManager' type='admin' func='view' ot='responseData'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='SurveyManager' type='admin' func='view' ot='responseData' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='admin/responseData/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    <form action="{modurl modname='SurveyManager' type='admin' func='handleSelectedEntries'}" method="post" id="responseDatasViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
            <input type="hidden" name="ot" value="responseData" />
            <table class="z-datatable">
                <colgroup>
                    <col id="cSelect" />
                    <col id="cResponseValue" />
                    <col id="cGrade" />
                    <col id="cCorrectness" />
                    <col id="cResponse" />
                    <col id="cQuestion" />
                    <col id="cItemActions" />
                </colgroup>
                <thead>
                <tr>
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="toggleResponseDatas" />
                    </th>
                    <th id="hResponseValue" scope="col" class="z-left">
                        {sortlink __linktext='Response value' currentsort=$sort modname='SurveyManager' type='admin' func='view' ot='responseData' sort='responseValue' sortdir=$sdir all=$all own=$own response=$response question=$question workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hGrade" scope="col" class="z-right">
                        {sortlink __linktext='Grade' currentsort=$sort modname='SurveyManager' type='admin' func='view' ot='responseData' sort='grade' sortdir=$sdir all=$all own=$own response=$response question=$question workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hCorrectness" scope="col" class="z-right">
                        {sortlink __linktext='Correctness' currentsort=$sort modname='SurveyManager' type='admin' func='view' ot='responseData' sort='correctness' sortdir=$sdir all=$all own=$own response=$response question=$question workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hResponse" scope="col" class="z-left">
                        {sortlink __linktext='Response' currentsort=$sort modname='SurveyManager' type='admin' func='view' ot='responseData' sort='response' sortdir=$sdir all=$all own=$own response=$response question=$question workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hQuestion" scope="col" class="z-left">
                        {sortlink __linktext='Question' currentsort=$sort modname='SurveyManager' type='admin' func='view' ot='responseData' sort='question' sortdir=$sdir all=$all own=$own response=$response question=$question workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
                </tr>
                </thead>
                <tbody>
            
            {foreach item='responseData' from=$items}
                <tr class="{cycle values='z-odd, z-even'}">
                    <td headers="hselect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$responseData.id}" class="responsedatas-checkbox" />
                    </td>
                    <td headers="hResponseValue" class="z-left">
                        {$responseData.responseValue|notifyfilters:'surveymanager.filterhook.responsedatas'}
                    </td>
                    <td headers="hGrade" class="z-right">
                        {$responseData.grade}
                    </td>
                    <td headers="hCorrectness" class="z-right">
                        {$responseData.correctness}
                    </td>
                    <td headers="hResponse" class="z-left">
                        {if isset($responseData.Response) && $responseData.Response ne null}
                            <a href="{modurl modname='SurveyManager' type='user' func='display' ot='response' id=$responseData.Response.id}">{strip}
                              {$responseData.Response->getTitleFromDisplayPattern()|default:""}
                            {/strip}</a>
                            <a id="responseItem{$responseData.id}_rel_{$responseData.Response.id}Display" href="{modurl modname='SurveyManager' type='user' func='display' ot='response' id=$responseData.Response.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
                            <script type="text/javascript">
                            /* <![CDATA[ */
                                document.observe('dom:loaded', function() {
                                    surveymanInitInlineWindow($('responseItem{{$responseData.id}}_rel_{{$responseData.Response.id}}Display'), '{{$responseData.Response->getTitleFromDisplayPattern()|replace:"'":""}}');
                                });
                            /* ]]> */
                            </script>
                        {else}
                            {gt text='Not set.'}
                        {/if}
                    </td>
                    <td headers="hQuestion" class="z-left">
                        {if isset($responseData.Question) && $responseData.Question ne null}
                            <a href="{modurl modname='SurveyManager' type='user' func='display' ot='question' id=$responseData.Question.id}">{strip}
                              {$responseData.Question->getTitleFromDisplayPattern()|default:""}
                            {/strip}</a>
                            <a id="questionItem{$responseData.id}_rel_{$responseData.Question.id}Display" href="{modurl modname='SurveyManager' type='user' func='display' ot='question' id=$responseData.Question.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
                            <script type="text/javascript">
                            /* <![CDATA[ */
                                document.observe('dom:loaded', function() {
                                    surveymanInitInlineWindow($('questionItem{{$responseData.id}}_rel_{{$responseData.Question.id}}Display'), '{{$responseData.Question->getTitleFromDisplayPattern()|replace:"'":""}}');
                                });
                            /* ]]> */
                            </script>
                        {else}
                            {gt text='Not set.'}
                        {/if}
                    </td>
                    <td id="itemActions{$responseData.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                        {if count($responseData._actions) gt 0}
                            {foreach item='option' from=$responseData._actions}
                                <a href="{$option.url.type|surveymanagerActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                            {/foreach}
                            {icon id="itemActions`$responseData.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                            <script type="text/javascript">
                            /* <![CDATA[ */
                                document.observe('dom:loaded', function() {
                                    surveymanInitItemActions('responseData', 'view', 'itemActions{{$responseData.id}}');
                                });
                            /* ]]> */
                            </script>
                        {/if}
                    </td>
                </tr>
            {foreachelse}
                <tr class="z-admintableempty">
                  <td class="z-left" colspan="7">
                {gt text='No response datas found.'}
                  </td>
                </tr>
            {/foreach}
            
                </tbody>
            </table>
            
            {if !isset($showAllEntries) || $showAllEntries ne 1}
                {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='SurveyManager' type='admin' func='view' ot='responseData'}
            {/if}
            <fieldset>
                <label for="surveyManagerAction">{gt text='With selected response datas'}</label>
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
    if ($('toggleResponseDatas') != undefined) {
        $('toggleResponseDatas').observe('click', function (e) {
            Zikula.toggleInput('responseDatasViewForm');
            e.stop()
        });
    }
    });
/* ]]> */
</script>
