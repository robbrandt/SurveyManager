<h1>{$survey.confirmationSubject}</h1>

{$survey.confirmationBody}

<p>{gt text='Survey:'} "{$survey.name}".</p>

{foreach item='question' from=$questions}
<div class="surveymanager_email_form_row">
    <strong>{$question.name}</strong>
    <div>
        {assign var='questionType' value=$question.questionType}
        {$questionHandlers[$questionType]->getPreviewOutput($question.response)}
    </div>
</div>
{/foreach}