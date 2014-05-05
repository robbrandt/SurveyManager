{* Purpose of this template: Display questions in html mailings *}
{*
<ul>
{foreach item='question' from=$items}
    <li>
        <a href="{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$question.id fqurl=true}">{$question->getTitleFromDisplayPattern()}
        </a>
    </li>
{foreachelse}
    <li>{gt text='No questions found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_question_display_description.tpl'}
