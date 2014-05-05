{* Purpose of this template: Display questions in text mailings *}
{foreach item='question' from=$items}
{$question->getTitleFromDisplayPattern()}
{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$question.id fqurl=true}
-----
{foreachelse}
{gt text='No questions found.'}
{/foreach}
