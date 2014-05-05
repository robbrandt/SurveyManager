{* purpose of this template: build the Form to edit an instance of response *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/SurveyManager/javascript/SurveyManager_editFunctions.js'}
{pageaddvar name='javascript' value='modules/SurveyManager/javascript/SurveyManager_validation.js'}
{pageaddvar name='stylesheet' value='modules/SurveyManager/style/manual.css'}

{if $mode eq 'edit'}
    {gt text='Edit response' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create response' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit response' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="surveymanager-response surveymanager-edit">
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type=$adminPageIcon size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>
{form cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {surveymanagerFormFrame}

    {formsetinitialfocus inputId='ipAddress'}

    <div class="z-informationmsg">
        <p>{gt text='Update information about the response here.'}</p>
    </div>

    <fieldset>
        <legend>{gt text='Content'}</legend>

        <input type="hidden" name="MAX_FILE_SIZE" id="MAX_FILE_SIZE" value="{$maxFileSizeB}" />
    {if $mode ne 'create'}
{*        <div class="z-formrow">
            {formlabel for='id' __text='Response ID'}
            {formtextinput group='response' id='id' readOnly=false textMode='singleline' maxLength=40 disabled=true}
        </div>
*}
        <div class="z-formrow">
            <label for="response_id">{gt text='Response ID'}</label>
            <input type="text" id="response_id" name="response_id" size="10" maxlength="10" value="{$response.id}" disabled="disabled" />
        </div>
    {/if}
{*        <div class="z-formrow">
            {formlabel for='ipAddress' __text='Ip address' mandatorysym='1'}
            {formtextinput group='response' id='ipAddress' mandatory=true readOnly=false __title='Enter the ip address of the response' textMode='singleline' maxLength=40 cssClass='required' }
            {surveymanagerValidationError id='ipAddress' class='required'}
        </div>
*}
    {if $modvars.SurveyManager.useFeaturedResponses}
{*        <div class="z-formrow">
            {formlabel for='featured' __text='Featured'}
            {formcheckbox group='response' id='featured' readOnly=false __title='featured ?' cssClass='' }
        </div>
*}
        <div class="z-formrow">
            <label for="response_featured">{gt text='Featured'}</label>
            <input type="checkbox" id="response_featured" name="response_featured" value="1"{if $response.featured} checked="checked"{/if}  />
            <div class="z-formnote">{gt text='Include this in "Featured Responses"'}</div>
        </div>
    {/if}
{*        <div class="z-formrow">
            {formlabel for='responseTimestamp' __text='Response timestamp'}
            {formintinput group='response' id='responseTimestamp' mandatory=false __title='Enter the response timestamp of the response' maxLength=11 cssClass=' validate-digits' }
            {surveymanagerValidationError id='responseTimestamp' class='validate-digits'}
        </div>
*}
        <div class="z-formrow">
            <label for="response_timestamp">{gt text='Submitted on'}</label>
            <input type="text" id="response_timestamp" name="response_timestamp" size="40" value="{$response.timestamp|dateformat:'m/d/Y g:s A'|safetext}" disabled="disabled" />
        </div>
    </fieldset>

    {*if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$response}
    {/if*}
    {*include file='admin/survey/include_selectOne.tpl' relItem=$response aliasName='survey' idPrefix='surveymanResponse_Survey'*}
    
    {* include return control * }
    {if $mode eq 'create'}
        <fieldset>
            <legend>{gt text='Return control'}</legend>
            <div class="z-formrow">
                {formlabel for='repeatcreation' __text='Create another item after save'}
                {formcheckbox group='response' id='repeatcreation' readOnly=false}
            </div>
        </fieldset>
    {/if*}

    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
        {if $mode eq 'edit'}
            {formbutton id='btnUpdate' commandName='update' __text='Update response' class='z-bt-save'}
          {*if !$inlineUsage}
            {gt text='Really delete this response?' assign='deleteConfirmMsg'}
            {formbutton id='btnDelete' commandName='delete' __text='Delete response' class='z-bt-delete z-btred' confirmMessage=$deleteConfirmMsg}
          {/if*}
        {elseif $mode eq 'create'}
            {formbutton id='btnCreate' commandName='create' __text='Create response' class='z-bt-ok'}
        {else}
            {formbutton id='btnUpdate' commandName='update' __text='OK' class='z-bt-ok'}
        {/if}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
    </div>


    <div class="surveymanager_clearance">&nbsp;</div>

    <fieldset>
        <legend>{gt text='Response data:'}</legend>

    {foreach item='question' from=$questions}
        {assign var='questionType' value=$question.questionType}
        {assign var='questionId' value=$question.id}
        <div class="z-formrow">
            {$questionHandlers.$questionType->getEditIntro($question, false, 'admin_response_edit')}
            <div style="margin-left: 30%">
                {$questionHandlers.$questionType->getEditInput($question, $question.response, 'admin_response_edit')}
            </div>
        </div>
    {/foreach}
    </fieldset>

    {* include display hooks *}
    {if $mode eq 'create'}
        {notifydisplayhooks eventname='surveymanager.ui_hooks.responses.form_edit' id=null assign='hooks'}
    {else}
        {notifydisplayhooks eventname='surveymanager.ui_hooks.responses.form_edit' id=$response.id assign='hooks'}
    {/if}
    {if is_array($hooks) && count($hooks)}
        {foreach key='providerArea' item='hook' from=$hooks}
            <fieldset>
                {$hook}
            </fieldset>
        {/foreach}
    {/if}

    {/surveymanagerFormFrame}
{/form}

</div>
{include file='admin/footer.tpl'}

{icon type='edit' size='extrasmall' assign='editImageArray'}
{icon type='delete' size='extrasmall' assign='deleteImageArray'}


<script type="text/javascript">
/* <![CDATA[ */
    var editImage = '<img src="{{$editImageArray.src}}" width="16" height="16" alt="" />';
    var removeImage = '<img src="{{$deleteImageArray.src}}" width="16" height="16" alt="" />';
    var relationHandler = new Array();
{{*    var newItem = new Object();
    newItem.ot = 'survey';
    newItem.alias = 'Survey';
    newItem.prefix = 'surveymanResponse_SurveySelectorDoNew';
    newItem.moduleName = 'SurveyManager';
    newItem.acInstance = null;
    newItem.windowInstance = null;
    relationHandler.push(newItem);*}}

    document.observe('dom:loaded', function() {
{{*        surveymanInitRelationItemsForm('survey', 'surveymanResponse_Survey', false);*}}

        surveymanAddCommonValidationRules('response', '{{if $mode eq 'create'}}{{else}}{{$response.id}}{{/if}}');

        // observe button events instead of form submit
        var valid = new Validation('{{$__formid}}', {onSubmit: false, immediate: true, focusOnError: false});
        {{if $mode ne 'create'}}
            var result = valid.validate();
        {{/if}}

        {{if $mode eq 'create'}}$('btnCreate'){{else}}$('btnUpdate'){{/if}}.observe('click', function (event) {
            var result = valid.validate();
            if (!result) {
                // validation error, abort form submit
                Event.stop(event);
            } else {
                // hide form buttons to prevent double submits by accident
                $$('div.z-formbuttons input').each(function (btn) {
                    btn.addClassName('z-hide');
                });
            }
            return result;
        });

        Zikula.UI.Tooltips($$('.surveymanagerFormTooltips'));
    });

/* ]]> */
</script>
