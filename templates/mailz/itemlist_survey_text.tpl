{* Purpose of this template: Display surveys in text mailings *}
{foreach item='survey' from=$items}
{$survey->getTitleFromDisplayPattern()}
{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$survey.id slug=$survey.slug fqurl=true}
-----
{foreachelse}
{gt text='No surveys found.'}
{/foreach}
