{* Purpose of this template: Display one certain question within an external context *}
<div id="question{$question.id}" class="surveymanager-external-question">
{if $displayMode eq 'link'}
    <p class="surveymanager-external-link">
    <a href="{modurl modname='SurveyManager' type='user' func='display' ot='question' id=$question.id}" title="{$question->getTitleFromDisplayPattern()|replace:"\"":""}">
    {$question->getTitleFromDisplayPattern()|notifyfilters:'surveymanager.filter_hooks.questions.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='SurveyManager::' instance='::' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="surveymanager-external-title">
            <strong>{$question->getTitleFromDisplayPattern()|notifyfilters:'surveymanager.filter_hooks.questions.filter'}</strong>
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
            {if $question.description ne ''}{$question.description}<br />{/if}
        </p>
    *}
{/if}
</div>
