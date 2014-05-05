{* Purpose of this template: Display questions within an external context *}
{foreach item='question' from=$items}
    <h3>{$question->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$question.id}">{gt text='Read more'}</a>
    </p>
{/foreach}
