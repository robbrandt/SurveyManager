{* Purpose of this template: Display response datas in html mailings *}
{*
<ul>
{foreach item='responseData' from=$items}
    <li>
        <a href="{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$responseData.id fqurl=true}">{$responseData->getTitleFromDisplayPattern()}
        </a>
    </li>
{foreachelse}
    <li>{gt text='No response datas found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_responseData_display_description.tpl'}
