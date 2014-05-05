{* purpose of this template: pages view xml view in user area *}
{surveymanagerTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<pages>
{foreach item='item' from=$items}
    {include file='user/page/include.xml'}
{foreachelse}
    <noPage />
{/foreach}
</pages>
