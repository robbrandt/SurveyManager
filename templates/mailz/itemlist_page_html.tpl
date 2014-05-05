{* Purpose of this template: Display pages in html mailings *}
{*
<ul>
{foreach item='page' from=$items}
    <li>
        <a href="{modurl modname='SurveyManager' type='user' func='display' ot=$objectType id=$page.id fqurl=true}">{$page->getTitleFromDisplayPattern()}
        </a>
    </li>
{foreachelse}
    <li>{gt text='No pages found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_page_display_description.tpl'}
