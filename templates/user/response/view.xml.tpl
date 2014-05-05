{* purpose of this template: responses view xml view in user area *}
{surveymanagerTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<responses>
{foreach item='item' from=$items}
    {include file='user/response/include.xml'}
{foreachelse}
    <noResponse />
{/foreach}
</responses>
