{* purpose of this template: responses view csv view in user area *}
{surveymanagerTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true filename='Responses.csv'}
{strip}"{gt text='Ip address'}";"{gt text='Response timestamp'}";"{gt text='Featured'}";"{gt text='Workflow state'}"
;"{gt text='Survey'}"
;"{gt text='Answers'}"
{/strip}
{foreach item='response' from=$items}
{strip}
    "{$response.ipAddress}";"{$response.responseTimestamp}";"{if !$response.featured}0{else}1{/if}";"{$item.workflowState|surveymanagerObjectState:false|lower}"
    ;"{if isset($response.Survey) && $response.Survey ne null}{$response.Survey->getTitleFromDisplayPattern()|default:''}{/if}"
    ;"
        {if isset($response.Answers) && $response.Answers ne null}
            {foreach name='relationLoop' item='relatedItem' from=$response.Answers}
            {$relatedItem->getTitleFromDisplayPattern()|default:''}{if !$smarty.foreach.relationLoop.last}, {/if}
            {/foreach}
        {/if}
    "
{/strip}
{/foreach}
