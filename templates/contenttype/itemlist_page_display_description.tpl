{* Purpose of this template: Display pages within an external context *}
<dl>
    {foreach item='page' from=$items}
        <dt>{$page->getTitleFromDisplayPattern()}</dt>
        {if $page.description}
            <dd>{$page.description|strip_tags|truncate:200:'&hellip;'}</dd>
        {/if}
        <dd><a href="{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$page.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
