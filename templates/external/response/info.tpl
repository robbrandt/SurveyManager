{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="response{$response.id}">
<dt>{$response->getTitleFromDisplayPattern()|notifyfilters:'surveymanager.filter_hooks.responses.filter'|htmlentities}</dt>
{if $response.ipAddress ne ''}<dd>{$response.ipAddress}</dd>{/if}
</dl>
