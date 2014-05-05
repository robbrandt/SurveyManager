{* Purpose of this template: Display responses within an external context *}
{foreach item='response' from=$items}
    <h3>{$response->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$response.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
