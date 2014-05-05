{* purpose of this template: response datas view xml view in admin area *}
{surveymanagerTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<responseDatas>
{foreach item='item' from=$items}
    {include file='admin/responseData/include.xml'}
{foreachelse}
    <noResponseData />
{/foreach}
</responseDatas>
