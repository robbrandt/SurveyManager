{* Purpose of this template: Display a popup selector for Forms and Content integration *}
{assign var='baseID' value='survey'}
<div id="{$baseID}Preview" style="float: right; width: 300px; border: 1px dotted #a3a3a3; padding: .2em .5em; margin-right: 1em">
    <p><strong>{gt text='Survey information'}</strong></p>
    {img id='ajax_indicator' modname='core' set='ajax' src='indicator_circle.gif' alt='' class='z-hide'}
    <div id="{$baseID}PreviewContainer">&nbsp;</div>
</div>
<br />
<br />
{assign var='leftSide' value=' style="float: left; width: 10em"'}
{assign var='rightSide' value=' style="float: left"'}
{assign var='break' value=' style="clear: left"'}
<p>
    <label for="{$baseID}Id"{$leftSide}>{gt text='Survey'}:</label>
    <select id="{$baseID}Id" name="id"{$rightSide}>
        {foreach item='survey' from=$items}
            <option value="{$survey.id}"{if $selectedId eq $survey.id} selected="selected"{/if}>{$survey->getTitleFromDisplayPattern()}</option>
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
        <option value="thankYou"{if $sort eq 'thankYou'} selected="selected"{/if}>{gt text='Thank you'}</option>
        <option value="thankYouTitle"{if $sort eq 'thankYouTitle'} selected="selected"{/if}>{gt text='Thank you title'}</option>
        <option value="thankYouAlternativeUrl"{if $sort eq 'thankYouAlternativeUrl'} selected="selected"{/if}>{gt text='Thank you alternative url'}</option>
        <option value="weight"{if $sort eq 'weight'} selected="selected"{/if}>{gt text='Weight'}</option>
        <option value="maxPerIp"{if $sort eq 'maxPerIp'} selected="selected"{/if}>{gt text='Max per ip'}</option>
        <option value="maxPerUserId"{if $sort eq 'maxPerUserId'} selected="selected"{/if}>{gt text='Max per user id'}</option>
        <option value="useCaptcha"{if $sort eq 'useCaptcha'} selected="selected"{/if}>{gt text='Use captcha'}</option>
        <option value="recipients"{if $sort eq 'recipients'} selected="selected"{/if}>{gt text='Recipients'}</option>
        <option value="responseSubject"{if $sort eq 'responseSubject'} selected="selected"{/if}>{gt text='Response subject'}</option>
        <option value="confirmationSubject"{if $sort eq 'confirmationSubject'} selected="selected"{/if}>{gt text='Confirmation subject'}</option>
        <option value="confirmationBody"{if $sort eq 'confirmationBody'} selected="selected"{/if}>{gt text='Confirmation body'}</option>
        <option value="archived"{if $sort eq 'archived'} selected="selected"{/if}>{gt text='Archived'}</option>
        <option value="template"{if $sort eq 'template'} selected="selected"{/if}>{gt text='Template'}</option>
        <option value="addition1"{if $sort eq 'addition1'} selected="selected"{/if}>{gt text='Addition1'}</option>
        <option value="addition2"{if $sort eq 'addition2'} selected="selected"{/if}>{gt text='Addition2'}</option>
        <option value="addition3"{if $sort eq 'addition3'} selected="selected"{/if}>{gt text='Addition3'}</option>
        <option value="addition4"{if $sort eq 'addition4'} selected="selected"{/if}>{gt text='Addition4'}</option>
        <option value="addition5"{if $sort eq 'addition5'} selected="selected"{/if}>{gt text='Addition5'}</option>
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
