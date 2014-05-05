{* purpose of this template: response datas view csv view in admin area *}
{surveymanagerTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true filename='ResponseDatas.csv'}
{strip}"{gt text='Response value'}";"{gt text='Grade'}";"{gt text='Correctness'}";"{gt text='Workflow state'}"
;"{gt text='Response'}";"{gt text='Question'}"
{/strip}
{foreach item='responseData' from=$items}
{strip}
    "{$responseData.responseValue}";"{$responseData.grade}";"{$responseData.correctness}";"{$item.workflowState|surveymanagerObjectState:false|lower}"
    ;"{if isset($responseData.Response) && $responseData.Response ne null}{$responseData.Response->getTitleFromDisplayPattern()|default:''}{/if}";"{if isset($responseData.Question) && $responseData.Question ne null}{$responseData.Question->getTitleFromDisplayPattern()|default:''}{/if}"
{/strip}
{/foreach}
