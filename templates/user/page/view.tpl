{* purpose of this template: pages view view in user area *}
{include file='user/header.tpl'}
<div class="surveymanager-page surveymanager-view">
    {gt text='Page list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='SurveyManager' type='user' func='view' ot='page'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='SurveyManager' type='user' func='view' ot='page' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='user/page/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    <table class="z-datatable">
        <colgroup>
            <col id="cName" />
            <col id="cDescription" />
            <col id="cWeight" />
            <col id="cSurvey" />
            <col id="cItemActions" />
        </colgroup>
        <thead>
        <tr>
            <th id="hName" scope="col" class="z-left">
                {sortlink __linktext='Name' currentsort=$sort modname='SurveyManager' type='user' func='view' ot='page' sort='name' sortdir=$sdir all=$all own=$own survey=$survey workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hDescription" scope="col" class="z-left">
                {sortlink __linktext='Description' currentsort=$sort modname='SurveyManager' type='user' func='view' ot='page' sort='description' sortdir=$sdir all=$all own=$own survey=$survey workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hWeight" scope="col" class="z-right">
                {sortlink __linktext='Weight' currentsort=$sort modname='SurveyManager' type='user' func='view' ot='page' sort='weight' sortdir=$sdir all=$all own=$own survey=$survey workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hSurvey" scope="col" class="z-left">
                {sortlink __linktext='Survey' currentsort=$sort modname='SurveyManager' type='user' func='view' ot='page' sort='survey' sortdir=$sdir all=$all own=$own survey=$survey workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
        </tr>
        </thead>
        <tbody>
    
    {foreach item='page' from=$items}
        <tr class="{cycle values='z-odd, z-even'}">
            <td headers="hName" class="z-left">
                <a href="{modurl modname='SurveyManager' type='user' func='display' ot='page' id=$page.id}" title="{gt text='View detail page'}">{$page.name|notifyfilters:'surveymanager.filterhook.pages'}</a>
            </td>
            <td headers="hDescription" class="z-left">
                {$page.description}
            </td>
            <td headers="hWeight" class="z-right">
                {$page.weight}
            </td>
            <td headers="hSurvey" class="z-left">
                {if isset($page.Survey) && $page.Survey ne null}
                    <a href="{modurl modname='SurveyManager' type='user' func='display' ot='survey' id=$page.Survey.id slug=$page.Survey.slug}">{strip}
                      {$page.Survey->getTitleFromDisplayPattern()|default:""}
                    {/strip}</a>
                    <a id="surveyItem{$page.id}_rel_{$page.Survey.id}Display" href="{modurl modname='SurveyManager' type='user' func='display' ot='survey' id=$page.Survey.id slug=$page.Survey.slug theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
                    <script type="text/javascript">
                    /* <![CDATA[ */
                        document.observe('dom:loaded', function() {
                            surveymanInitInlineWindow($('surveyItem{{$page.id}}_rel_{{$page.Survey.id}}Display'), '{{$page.Survey->getTitleFromDisplayPattern()|replace:"'":""}}');
                        });
                    /* ]]> */
                    </script>
                {else}
                    {gt text='Not set.'}
                {/if}
            </td>
            <td id="itemActions{$page.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                {if count($page._actions) gt 0}
                    {foreach item='option' from=$page._actions}
                        <a href="{$option.url.type|surveymanagerActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                    {/foreach}
                    {icon id="itemActions`$page.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                    <script type="text/javascript">
                    /* <![CDATA[ */
                        document.observe('dom:loaded', function() {
                            surveymanInitItemActions('page', 'view', 'itemActions{{$page.id}}');
                        });
                    /* ]]> */
                    </script>
                {/if}
            </td>
        </tr>
    {foreachelse}
        <tr class="z-datatableempty">
          <td class="z-left" colspan="5">
        {gt text='No pages found.'}
          </td>
        </tr>
    {/foreach}
    
        </tbody>
    </table>
    
    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='SurveyManager' type='user' func='view' ot='page'}
    {/if}

    
    {notifydisplayhooks eventname='surveymanager.ui_hooks.pages.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
{include file='user/footer.tpl'}
