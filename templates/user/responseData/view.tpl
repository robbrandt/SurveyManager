{* purpose of this template: response datas view view in user area *}
{include file='user/header.tpl'}
<div class="surveymanager-responsedata surveymanager-view">
    {gt text='Response data list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='SurveyManager' type='user' func='view' ot='responseData'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='SurveyManager' type='user' func='view' ot='responseData' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='user/responseData/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    <table class="z-datatable">
        <colgroup>
            <col id="cResponseValue" />
            <col id="cGrade" />
            <col id="cCorrectness" />
            <col id="cResponse" />
            <col id="cQuestion" />
            <col id="cItemActions" />
        </colgroup>
        <thead>
        <tr>
            <th id="hResponseValue" scope="col" class="z-left">
                {sortlink __linktext='Response value' currentsort=$sort modname='SurveyManager' type='user' func='view' ot='responseData' sort='responseValue' sortdir=$sdir all=$all own=$own response=$response question=$question workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hGrade" scope="col" class="z-right">
                {sortlink __linktext='Grade' currentsort=$sort modname='SurveyManager' type='user' func='view' ot='responseData' sort='grade' sortdir=$sdir all=$all own=$own response=$response question=$question workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hCorrectness" scope="col" class="z-right">
                {sortlink __linktext='Correctness' currentsort=$sort modname='SurveyManager' type='user' func='view' ot='responseData' sort='correctness' sortdir=$sdir all=$all own=$own response=$response question=$question workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hResponse" scope="col" class="z-left">
                {sortlink __linktext='Response' currentsort=$sort modname='SurveyManager' type='user' func='view' ot='responseData' sort='response' sortdir=$sdir all=$all own=$own response=$response question=$question workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hQuestion" scope="col" class="z-left">
                {sortlink __linktext='Question' currentsort=$sort modname='SurveyManager' type='user' func='view' ot='responseData' sort='question' sortdir=$sdir all=$all own=$own response=$response question=$question workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
        </tr>
        </thead>
        <tbody>
    
    {foreach item='responseData' from=$items}
        <tr class="{cycle values='z-odd, z-even'}">
            <td headers="hResponseValue" class="z-left">
                <a href="{modurl modname='SurveyManager' type='user' func='display' ot='responseData' id=$responseData.id}" title="{gt text='View detail page'}">{$responseData.responseValue|notifyfilters:'surveymanager.filterhook.responsedatas'}</a>
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
        <tr class="z-datatableempty">
          <td class="z-left" colspan="6">
        {gt text='No response datas found.'}
          </td>
        </tr>
    {/foreach}
    
        </tbody>
    </table>
    
    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='SurveyManager' type='user' func='view' ot='responseData'}
    {/if}

    
    {notifydisplayhooks eventname='surveymanager.ui_hooks.responsedatas.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
{include file='user/footer.tpl'}
