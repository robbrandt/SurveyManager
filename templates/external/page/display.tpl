{* Purpose of this template: Display one certain page within an external context *}
<div id="page{$page.id}" class="surveymanager-external-page">
{if $displayMode eq 'link'}
    <p class="surveymanager-external-link">
    <a href="{modurl modname='SurveyManager' type='user' func='display' ot='page' id=$page.id}" title="{$page->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$page->getTitleFromDisplayPattern()|notifyfilters:'surveymanager.filter_hooks.pages.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='SurveyManager::' instance='::' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="surveymanager-external-title">
            <strong>{$page->getTitleFromDisplayPattern()|notifyfilters:'surveymanager.filter_hooks.pages.filter'}</strong>
        </p>
    {/if}
{/checkpermissionblock}

{if $displayMode eq 'link'}
{elseif $displayMode eq 'embed'}
    <div class="surveymanager-external-snippet">
        &nbsp;
    </div>

    {* you can distinguish the context like this: *}
    {*if $source eq 'contentType'}
        ...
    {elseif $source eq 'scribite'}
        ...
    {/if*}

    {* you can enable more details about the item: *}
    {*
        <p class="surveymanager-external-description">
            {if $page.description ne ''}{$page.description}<br />{/if}
        </p>
    *}
{/if}
</div>
