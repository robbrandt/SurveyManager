{* Purpose of this template: Display responses within an external context *}
<dl>
    {foreach item='response' from=$items}
        <dt>{$response->getTitleFromDisplayPattern()}</dt>
        <dd><a href="{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$response.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
