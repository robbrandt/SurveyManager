{* Purpose of this template: Display response datas within an external context *}
{foreach item='responseData' from=$items}
    <h3>{$responseData->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$responseData.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
