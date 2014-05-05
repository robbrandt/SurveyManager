{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="question{$question.id}">
<dt>{$question->getTitleFromDisplayPattern()|notifyfilters:'surveymanager.filter_hooks.questions.filter'|htmlentities}</dt>
{if $question.description ne ''}<dd>{$question.description}</dd>{/if}
</dl>
