{* Purpose of this template: Display surveys within an external context *}
{foreach item='survey' from=$items}
    <h3>{$survey->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$survey.id slug=$survey.slug}">{gt text='Read more'}</a>
    </p>
{/foreach}
