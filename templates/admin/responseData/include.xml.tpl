{* purpose of this template: response datas xml inclusion template in admin area *}
<responsedata id="{$item.id}" createdon="{$item.createdDate|dateformat}" updatedon="{$item.updatedDate|dateformat}">
    <id>{$item.id}</id>
    <responseValue><![CDATA[{$item.responseValue}]]></responseValue>
    <grade>{$item.grade}</grade>
    <correctness>{$item.correctness}</correctness>
    <workflowState>{$item.workflowState|surveymanagerObjectState:false|lower}</workflowState>
    <response>{if isset($item.Response) && $item.Response ne null}{$item.Response->getTitleFromDisplayPattern()|default:''}{/if}</response>
    <question>{if isset($item.Question) && $item.Question ne null}{$item.Question->getTitleFromDisplayPattern()|default:''}{/if}</question>
</responsedata>
