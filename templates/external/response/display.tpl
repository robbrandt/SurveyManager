{* Purpose of this template: Display one certain response within an external context *}
<div id="response{$response.id}" class="surveymanager-external-response">
{if $displayMode eq 'link'}
    <p class="surveymanager-external-link">
    <a href="{modurl modname='SurveyManager' type='user' func='display' ot='response' id=$response.id}" title="{$response->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$response->getTitleFromDisplayPattern()|notifyfilters:'surveymanager.filter_hooks.responses.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='SurveyManager::' instance='::' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="surveymanager-external-title">
            <strong>{$response->getTitleFromDisplayPattern()|notifyfilters:'surveymanager.filter_hooks.responses.filter'}</strong>
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
            {if $response.ipAddress ne ''}{$response.ipAddress}<br />{/if}
        </p>
    *}
{/if}
</div>
