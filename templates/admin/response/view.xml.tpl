{* purpose of this template: responses view xml view in admin area *}
{surveymanagerTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<responses>
{foreach item='item' from=$items}
    {include file='admin/response/include.xml'}
{foreachelse}
    <noResponse />
{/foreach}
</responses>
