{* Purpose of this template: Display response datas within an external context *}
<dl>
    {foreach item='responseData' from=$items}
        <dt>{$responseData->getTitleFromDisplayPattern()}</dt>
        {if $responseData.responseValue}
            <dd>{$responseData.responseValue|strip_tags|truncate:200:'&hellip;'}</dd>
        {/if}
        <dd><a href="{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$responseData.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
