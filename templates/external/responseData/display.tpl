{* Purpose of this template: Display one certain response data within an external context *}
<div id="responseData{$responseData.id}" class="surveymanager-external-responsedata">
{if $displayMode eq 'link'}
    <p class="surveymanager-external-link">
    <a href="{modurl modname='SurveyManager' type='user' func='display' ot='responseData' id=$responseData.id}" title="{$responseData->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$responseData->getTitleFromDisplayPattern()|notifyfilters:'surveymanager.filter_hooks.responsedatas.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='SurveyManager::' instance='::' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="surveymanager-external-title">
            <strong>{$responseData->getTitleFromDisplayPattern()|notifyfilters:'surveymanager.filter_hooks.responsedatas.filter'}</strong>
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
            {if $responseData.responseValue ne ''}{$responseData.responseValue}<br />{/if}
        </p>
    *}
{/if}
</div>
