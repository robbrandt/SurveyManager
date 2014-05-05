{* purpose of this template: responses view view in user area *}
{include file='user/header.tpl'}
<div class="surveymanager-response surveymanager-view">
{gt text='Results' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>

    <div class="z-form">
        <div class="z-formrow">
            <label for="rid">{gt text='Response ID'}</label>
            <input type="text" id="response_id" name="response_id" size="10" maxlength="10" value="{$response.id}" disabled="disabled" />
        </div>
        <div class="z-formrow">
            <label for="timestamp">{gt text='Submitted on'}</label>
            <input type="text" id="response_timestamp" name="response_timestamp" size="40" value="{$response.responseTimestamp|format_date:'m/d/Y g:s A'|safetext}" disabled="disabled" />
        </div>
        <div class="surveymanager_clearance">&nbsp;</div>

        <h3>{gt text='Response data:'}</h3>
        {foreach item='datum' from=$response.answers}
        {assign var='questionId' value=$datum.question.id}
        {assign var='questionType' value=$datum.question.questionType}
        {assign var='question' value=$questions.$questionId}
        <div class="z-formrow">
            <strong>{$question.name}</strong>
            <div>
                {$questionHandlers.$questionType->getPreviewOutput($datum.responseValue)}
            </div>
        </div>
        {/foreach}
    </div>
    <div class="surveymanager_clearance">&nbsp;</div>
</div>
</div>
{include file='user/footer.tpl'}

