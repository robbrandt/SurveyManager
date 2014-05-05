{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="page{$page.id}">
<dt>{$page->getTitleFromDisplayPattern()|notifyfilters:'surveymanager.filter_hooks.pages.filter'|htmlentities}</dt>
{if $page.description ne ''}<dd>{$page.description}</dd>{/if}
</dl>
