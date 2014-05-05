{* Purpose of this template: Display pages within an external context *}
{foreach item='page' from=$items}
    <h3>{$page->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$page.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
