<div class="surveymanager_featured_response">
{if $response.name_id && $response.name_id ne ''}
    <h2>{$response.name_id|safetext} on {$response.responseTimestamp|dateformat:'datebrief'}</h2>
{else}
    <h2>Anonymous response on {$response.responseTimestamp|dateformat:'datebrief'}</h2>
{/if}

{assign var='responseId' value=$response.id}
{foreach key='questionId' item='question' from=$questions}
    {assign var='questionType' value=$question.questionType}
    {assign var='responseValue' value=$question.responses.$responseId}
    <div class="z-formrow">
        <strong>{$question.name|safetext}</strong>
        <div>
            {$questionHandlers.$questionType->getPreviewOutput($responseValue)}
        </div>
    </div>
{/foreach}
</div>