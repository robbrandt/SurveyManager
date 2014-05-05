{* purpose of this template: build the Form to edit an instance of survey *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/SurveyManager/javascript/SurveyManager_editFunctions.js'}
{pageaddvar name='javascript' value='modules/SurveyManager/javascript/SurveyManager_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit survey' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create survey' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit survey' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="surveymanager-survey surveymanager-edit">
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type=$adminPageIcon size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>

    <div class="z-informationmsg">
        <p>{gt text='Enter information about the survey here. Note that there are several tabs of data available for the survey.'}</p>
    </div>

{form cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {surveymanagerFormFrame}

    {formsetinitialfocus inputId='name'}

    {formtabbedpanelset}
    {gt text='General' assign='tabTitle'}
    {formtabbedpanel title=$tabTitle}
    <fieldset>
        <legend>{gt text='Content'}</legend>

        <div class="z-formrow">
            {formlabel for='name' __text='Name' mandatorysym='1'}
            {formtextinput group='survey' id='name' mandatory=true readOnly=false __title='Enter the name of the survey' textMode='singleline' maxLength=255 cssClass='required' }
            {surveymanagerValidationError id='name' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='description' __text='Description'}
            {formtextinput group='survey' id='description' mandatory=false __title='Enter the description of the survey' textMode='multiline' rows='6' cols='50' cssClass='' }
            <div class="z-formnote">
                The survey description appears on the site's <a href="{modurl modname='SurveyManager' type='user' func='view'}" onclick="window.open(this.href);return false;" />survey index</a>, which most sites don't use. If you want to edit the content that appears at the top of the first survey page, edit the description of the first page in the survey instead. 
            </div>
        </div>
{*
        <div class="z-formrow">
            {formlabel for='weight' __text='Weight'}
            {formintinput group='survey' id='weight' mandatory=false __title='Enter the weight of the survey' maxLength=11 cssClass=' validate-digits' }
            {surveymanagerValidationError id='weight' class='validate-digits'}
        </div>
*}
        <div class="z-formrow">
            {formlabel for='maxPerIp' __text='Max. Responses Per IP'}
            {formintinput group='survey' id='maxPerIp' mandatory=false __title='Enter the max responses per ip address' maxLength=11 cssClass=' validate-digits' }
            {surveymanagerValidationError id='maxPerIp' class='validate-digits'}
            <div class="z-formnote">{gt text='This is the maximum number of response to this survey that a single IP may submit. 0/blank = unlimited.'}</div>
        </div>

        <div class="z-formrow">
            {formlabel for='maxPerUserId' __text='Max. Responses Per User'}
            {formintinput group='survey' id='maxPerUserId' mandatory=false __title='Enter the max responses per user' maxLength=11 cssClass=' validate-digits' }
            {surveymanagerValidationError id='maxPerUserId' class='validate-digits'}
            <div class="z-formnote">{gt text='This is the maximum number of response to this survey that a single (logged in) user may submit. 0/blank = unlimited.'}</div>
        </div>

        <div class="z-formrow">
            {formlabel for='responseSubject' __text='Subject of Reports'}
            {formtextinput group='survey' id='responseSubject' mandatory=false readOnly=false textMode='singleline' maxLength=255 cssClass='' }
        </div>

        <div class="z-formrow">
            {formlabel for='recipients' __text='Email submissions to'}
            {formtextinput group='survey' id='recipients' mandatory=false __title='Enter the recipients' textMode='multiline' rows='6' cols='50' cssClass='' }
            <div class="z-formnote">{gt text='(One per line)'}</div>
        </div>
    </fieldset>
    {/formtabbedpanel}
    {gt text='Thank-You Page' assign='tabTitle'}
    {formtabbedpanel title=$tabTitle}
    <fieldset>
        <legend>{gt text='Content'}</legend>
        
        <div class="z-formrow">
            {formlabel for='thankYouTitle' __text='Thank-you page title'}
            {formtextinput group='survey' id='thankYouTitle' mandatory=false readOnly=false __title='Enter the thank you page title' textMode='singleline' maxLength=255 cssClass='' }
        </div>

        <div class="z-formrow">
            {formlabel for='thankYou' __text='Thank-you content'}
            {formtextinput group='survey' id='thankYou' mandatory=false __title='Enter the thank you content' textMode='multiline' rows='6' cols='50' cssClass='' }
        </div>
        
        <div class="z-formrow">
            {formlabel for='thankYouAlternativeUrl' __text='Alternative completion link'}
            {formurlinput group='survey' id='thankYouAlternativeUrl' mandatory=false readOnly=false __title='Enter the thank you alternative url' textMode='singleline' maxLength=255 cssClass=' validate-url' }
            {surveymanagerValidationError id='thankYouAlternativeUrl' class='validate-url'}
            <div class="z-formnote">{gt text='"__RESID__" will be replaced with the Response ID.'}</div>
        </div>
    </fieldset>
    {/formtabbedpanel}
    {gt text='User Confirmation' assign='tabTitle'}
    {formtabbedpanel title=$tabTitle}
    <fieldset>
        <legend>{gt text='Content'}</legend>

        <div class="z-formrow">
            {formlabel for='confirmationSubject' __text='User Confirmation Email Subject'}
            {formtextinput group='survey' id='confirmationSubject' mandatory=false readOnly=false __title='Enter the confirmation subject' textMode='singleline' maxLength=255 cssClass='' }
        </div>
        
        <div class="z-formrow">
            {formlabel for='confirmationBody' __text='User Confirmation Email Body'}
            {formtextinput group='survey' id='confirmationBody' mandatory=false __title='Enter the confirmation body' textMode='multiline' rows='6' cols='50' cssClass='' }
        </div>
    </fieldset>
    {/formtabbedpanel}
{if $modvars.SurveyManager.useAddition1 || $modvars.SurveyManager.useAddition2 || $modvars.SurveyManager.useAddition3 || $modvars.SurveyManager.useAddition4 || $modvars.SurveyManager.useAddition5}
    {gt text='Additions' assign='tabTitle'}
    {formtabbedpanel title=$tabTitle}
    <fieldset>
        <legend>{gt text='Content'}</legend>

{if $modvars.SurveyManager.useAddition1}
        <div class="z-formrow">
            {formlabel for='addition1' __text='Addition1'}
            {formtextinput group='survey' id='addition1' mandatory=false readOnly=false textMode='singleline' maxLength=100 cssClass='' }
        </div>
{/if}
{if $modvars.SurveyManager.useAddition2}
        <div class="z-formrow">
            {formlabel for='addition2' __text='Addition2'}
            {formtextinput group='survey' id='addition2' mandatory=false readOnly=false textMode='singleline' maxLength=100 cssClass='' }
        </div>
{/if}
{if $modvars.SurveyManager.useAddition3}
        <div class="z-formrow">
            {formlabel for='addition3' __text='Addition3'}
            {formtextinput group='survey' id='addition3' mandatory=false readOnly=false textMode='singleline' maxLength=100 cssClass='' }
        </div>
{/if}
{if $modvars.SurveyManager.useAddition4}
        <div class="z-formrow">
            {formlabel for='addition4' __text='Addition4'}
            {formtextinput group='survey' id='addition4' mandatory=false readOnly=false textMode='singleline' maxLength=255 cssClass='' }
        </div>
{/if}
{if $modvars.SurveyManager.useAddition5}
        <div class="z-formrow">
            {formlabel for='addition5' __text='Addition5'}
            {formtextinput group='survey' id='addition5' mandatory=false textMode='multiline' rows='6' cols='50' cssClass='' }
        </div>
{/if}
    </fieldset>
    {/formtabbedpanel}
{/if}
    {gt text='Options and hooks' assign='tabTitle'}
    {formtabbedpanel title=$tabTitle}
    <fieldset>
        <legend>{gt text='Content'}</legend>

        {modavailable modname='Captcha' assign='hasCaptchaSupport'}
        {if $hasCaptchaSupport}
        <div class="z-formrow">
            {formlabel for='useCaptcha' __text='Use captcha'}
            {formcheckbox group='survey' id='useCaptcha' readOnly=false __title='use captcha ?' cssClass='' }
        </div>
        {/if}

        <div class="z-formrow">
            {formlabel for='archived' __text='Archived'}
            {formcheckbox group='survey' id='archived' readOnly=false __title='Is this survey archived ?' cssClass='' }
        </div>

        <div class="z-formrow">
            {formlabel for='template' __text='Template'}
            {formcheckbox group='survey' id='template' readOnly=false __title='Can this survey be used as template ?' cssClass='' }
        </div>
    </fieldset>

    {if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$survey}
    {/if}
    
    {* include display hooks *}
    {if $mode eq 'create'}
        {notifydisplayhooks eventname='surveymanager.ui_hooks.surveys.form_edit' id=null assign='hooks'}
    {else}
        {notifydisplayhooks eventname='surveymanager.ui_hooks.surveys.form_edit' id=$survey.id assign='hooks'}
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
                {formlabel for='repeatcreation' __text='Create another item after save'}
                {formcheckbox group='survey' id='repeatcreation' readOnly=false}
            </div>
        </fieldset>
    {/if}

    {/formtabbedpanel}
    {/formtabbedpanelset}

    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
        {if $mode eq 'edit'}
            {formbutton id='btnUpdate' commandName='update' __text='Update survey' class='z-bt-save'}
          {if !$inlineUsage}
            {gt text='Really delete this survey?' assign='deleteConfirmMsg'}
            {formbutton id='btnDelete' commandName='delete' __text='Delete survey' class='z-bt-delete z-btred' confirmMessage=$deleteConfirmMsg}
          {/if}
        {elseif $mode eq 'create'}
            {formbutton id='btnCreate' commandName='create' __text='Create survey' class='z-bt-ok'}
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

    document.observe('dom:loaded', function() {

        surveymanAddCommonValidationRules('survey', '{{if $mode eq 'create'}}{{else}}{{$survey.id}}{{/if}}');

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
