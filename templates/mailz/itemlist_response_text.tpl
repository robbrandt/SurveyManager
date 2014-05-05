{* Purpose of this template: Display responses in text mailings *}
{foreach item='response' from=$items}
{$response->getTitleFromDisplayPattern()}
{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$response.id fqurl=true}
-----
{foreachelse}
{gt text='No responses found.'}
{/foreach}
