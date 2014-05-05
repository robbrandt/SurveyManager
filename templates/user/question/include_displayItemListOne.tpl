{* purpose of this template: inclusion template for display of related questions in user area *}
{checkpermission component='SurveyManager:Question:' instance='::' level='ACCESS_EDIT' assign='hasAdminPermission'}
{checkpermission component='SurveyManager:Question:' instance='::' level='ACCESS_EDIT' assign='hasEditPermission'}
{if !isset($nolink)}
    {assign var='nolink' value=false}
{/if}
<h4>
{strip}
{if !$nolink}
    <a href="{modurl modname='SurveyManager' type='user' func='display' ot='question' id=$item.id}" title="{$item->getTitleFromDisplayPattern()|replace:"\"":""}">
{/if}
    {$item->getTitleFromDisplayPattern()}
{if !$nolink}
    </a>
    <a id="questionItem{$item.id}Display" href="{modurl modname='SurveyManager' type='user' func='display' ot='question' id=$item.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
{/if}
{/strip}
</h4>
{if !$nolink}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        surveymanInitInlineWindow($('questionItem{{$item.id}}Display'), '{{$item->getTitleFromDisplayPattern()|replace:"'":""}}');
    });
/* ]]> */
</script>
{/if}
