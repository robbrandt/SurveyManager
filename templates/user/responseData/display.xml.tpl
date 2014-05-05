{* purpose of this template: response datas display xml view in user area *}
{surveymanagerTemplateHeaders contentType='text/xml'}<?xml version="1.0" encoding="{charset}" ?>
{getbaseurl assign='baseurl'}
{include file='user/responseData/include.xml' item=$responseData}
