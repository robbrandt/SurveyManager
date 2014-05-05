{* purpose of this template: pages xml inclusion template in admin area *}
<page id="{$item.id}" createdon="{$item.createdDate|dateformat}" updatedon="{$item.updatedDate|dateformat}">
    <id>{$item.id}</id>
    <name><![CDATA[{$item.name}]]></name>
    <description><![CDATA[{$item.description}]]></description>
    <weight>{$item.weight}</weight>
    <workflowState>{$item.workflowState|surveymanagerObjectState:false|lower}</workflowState>
    <survey>{if isset($item.Survey) && $item.Survey ne null}{$item.Survey->getTitleFromDisplayPattern()|default:''}{/if}</survey>
    <questions>
    {if isset($item.Questions) && $item.Questions ne null}
        {foreach name='relationLoop' item='relatedItem' from=$item.Questions}
        <question>{$relatedItem->getTitleFromDisplayPattern()|default:''}</question>
        {/foreach}
    {/if}
    </questions>
</page>
