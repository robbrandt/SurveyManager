{* purpose of this template: pages view csv view in admin area *}
{surveymanagerTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true filename='Pages.csv'}
{strip}"{gt text='Name'}";"{gt text='Description'}";"{gt text='Weight'}";"{gt text='Workflow state'}"
;"{gt text='Survey'}"
;"{gt text='Questions'}"
{/strip}
{foreach item='page' from=$items}
{strip}
    "{$page.name}";"{$page.description}";"{$page.weight}";"{$item.workflowState|surveymanagerObjectState:false|lower}"
    ;"{if isset($page.Survey) && $page.Survey ne null}{$page.Survey->getTitleFromDisplayPattern()|default:''}{/if}"
    ;"
        {if isset($page.Questions) && $page.Questions ne null}
            {foreach name='relationLoop' item='relatedItem' from=$page.Questions}
            {$relatedItem->getTitleFromDisplayPattern()|default:''}{if !$smarty.foreach.relationLoop.last}, {/if}
            {/foreach}
        {/if}
    "
{/strip}
{/foreach}
