{* purpose of this template: inclusion template for display of related surveys in user area *}
{checkpermission component='SurveyManager:Survey:' instance='::' level='ACCESS_EDIT' assign='hasAdminPermission'}
{checkpermission component='SurveyManager:Survey:' instance='::' level='ACCESS_EDIT' assign='hasEditPermission'}
{if !isset($nolink)}
    {assign var='nolink' value=false}
{/if}
{if isset($items) && $items ne null && count($items) gt 0}
<ul class="surveymanager-related-item-list survey">
{foreach name='relLoop' item='item' from=$items}
{if $hasAdminPermission || $item.workflowState eq 'approved'}
    <li>
{strip}
{if !$nolink}
    <a href="{modurl modname='SurveyManager' type='user' func='display' ot='survey' id=$item.id slug=$item.slug}" title="{$item->getTitleFromDisplayPattern()|replace:"\"":""}">
{/if}
    {$item->getTitleFromDisplayPattern()}
{if !$nolink}
    </a>
    <a id="surveyItem{$item.id}Display" href="{modurl modname='SurveyManager' type='user' func='display' ot='survey' id=$item.id slug=$item.slug theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
{/if}
{/strip}
{if !$nolink}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        surveymanInitInlineWindow($('surveyItem{{$item.id}}Display'), '{{$item->getTitleFromDisplayPattern()|replace:"'":""}}');
    });
/* ]]> */
</script>
{/if}
    </li>
{/if}
{/foreach}
</ul>
{/if}
