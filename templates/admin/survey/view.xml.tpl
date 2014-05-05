{* purpose of this template: surveys view xml view in admin area *}
{surveymanagerTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
<surveys>
{foreach item='item' from=$items}
    {include file='admin/survey/include.xml'}
{foreachelse}
    <noSurvey />
{/foreach}
</surveys>
