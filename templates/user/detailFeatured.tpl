{* purpose of this template: show output of detail featured action in user area *}
<div class="surveymanager-detailfeatured surveymanager-detailfeatured">
{gt text='Featured response' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer surveymanager_featured_response">
{if $response.name_id && $response.name_id ne ''}
    <h2>{$response.name_id|safetext} on {$response.responseTimestamp|dateformat:'datebrief'}</h2>
{else}
    <h2>Anonymous response on {$response.responseTimestamp|dateformat:'datebrief'}</h2>
{/if}

{foreach item='question' from=$questions}
    {assign var='questionId' value=$question.id}
    {assign var='questionType' value=$question.questionType}
    {assign var='responseData' value=$data.$questionId}
    <div class="z-formrow">
        <strong>{$question.name|safetext}</strong>
        <div>
            {$questionHandlers.$questionType->getPreviewOutput($responseData)}
        </div>
    </div>
{/foreach}
</div>
</div>
