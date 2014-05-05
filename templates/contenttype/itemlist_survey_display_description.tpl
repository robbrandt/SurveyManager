{* Purpose of this template: Display surveys within an external context *}
<dl>
    {foreach item='survey' from=$items}
        <dt>{$survey->getTitleFromDisplayPattern()}</dt>
        {if $survey.description}
            <dd>{$survey.description|strip_tags|truncate:200:'&hellip;'}</dd>
        {/if}
        <dd><a href="{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$survey.id slug=$survey.slug}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
