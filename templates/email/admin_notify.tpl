<h1>{gt text='Survey Response Report'}</h1>


<p>You have received a new response from the survey called "{$survey.name}". The Response ID is <strong>{$response.id}</strong>.</p>

{foreach item='question' from=$questions}
<div class="surveymanager_email_form_row">
    <strong>{$question.name}</strong>
    <div>
        {assign var='questionType' value=$question.questionType}
        {$questionHandlers[$questionType]->getPreviewOutput($question.response)}
    </div>
</div>
{/foreach}