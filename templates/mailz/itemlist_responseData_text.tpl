{* Purpose of this template: Display response datas in text mailings *}
{foreach item='responseData' from=$items}
{$responseData->getTitleFromDisplayPattern()}
{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$responseData.id fqurl=true}
-----
{foreachelse}
{gt text='No response datas found.'}
{/foreach}
