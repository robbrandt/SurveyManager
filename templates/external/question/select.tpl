{* Purpose of this template: Display a popup selector for Forms and Content integration *}
{assign var='baseID' value='question'}
<div id="{$baseID}Preview" style="float: right; width: 300px; border: 1px dotted #a3a3a3; padding: .2em .5em; margin-right: 1em">
    <p><strong>{gt text='Question information'}</strong></p>
    {img id='ajax_indicator' modname='core' set='ajax' src='indicator_circle.gif' alt='' class='z-hide'}
    <div id="{$baseID}PreviewContainer">&nbsp;</div>
</div>
<br />
<br />
{assign var='leftSide' value=' style="float: left; width: 10em"'}
{assign var='rightSide' value=' style="float: left"'}
{assign var='break' value=' style="clear: left"'}
<p>
    <label for="{$baseID}Id"{$leftSide}>{gt text='Question'}:</label>
    <select id="{$baseID}Id" name="id"{$rightSide}>
        {foreach item='question' from=$items}
            <option value="{$question.id}"{if $selectedId eq $question.id} selected="selected"{/if}>{$question->getTitleFromDisplayPattern()}</option>
        {foreachelse}
            <option value="0">{gt text='No entries found.'}</option>
        {/foreach}
    </select>
    <br{$break} />
</p>
<p>
    <label for="{$baseID}Sort"{$leftSide}>{gt text='Sort by'}:</label>
    <select id="{$baseID}Sort" name="sort"{$rightSide}>
        <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
        <option value="workflowState"{if $sort eq 'workflowState'} selected="selected"{/if}>{gt text='Workflow state'}</option>
        <option value="name"{if $sort eq 'name'} selected="selected"{/if}>{gt text='Name'}</option>
        <option value="description"{if $sort eq 'description'} selected="selected"{/if}>{gt text='Description'}</option>
        <option value="weight"{if $sort eq 'weight'} selected="selected"{/if}>{gt text='Weight'}</option>
        <option value="questionType"{if $sort eq 'questionType'} selected="selected"{/if}>{gt text='Question type'}</option>
        <option value="questionValues"{if $sort eq 'questionValues'} selected="selected"{/if}>{gt text='Question values'}</option>
        <option value="correctValues"{if $sort eq 'correctValues'} selected="selected"{/if}>{gt text='Correct values'}</option>
        <option value="required"{if $sort eq 'required'} selected="selected"{/if}>{gt text='Required'}</option>
        <option value="dependencies"{if $sort eq 'dependencies'} selected="selected"{/if}>{gt text='Dependencies'}</option>
        <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
        <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
        <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
    </select>
    <select id="{$baseID}SortDir" name="sortdir">
        <option value="asc"{if $sortdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
        <option value="desc"{if $sortdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
    </select>
    <br{$break} />
</p>
<p>
    <label for="{$baseID}SearchTerm"{$leftSide}>{gt text='Search for'}:</label>
    <input type="text" id="{$baseID}SearchTerm" name="searchterm"{$rightSide} />
    <input type="button" id="surveyManagerSearchGo" name="gosearch" value="{gt text='Filter'}" />
    <br{$break} />
</p>
<br />
<br />

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        surveymanager.itemSelector.onLoad('{{$baseID}}', {{$selectedId|default:0}});
    });
/* ]]> */
</script>
