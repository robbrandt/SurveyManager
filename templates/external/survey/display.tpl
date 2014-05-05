{* Purpose of this template: Display one certain survey within an external context *}
<div id="survey{$survey.id}" class="surveymanager-external-survey">
{if $displayMode eq 'link'}
    <p class="surveymanager-external-link">
    <a href="{modurl modname='SurveyManager' type='user' func='display' ot='survey' id=$survey.id slug=$survey.slug}" title="{$survey->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$survey->getTitleFromDisplayPattern()|notifyfilters:'surveymanager.filter_hooks.surveys.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='SurveyManager::' instance='::' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="surveymanager-external-title">
            <strong>{$survey->getTitleFromDisplayPattern()|notifyfilters:'surveymanager.filter_hooks.surveys.filter'}</strong>
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
            {if $survey.description ne ''}{$survey.description}<br />{/if}
        </p>
    *}
{/if}
</div>
