{* purpose of this template: surveys view csv view in admin area *}
{surveymanagerTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true filename='Surveys.csv'}
{strip}"{gt text='Name'}";"{gt text='Description'}";"{gt text='Thank you'}";"{gt text='Thank you title'}";"{gt text='Thank you alternative url'}";"{gt text='Weight'}";"{gt text='Max per ip'}";"{gt text='Max per user id'}";"{gt text='Use captcha'}";"{gt text='Recipients'}";"{gt text='Response subject'}";"{gt text='Confirmation subject'}";"{gt text='Confirmation body'}";"{gt text='Archived'}";"{gt text='Template'}";"{gt text='Addition1'}";"{gt text='Addition2'}";"{gt text='Addition3'}";"{gt text='Addition4'}";"{gt text='Addition5'}";"{gt text='Workflow state'}"
;"{gt text='Pages'}";"{gt text='Responses'}"
{/strip}
{foreach item='survey' from=$items}
{strip}
    "{$survey.name}";"{$survey.description}";"{$survey.thankYou}";"{$survey.thankYouTitle}";"{$survey.thankYouAlternativeUrl}";"{$survey.weight}";"{$survey.maxPerIp}";"{$survey.maxPerUserId}";"{if !$survey.useCaptcha}0{else}1{/if}";"{$survey.recipients}";"{$survey.responseSubject}";"{$survey.confirmationSubject}";"{$survey.confirmationBody}";"{if !$survey.archived}0{else}1{/if}";"{if !$survey.template}0{else}1{/if}";"{$survey.addition1}";"{$survey.addition2}";"{$survey.addition3}";"{$survey.addition4}";"{$survey.addition5}";"{$item.workflowState|surveymanagerObjectState:false|lower}"
    ;"
        {if isset($survey.Pages) && $survey.Pages ne null}
            {foreach name='relationLoop' item='relatedItem' from=$survey.Pages}
            {$relatedItem->getTitleFromDisplayPattern()|default:''}{if !$smarty.foreach.relationLoop.last}, {/if}
            {/foreach}
        {/if}
    ";"
        {if isset($survey.Responses) && $survey.Responses ne null}
            {foreach name='relationLoop' item='relatedItem' from=$survey.Responses}
            {$relatedItem->getTitleFromDisplayPattern()|default:''}{if !$smarty.foreach.relationLoop.last}, {/if}
            {/foreach}
        {/if}
    "
{/strip}
{/foreach}
