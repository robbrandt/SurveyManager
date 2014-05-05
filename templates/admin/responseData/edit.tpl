{* purpose of this template: build the Form to edit an instance of response data *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/SurveyManager/javascript/SurveyManager_editFunctions.js'}
{pageaddvar name='javascript' value='modules/SurveyManager/javascript/SurveyManager_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit response data' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create response data' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit response data' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="surveymanager-responsedata surveymanager-edit">
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type=$adminPageIcon size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>
{form cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {surveymanagerFormFrame}
    {formsetinitialfocus inputId='responseValue'}

    <fieldset>
        <legend>{gt text='Content'}</legend>
        
        <div class="z-formrow">
            {formlabel for='responseValue' __text='Response value' mandatorysym='1' cssClass=''}
            {formtextinput group='responsedata' id='responseValue' mandatory=true __title='Enter the response value of the response data' textMode='multiline' rows='6' cols='50' cssClass='required' }
            {surveymanagerValidationError id='responseValue' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='grade' __text='Grade' cssClass=''}
            {formintinput group='responsedata' id='grade' mandatory=false __title='Enter the grade of the response data' maxLength=2 cssClass=' validate-digits' }
            {surveymanagerValidationError id='grade' class='validate-digits'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='correctness' __text='Correctness' cssClass=''}
            {formintinput group='responsedata' id='correctness' mandatory=false __title='Enter the correctness of the response data' maxLength=2 cssClass=' validate-digits' }
            {surveymanagerValidationError id='correctness' class='validate-digits'}
        </div>
    </fieldset>
    
    {include file='admin/response/include_selectEditOne.tpl' group='responsedata' alias='response' aliasReverse='answers' mandatory=false idPrefix='surveymanResponseData_Response' linkingItem=$responsedata displayMode='dropdown' allowEditing=true}
    {include file='admin/question/include_selectOne.tpl' group='responsedata' alias='question' aliasReverse='answers' mandatory=false idPrefix='surveymanResponseData_Question' linkingItem=$responsedata displayMode='dropdown' allowEditing=false}
    {if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$responsedata}
    {/if}
    
    {* include display hooks *}
    {if $mode ne 'create'}
        {assign var='hookId' value=$responsedata.id}
        {notifydisplayhooks eventname='surveymanager.ui_hooks.responsedatas.form_edit' id=$hookId assign='hooks'}
    {else}
        {notifydisplayhooks eventname='surveymanager.ui_hooks.responsedatas.form_edit' id=null assign='hooks'}
    {/if}
    {if is_array($hooks) && count($hooks)}
        {foreach key='providerArea' item='hook' from=$hooks}
            <fieldset>
                {$hook}
            </fieldset>
        {/foreach}
    {/if}
    
    {* include return control *}
    {if $mode eq 'create'}
        <fieldset>
            <legend>{gt text='Return control'}</legend>
            <div class="z-formrow">
                {formlabel for='repeatCreation' __text='Create another item after save'}
                    {formcheckbox group='responsedata' id='repeatCreation' readOnly=false}
            </div>
        </fieldset>
    {/if}
    
    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
    {foreach item='action' from=$actions}
        {assign var='actionIdCapital' value=$action.id|@ucwords}
        {gt text=$action.title assign='actionTitle'}
        {*gt text=$action.description assign='actionDescription'*}{* TODO: formbutton could support title attributes *}
        {if $action.id eq 'delete'}
            {gt text='Really delete this response data?' assign='deleteConfirmMsg'}
            {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass confirmMessage=$deleteConfirmMsg}
        {else}
            {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass}
        {/if}
    {/foreach}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
    </div>
    {/surveymanagerFormFrame}
{/form}
</div>
{include file='admin/footer.tpl'}

{icon type='edit' size='extrasmall' assign='editImageArray'}
{icon type='delete' size='extrasmall' assign='removeImageArray'}


<script type="text/javascript">
/* <![CDATA[ */

    var formButtons, formValidator;

    function handleFormButton (event) {
        var result = formValidator.validate();
        if (!result) {
            // validation error, abort form submit
            Event.stop(event);
        } else {
            // hide form buttons to prevent double submits by accident
            formButtons.each(function (btn) {
                btn.addClassName('z-hide');
            });
        }

        return result;
    }

    document.observe('dom:loaded', function() {

        surveymanAddCommonValidationRules('responseData', '{{if $mode ne 'create'}}{{$responsedata.id}}{{/if}}');
        {{* observe validation on button events instead of form submit to exclude the cancel command *}}
        formValidator = new Validation('{{$__formid}}', {onSubmit: false, immediate: true, focusOnError: false});
        {{if $mode ne 'create'}}
            var result = formValidator.validate();
        {{/if}}

        formButtons = $('{{$__formid}}').select('div.z-formbuttons input');

        formButtons.each(function (elem) {
            if (elem.id != 'btnCancel') {
                elem.observe('click', handleFormButton);
            }
        });

        Zikula.UI.Tooltips($$('.surveymanager-form-tooltips'));
    });

/* ]]> */
</script>
