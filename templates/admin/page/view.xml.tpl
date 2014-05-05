{* purpose of this template: pages view xml view in admin area *}
{surveymanagerTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<pages>
{foreach item='item' from=$items}
    {include file='admin/page/include.xml'}
{foreachelse}
    <noPage />
{/foreach}
</pages>
