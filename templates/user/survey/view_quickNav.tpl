{* purpose of this template: surveys view filter form in user area *}
{checkpermissionblock component='SurveyManager:Survey:' instance='.*' level='ACCESS_EDIT'}
<form action="{$modvars.ZConfig.entrypoint|default:'index.php'}" method="get" id="surveymanSurveyQuickNavForm" class="surveymanQuickNavForm">
    <fieldset>
        <h3>{gt text='Quick navigation'}</h3>
        <input type="hidden" name="module" value="{modgetinfo modname='SurveyManager' info='displayname'}" />
        <input type="hidden" name="type" value="user" />
        <input type="hidden" name="func" value="view" />
        <input type="hidden" name="ot" value="survey" />
        {gt text='All' assign='lblDefault'}
        {if !isset($searchFilter) || $searchFilter eq true}
            <label for="searchterm">{gt text='Search'}:</label>
            <input type="text" id="searchterm" name="searchterm" value="{$searchterm}" />
        {/if}
        {if !isset($sorting) || $sorting eq true}
            <label for="sortby">{gt text='Sort by'}</label>
            &nbsp;
            <select id="sortby" name="sort">
            <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
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
{if $modvars.SurveyManager.useAddition1}
            <option value="addition1"{if $sort eq 'addition1'} selected="selected"{/if}>{gt text='Addition1'}</option>
{/if}
{if $modvars.SurveyManager.useAddition2}
            <option value="addition2"{if $sort eq 'addition2'} selected="selected"{/if}>{gt text='Addition2'}</option>
{/if}
{if $modvars.SurveyManager.useAddition3}
            <option value="addition3"{if $sort eq 'addition3'} selected="selected"{/if}>{gt text='Addition3'}</option>
{/if}
{if $modvars.SurveyManager.useAddition4}
            <option value="addition4"{if $sort eq 'addition4'} selected="selected"{/if}>{gt text='Addition4'}</option>
{/if}
{if $modvars.SurveyManager.useAddition5}
            <option value="addition5"{if $sort eq 'addition5'} selected="selected"{/if}>{gt text='Addition5'}</option>
{/if}
            <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
            <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
            <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
            </select>
            <select id="sortdir" name="sortdir">
                <option value="asc"{if $sdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
                <option value="desc"{if $sdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
            </select>
        {else}
            <input type="hidden" name="sort" value="{$sort}" />
            <input type="hidden" name="sdir" value="{if $sdir eq 'desc'}asc{else}desc{/if}" />
        {/if}
        {if !isset($pageSizeSelector) || $pageSizeSelector eq true}
            {assign var='pageSize' value=$pager.itemsperpage}
            <label for="num">{gt text='Page size'}</label>
            &nbsp;
            <select id="num" name="num">
                <option value="5"{if $pageSize eq 5} selected="selected"{/if}>5</option>
                <option value="10"{if $pageSize eq 10} selected="selected"{/if}>10</option>
                <option value="15"{if $pageSize eq 15} selected="selected"{/if}>15</option>
                <option value="20"{if $pageSize eq 20} selected="selected"{/if}>20</option>
                <option value="30"{if $pageSize eq 30} selected="selected"{/if}>30</option>
                <option value="50"{if $pageSize eq 50} selected="selected"{/if}>50</option>
                <option value="100"{if $pageSize eq 100} selected="selected"{/if}>100</option>
            </select>
        {/if}
        {if !isset($useCaptchaFilter) || $useCaptchaFilter eq true}
            <label for="useCaptcha">{gt text='Use captcha'}</label>
            <select id="useCaptcha" name="useCaptcha">
                <option value="">{$lblDefault}</option>
            {foreach item='option' from=$useCaptchaItems}
                <option value="{$option.value}"{if $option.value eq $useCaptcha} selected="selected"{/if}>{$option.text|safetext}</option>
            {/foreach}
            </select>
        {/if}
        {if !isset($archivedFilter) || $archivedFilter eq true}
            <label for="archived">{gt text='Archived'}</label>
            <select id="archived" name="archived">
                <option value="">{$lblDefault}</option>
            {foreach item='option' from=$archivedItems}
                <option value="{$option.value}"{if $option.value eq $archived} selected="selected"{/if}>{$option.text|safetext}</option>
            {/foreach}
            </select>
        {/if}
        {if !isset($templateFilter) || $templateFilter eq true}
            <label for="template">{gt text='Template'}</label>
            <select id="template" name="template">
                <option value="">{$lblDefault}</option>
            {foreach item='option' from=$templateItems}
                <option value="{$option.value}"{if $option.value eq $template} selected="selected"{/if}>{$option.text|safetext}</option>
            {/foreach}
            </select>
        {/if}
        <input type="submit" name="updateview" id="quicknav_submit" value="{gt text='OK'}" />
    </fieldset>
</form>

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        surveymanInitQuickNavigation('survey', 'user');
        {{if isset($searchFilter) && $searchFilter eq false}}
            {{* we can hide the submit button if we have no quick search field *}}
            $('quicknav_submit').addClassName('z-hide');
        {{/if}}
    });
/* ]]> */
</script>
{/checkpermissionblock}
