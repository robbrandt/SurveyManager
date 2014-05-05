{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="survey{$survey.id}">
<dt>{$survey->getTitleFromDisplayPattern()|notifyfilters:'surveymanager.filter_hooks.surveys.filter'|htmlentities}</dt>
{if $survey.description ne ''}<dd>{$survey.description}</dd>{/if}
</dl>
