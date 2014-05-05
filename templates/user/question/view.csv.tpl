{* purpose of this template: questions view csv view in user area *}
{surveymanagerTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true filename='Questions.csv'}
{strip}"{gt text='Name'}";"{gt text='Description'}";"{gt text='Weight'}";"{gt text='Question type'}";"{gt text='Question values'}";"{gt text='Correct values'}";"{gt text='Required'}";"{gt text='Dependencies'}";"{gt text='Workflow state'}"
;"{gt text='Page'}"
;"{gt text='Answers'}"
{/strip}
{foreach item='question' from=$items}
{strip}
    "{$question.name}";"{$question.description}";"{$question.weight}";"{$question.questionType}";"{$question.questionValues}";"{$question.correctValues}";"{if !$question.required}0{else}1{/if}";"{$question.dependencies}";"{$item.workflowState|surveymanagerObjectState:false|lower}"
    ;"{if isset($question.Page) && $question.Page ne null}{$question.Page->getTitleFromDisplayPattern()|default:''}{/if}"
    ;"
        {if isset($question.Answers) && $question.Answers ne null}
            {foreach name='relationLoop' item='relatedItem' from=$question.Answers}
            {$relatedItem->getTitleFromDisplayPattern()|default:''}{if !$smarty.foreach.relationLoop.last}, {/if}
            {/foreach}
        {/if}
    "
{/strip}
{/foreach}
