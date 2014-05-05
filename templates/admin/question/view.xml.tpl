{* purpose of this template: questions view xml view in admin area *}
{surveymanagerTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<questions>
{foreach item='item' from=$items}
    {include file='admin/question/include.xml'}
{foreachelse}
    <noQuestion />
{/foreach}
</questions>
