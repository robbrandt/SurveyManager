{* Purpose of this template: Display surveys in html mailings *}
{*
<ul>
{foreach item='survey' from=$items}
    <li>
        <a href="{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$survey.id slug=$survey.slug fqurl=true}">{$survey->getTitleFromDisplayPattern()}
        </a>
    </li>
{foreachelse}
    <li>{gt text='No surveys found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_survey_display_description.tpl'}
