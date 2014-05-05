{* purpose of this template: surveys xml inclusion template in user area *}
<survey id="{$item.id}" createdon="{$item.createdDate|dateformat}" updatedon="{$item.updatedDate|dateformat}">
    <id>{$item.id}</id>
    <name><![CDATA[{$item.name}]]></name>
    <description><![CDATA[{$item.description}]]></description>
    <thankYou><![CDATA[{$item.thankYou}]]></thankYou>
    <thankYouTitle><![CDATA[{$item.thankYouTitle}]]></thankYouTitle>
    <thankYouAlternativeUrl>{$item.thankYouAlternativeUrl}</thankYouAlternativeUrl>
    <weight>{$item.weight}</weight>
    <maxPerIp>{$item.maxPerIp}</maxPerIp>
    <maxPerUserId>{$item.maxPerUserId}</maxPerUserId>
    <useCaptcha>{if !$item.useCaptcha}0{else}1{/if}</useCaptcha>
    <recipients>{$item.recipients}</recipients>
    <responseSubject><![CDATA[{$item.responseSubject}]]></responseSubject>
    <confirmationSubject><![CDATA[{$item.confirmationSubject}]]></confirmationSubject>
    <confirmationBody><![CDATA[{$item.confirmationBody}]]></confirmationBody>
    <archived>{if !$item.archived}0{else}1{/if}</archived>
    <template>{if !$item.template}0{else}1{/if}</template>
    <addition1><![CDATA[{$item.addition1}]]></addition1>
    <addition2><![CDATA[{$item.addition2}]]></addition2>
    <addition3><![CDATA[{$item.addition3}]]></addition3>
    <addition4><![CDATA[{$item.addition4}]]></addition4>
    <addition5><![CDATA[{$item.addition5}]]></addition5>
    <workflowState>{$item.workflowState|surveymanagerObjectState:false|lower}</workflowState>
    <pages>
    {if isset($item.Pages) && $item.Pages ne null}
        {foreach name='relationLoop' item='relatedItem' from=$item.Pages}
        <page>{$relatedItem->getTitleFromDisplayPattern()|default:''}</page>
        {/foreach}
    {/if}
    </pages>
    <responses>
    {if isset($item.Responses) && $item.Responses ne null}
        {foreach name='relationLoop' item='relatedItem' from=$item.Responses}
        <response>{$relatedItem->getTitleFromDisplayPattern()|default:''}</response>
        {/foreach}
    {/if}
    </responses>
</survey>
