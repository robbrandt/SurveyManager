{* purpose of this template: questions xml inclusion template in admin area *}
<question id="{$item.id}" createdon="{$item.createdDate|dateformat}" updatedon="{$item.updatedDate|dateformat}">
    <id>{$item.id}</id>
    <name><![CDATA[{$item.name}]]></name>
    <description><![CDATA[{$item.description}]]></description>
    <weight>{$item.weight}</weight>
    <questionType><![CDATA[{$item.questionType}]]></questionType>
    <questionValues>{$item.questionValues}</questionValues>
    <correctValues>{$item.correctValues}</correctValues>
    <required>{if !$item.required}0{else}1{/if}</required>
    <dependencies>{$item.dependencies}</dependencies>
    <workflowState>{$item.workflowState|surveymanagerObjectState:false|lower}</workflowState>
    <page>{if isset($item.Page) && $item.Page ne null}{$item.Page->getTitleFromDisplayPattern()|default:''}{/if}</page>
    <answers>
    {if isset($item.Answers) && $item.Answers ne null}
        {foreach name='relationLoop' item='relatedItem' from=$item.Answers}
        <responseData>{$relatedItem->getTitleFromDisplayPattern()|default:''}</responseData>
        {/foreach}
    {/if}
    </answers>
</question>
