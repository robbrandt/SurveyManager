{* purpose of this template: build the Form to edit an instance of page *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/SurveyManager/javascript/SurveyManager_editFunctions.js'}
{pageaddvar name='javascript' value='modules/SurveyManager/javascript/SurveyManager_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit page' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create page' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit page' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="surveymanager-page surveymanager-edit">
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type=$adminPageIcon size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>

{form cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {surveymanagerFormFrame}

    {formsetinitialfocus inputId='name'}

    <fieldset>
        <legend>{gt text='Context'}</legend>
        <div class="z-formrow">
            <input type="hidden" id="surveymanPage_SurveyItemList" name="surveymanPage_SurveyItemList" value="{$page.survey.id}" />
            <label for="">{gt text='Survey'}</label>
            <div>{$page.survey.name}</div>
        </div>
    </fieldset>
{*
    {include file='admin/survey/include_selectEditOne.tpl' relItem=$page aliasName='survey' idPrefix='surveymanPage_Survey'}
*}
    <div class="z-informationmsg">
        <p>{gt text='Enter information about the page here.'}</p>
    </div>

    <fieldset>
        <legend>{gt text='Content'}</legend>

        <div class="z-formrow">
            {formlabel for='name' __text='Name' mandatorysym='1'}
            {formtextinput group='page' id='name' mandatory=true readOnly=false __title='Enter the name of the page' textMode='singleline' maxLength=255 cssClass='required' }
            {surveymanagerValidationError id='name' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='description' __text='Description'}
            {formtextinput group='page' id='description' mandatory=false __title='Enter the description of the page' textMode='multiline' rows='6' cols='50' cssClass='' }
            <div class="z-formnote">{gt text='The page description appears at the top of this survey page.'}</div>
        </div>
{*
        <div class="z-formrow">
            {formlabel for='weight' __text='Weight'}
            {formintinput group='page' id='weight' mandatory=false __title='Enter the weight of the page' maxLength=11 cssClass=' validate-digits' }
            {surveymanagerValidationError id='weight' class='validate-digits'}
        </div>
*}
    </fieldset>
    
    {if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$page}
    {/if}
    
    {* include display hooks *}
    {if $mode eq 'create'}
        {notifydisplayhooks eventname='surveymanager.ui_hooks.pages.form_edit' id=null assign='hooks'}
    {else}
        {notifydisplayhooks eventname='surveymanager.ui_hooks.pages.form_edit' id=$page.id assign='hooks'}
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
                    {formcheckbox group='page' id='repeatCreation' readOnly=false}
            </div>
        </fieldset>
    {/if}
    
    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
        {if $mode eq 'edit'}
            {formbutton id='btnUpdate' commandName='update' __text='Update page' class='z-bt-save'}
          {if !$inlineUsage}
            {gt text='Really delete this page?' assign='deleteConfirmMsg'}
            {formbutton id='btnDelete' commandName='delete' __text='Delete page' class='z-bt-delete z-btred' confirmMessage=$deleteConfirmMsg}
          {/if}
        {elseif $mode eq 'create'}
            {formbutton id='btnCreate' commandName='create' __text='Create page' class='z-bt-ok'}
        {else}
            {formbutton id='btnUpdate' commandName='update' __text='OK' class='z-bt-ok'}
        {/if}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
    </div>
    
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
{{*
    var newItem = new Object();
    newItem.ot = 'survey';
    newItem.alias = 'Survey';
    newItem.prefix = 'surveymanPage_SurveySelectorDoNew';
    newItem.moduleName = 'SurveyManager';
    newItem.acInstance = null;
    newItem.windowInstance = null;
    relationHandler.push(newItem);
*}}
    document.observe('dom:loaded', function() {
{{*        surveymanInitRelationItemsForm('survey', 'surveymanPage_Survey', true);*}}

        surveymanAddCommonValidationRules('page', '{{if $mode eq 'create'}}{{else}}{{$page.id}}{{/if}}');

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
