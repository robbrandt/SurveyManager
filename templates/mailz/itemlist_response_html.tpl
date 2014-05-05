{* Purpose of this template: Display responses in html mailings *}
{*
<ul>
{foreach item='response' from=$items}
    <li>
        <a href="{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$response.id fqurl=true}">{$response->getTitleFromDisplayPattern()}
        </a>
    </li>
{foreachelse}
    <li>{gt text='No responses found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_response_display_description.tpl'}
