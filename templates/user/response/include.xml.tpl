{* purpose of this template: responses xml inclusion template in user area *}
<response id="{$item.id}" createdon="{$item.createdDate|dateformat}" updatedon="{$item.updatedDate|dateformat}">
    <id>{$item.id}</id>
    <ipAddress><![CDATA[{$item.ipAddress}]]></ipAddress>
    <responseTimestamp>{$item.responseTimestamp}</responseTimestamp>
    <featured>{if !$item.featured}0{else}1{/if}</featured>
    <workflowState>{$item.workflowState|surveymanagerObjectState:false|lower}</workflowState>
    <survey>{if isset($item.Survey) && $item.Survey ne null}{$item.Survey->getTitleFromDisplayPattern()|default:''}{/if}</survey>
    <answers>
    {if isset($item.Answers) && $item.Answers ne null}
        {foreach name='relationLoop' item='relatedItem' from=$item.Answers}
        <responseData>{$relatedItem->getTitleFromDisplayPattern()|default:''}</responseData>
        {/foreach}
    {/if}
    </answers>
</response>
