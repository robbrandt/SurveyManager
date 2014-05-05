{* Purpose of this template: Display questions within an external context *}
<dl>
    {foreach item='question' from=$items}
        <dt>{$question->getTitleFromDisplayPattern()}</dt>
        {if $question.description}
            <dd>{$question.description|strip_tags|truncate:200:'&hellip;'}</dd>
        {/if}
        <dd><a href="{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$question.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
