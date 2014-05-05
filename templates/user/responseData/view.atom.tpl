{* purpose of this template: response datas atom feed in user area *}
{surveymanagerTemplateHeaders contentType='application/atom+xml'}<?xml version="1.0" encoding="{charset assign='charset'}{if $charset eq 'ISO-8859-15'}ISO-8859-1{else}{$charset}{/if}" ?>
<feed xmlns="http://www.w3.org/2005/Atom">
{gt text='Latest response datas' assign='channelTitle'}
{gt text='A direct feed showing the list of response datas' assign='channelDesc'}
    <title type="text">{$channelTitle}</title>
    <subtitle type="text">{$channelDesc} - {$modvars.ZConfig.slogan}</subtitle>
    <author>
        <name>{$modvars.ZConfig.sitename}</name>
    </author>
{assign var='numItems' value=$items|@count}
{if $numItems}
{capture assign='uniqueID'}tag:{$baseurl|replace:'http://':''|replace:'/':''},{$items[0].createdDate|dateformat|default:$smarty.now|dateformat:'%Y-%m-%d'}:{modurl modname='SurveyManager' type='user' func='display' ot='responseData' id=$items[0].id}{/capture}
    <id>{$uniqueID}</id>
    <updated>{$items[0].updatedDate|default:$smarty.now|dateformat:'%Y-%m-%dT%H:%M:%SZ'}</updated>
{/if}
    <link rel="alternate" type="text/html" hreflang="{lang}" href="{modurl modname='SurveyManager' type='user' func='main' fqurl=1}" />
    <link rel="self" type="application/atom+xml" href="{php}echo substr(\System::getBaseURL(), 0, strlen(\System::getBaseURL())-1);{/php}{getcurrenturi}" />
    <rights>Copyright (c) {php}echo date('Y');{/php}, {$baseurl}</rights>

{foreach item='responseData' from=$items}
    <entry>
        <title type="html">{$responseData->getTitleFromDisplayPattern()|notifyfilters:'surveymanager.filterhook.responsedatas'}</title>
        <link rel="alternate" type="text/html" href="{modurl modname='SurveyManager' type='user' func='display' ot='responseData' id=$responseData.id fqurl='1'}" />

        {capture assign='uniqueID'}tag:{$baseurl|replace:'http://':''|replace:'/':''},{$responseData.createdDate|dateformat|default:$smarty.now|dateformat:'%Y-%m-%d'}:{modurl modname='SurveyManager' type='user' func='display' ot='responseData' id=$responseData.id}{/capture}
        <id>{$uniqueID}</id>
        {if isset($responseData.updatedDate) && $responseData.updatedDate ne null}
            <updated>{$responseData.updatedDate|dateformat:'%Y-%m-%dT%H:%M:%SZ'}</updated>
        {/if}
        {if isset($responseData.createdDate) && $responseData.createdDate ne null}
            <published>{$responseData.createdDate|dateformat:'%Y-%m-%dT%H:%M:%SZ'}</published>
        {/if}
        {if isset($responseData.createdUserId)}
            {usergetvar name='uname' uid=$responseData.createdUserId assign='cr_uname'}
            {usergetvar name='name' uid=$responseData.createdUserId assign='cr_name'}
            <author>
               <name>{$cr_name|default:$cr_uname}</name>
               <uri>{usergetvar name='_UYOURHOMEPAGE' uid=$responseData.createdUserId assign='homepage'}{$homepage|default:'-'}</uri>
               <email>{usergetvar name='email' uid=$responseData.createdUserId}</email>
            </author>
        {/if}

        <summary type="html">
            <![CDATA[
            {$responseData->getTitleFromDisplayPattern()|truncate:150:"&hellip;"|default:'-'}
            ]]>
        </summary>
        <content type="html">
            <![CDATA[
            {$responseData->getTitleFromDisplayPattern()|replace:'<br>':'<br />'}
            ]]>
        </content>
    </entry>
{/foreach}
</feed>
