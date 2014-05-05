{* Purpose of this template: Display pages in text mailings *}
{foreach item='page' from=$items}
{$page->getTitleFromDisplayPattern()}
{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$page.id fqurl=true}
-----
{foreachelse}
{gt text='No pages found.'}
{/foreach}
