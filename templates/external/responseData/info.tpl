{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="responseData{$responseData.id}">
<dt>{$responseData->getTitleFromDisplayPattern()|notifyfilters:'surveymanager.filter_hooks.responsedatas.filter'|htmlentities}</dt>
{if $responseData.responseValue ne ''}<dd>{$responseData.responseValue}</dd>{/if}
</dl>
