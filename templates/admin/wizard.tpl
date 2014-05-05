{* purpose of this template: show output of wizard form in admin area *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/SurveyManager/javascript/SurveyManager_editFunctions.js'}
{pageaddvar name='javascript' value='modules/SurveyManager/javascript/SurveyManager_validation.js'}
{pageaddvar name='javascript' value='modules/SurveyManager/javascript/SurveyManager_wizard.js'}
{pageaddvar name='stylesheet' value='modules/SurveyManager/style/manual.css'}
<div class="surveymanager-wizard surveymanager-wizard">
    {gt text='Wizard' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='options' size='small' __alt='Wizard'}
        <h3>{$templateTitle}</h3>
    </div>

    <div class="z-informationmsg">
        <p>{gt text='Enter core information about the survey in the red box.'} {gt text='Click "Add question" to add as many questions as you\'d like; they will appear in green boxes.'} {gt text='You may drag the green boxes to rearrange them.'} {gt text='Click the right-facing arrow to the left of the survey or any question to view details of that item.'} {gt text='Click "Delete" to delete a question.'} {gt text='No changes will take effect until you click "Add Survey" or "Update Survey" at the bottom of the list.'}</p>
        <p>{gt text='Enter information about the survey here. Note that there are several tabs of data available for the survey.'}</p>
    </div>

{form id='wizardform' cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {surveymanagerFormFrame}
    {formsetinitialfocus inputId='name'}
    <div>
        <input type="hidden" id="question_order" name="question_order" value="" />
        <input type="hidden" id="delete_questions" name="delete_questions" value="" />
    </div>

    <div id="surveymanager_wizard_core">
        <a id="toggle_core" href="javascript:void(0);" class="surveymanager_wizard_toggle">{img id='surveymanager_wizard_core_image' src='open_arrow.gif' __alt='Show core controls'}</a><span id="survey_title" class="surveymanager_wizard_toggle">{if $survey.name && $survey.name ne ''}{$survey.name}{else}[{gt text='New Survey'}]{/if}</span>
        <div id="surveymanager_wizard_core_details">
            <div class="z-formrow">
                {formlabel for='name' __text='Survey title' mandatorysym='1'}
                {formtextinput group='survey' id='name' mandatory=true readOnly=false __title='Enter the name of the survey' textMode='singleline' maxLength=255 cssClass='required' }
                {surveymanagerValidationError id='name' class='required'}
            </div>

            <div class="z-formrow">
                {formlabel for='thankYou' __text='Thank-you content'}
                {formtextinput group='survey' id='thankYou' mandatory=false __title='Enter the thank you content' textMode='multiline' rows='6' cols='50' cssClass='' }
            </div>

            {modavailable modname='Captcha' assign='hasCaptchaSupport'}
            {if $hasCaptchaSupport}
            <div class="z-formrow">
                {formlabel for='useCaptcha' __text='Use captcha'}
                {formcheckbox group='survey' id='useCaptcha' readOnly=false __title='use captcha ?' cssClass='' }
            </div>
            {/if}

            <div class="z-formrow">
                {formlabel for='recipients' __text='Email submissions to'}
                {formtextinput group='survey' id='recipients' mandatory=false __title='Enter the recipients' textMode='multiline' rows='6' cols='50' cssClass='' }
                <div class="z-formnote">{gt text='(One per line)'}</div>
            </div>

            <div class="z-formrow">
                <label>&nbsp;</label>
                <div class="z-formnote">
                    <p>{gt text='<strong>Other survey options</strong> are available by clicking on the survey\'s title in the main administrative survey index.'}</p>
                </div>
            </div>

            <div class="surveymanager_clearance">&nbsp;</div>
        </div>
    </div>
    <div class="surveymanager_clearance">&nbsp;</div>

    {formvolatile}
    <ul id="question_list" class="question_list">
        {foreach item='question' from=$questions}
        {assign var='qid' value=$question.id}
        <li id="question_{$qid}">
            <a id="toggle_{$qid}" href="javascript:void(0);" class="surveymanager_wizard_toggle">{img id="surveymanager_wizard_`$qid`_image" src='open_arrow.gif' __alt="Show controls for Question `$qid`"}</a><span class="surveymanager_wizard_toggle" id="question_{$qid}_title">{$question.name}</span> (<a id="question_{$qid}_delete" href="javascript:void(0);" class="question_delete z-icon-es-delete">{gt text='Delete'}</a>)
            <div id="question_{$qid}_details" class="z-hide">
                <div class="z-formrow">
                    {formlabel for="question_`$qid`_name" __text='Name' mandatorysym='1'}
                    {formtextinput group="question`$qid`" id="question_`$qid`_name" mandatory=true readOnly=false __title='Enter the name of the question' textMode='singleline' maxLength=255 cssClass='required'}
                    {surveymanagerValidationError id="question_`$qid`_name" class='required'}
                </div>

                <div class="z-formrow">
                    {formlabel for="question_`$qid`_description" __text='Description'}
                    {formtextinput group="question`$qid`" id="question_`$qid`_description" mandatory=false __title='Enter the description of the question' textMode='multiline' rows='6' cols='50' cssClass='' }
                </div>

                <div class="z-formrow">
                    {formlabel for="question_`$qid`_questionType" __text='Type'}
                    {formdropdownlist group="question`$qid`" id="question_`$qid`_questionType" mandatory=false readOnly=false __title='Choose the question type'}
                    <ul class="z-formnote">
                        <li>{gt text='If you choose "Email Address (From)" as the question type, the return address of the response report email will be set to the value of this question. If no value is provided, the from address will be the default site administrator address.'}</li>
                        <li>{gt text='If you choose "Name identifier" for the type of this question, it will be considered to be the name of the respondant for display purposes.'}</li>
                    </ul>
                </div>

                <div class="z-formrow">
                    {formlabel for="question_`$qid`_questionValues" __text='Question values'}
                    {formtextinput group="question`$qid`" id="question_`$qid`_questionValues" mandatory=false __title='Enter the question values' textMode='multiline' rows='6' cols='50' cssClass='' }
                    <div class="z-formnote">{gt text='For Single Selection and Multiple Selection questions only.'}</div>
                </div>

                <div class="z-formrow">
                    {formlabel for="question_`$qid`_correctValues" __text='Correct values'}
                    {formtextinput group="question`$qid`" id="question_`$qid`_correctValues" mandatory=false __title='Enter the correct values' textMode='multiline' rows='6' cols='50' cssClass='' }
                    <div class="z-formnote">{gt text='Either the correct values to be selected or key ideas for open text questions.'}</div>
                </div>

                <div class="z-formrow">
                    {formlabel for="question_`$qid`_required" __text='Required ?'}
                    {formcheckbox group="question`$qid`" id="question_`$qid`_required" readOnly=false __title='required ?' cssClass='' }
                </div>
            </div>
        </li>
        {/foreach}
    </ul>
    {/formvolatile}
    <ul class="z-hide">
        <li id="question_template">
            <a id="toggle_template" href="javascript:void(0);" class="surveymanager_wizard_toggle">{img id='surveymanager_wizard_template_image' src='open_arrow.gif' __alt='Show controls for Question'}</a><span class="surveymanager_wizard_toggle" id="question_template_title"></span> (<a id="question_template_delete" href="javascript:void(0);" class="question_delete z-icon-es-delete">{gt text='Delete'}</a>)
            <div id="question_template_details" class="z-hide">
                <div class="z-formrow">
                    {formlabel for='question_template_name' __text='Name' mandatorysym='1'}
                    {formtextinput group='questiontemplate' id='question_template_name' mandatory=false readOnly=false __title='Enter the name of the question' textMode='singleline' maxLength=255 cssClass='required'}
                    {*surveymanagerValidationError id='question_template_name' class='required'*}
                </div>

                <div class="z-formrow">
                    {formlabel for='question_template_description' __text='Description'}
                    {formtextinput group='questiontemplate' id='question_template_description' mandatory=false __title='Enter the description of the question' textMode='multiline' rows='6' cols='50' cssClass='' }
                </div>

                <div class="z-formrow">
                    {formlabel for='question_template_questionType' __text='Type'}
                    {formdropdownlist group='questiontemplate' id='question_template_questionType' mandatory=false readOnly=false __title='Choose the question type'}
                    <ul class="z-formnote">
                        <li>{gt text='If you choose "Email Address (From)" as the question type, the return address of the response report email will be set to the value of this question. If no value is provided, the from address will be the default site administrator address.'}</li>
                        <li>{gt text='If you choose "Name identifier" for the type of this question, it will be considered to be the name of the respondant for display purposes.'}</li>
                    </ul>
                </div>

                <div class="z-formrow">
                    {formlabel for='question_template_questionValues' __text='Question values'}
                    {formtextinput group='questiontemplate' id='question_template_questionValues' mandatory=false __title='Enter the question values' textMode='multiline' rows='6' cols='50' cssClass='' }
                    <div class="z-formnote">{gt text='For Single Selection and Multiple Selection questions only.'}</div>
                </div>

                <div class="z-formrow">
                    {formlabel for='question_template_correctValues' __text='Correct values'}
                    {formtextinput group='questiontemplate' id='question_template_correctValues' mandatory=false __title='Enter the correct values' textMode='multiline' rows='6' cols='50' cssClass='' }
                    <div class="z-formnote">{gt text='Either the correct values to be selected or key ideas for open text questions.'}</div>
                </div>

                <div class="z-formrow">
                    {formlabel for='question_template_required' __text='Required ?'}
                    {formcheckbox group='questiontemplate' id='question_template_required' readOnly=false __title='required ?' cssClass='' }
                </div>

                <div class="surveymanager_clearance">&nbsp;</div>
            </div>
        </li>
    </ul>
    <div class="surveymanager_clearance">&nbsp;</div>

    <div id="surveymanager_wizard_new">
        <a id="addQuestionLink" href="javascript:void(0);" class="z-hide z-icon-es-add">{gt text='Add a question'}</a>
    </div>
    <div class="surveymanager_clearance">&nbsp;</div>

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

    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
        {if $mode eq 'edit'}
            {formbutton id='btnUpdate' commandName='update' __text='Update survey' class='z-bt-save'}
        {elseif $mode eq 'create'}
            {formbutton id='btnCreate' commandName='create' __text='Create survey' class='z-bt-ok'}
        {else}
            {formbutton id='btnUpdate' commandName='update' __text='OK' class='z-bt-ok'}
        {/if}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
    </div>

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function () {
        questions = [];
        {{assign var='maxQuestionId' value=0}}
        {{foreach item='question' from=$questions}}
        {{assign var='qid' value=$question.id}}
        questions[{{$qid}}] = [];
        questions[{{$qid}}]['name'] = '{{$question.name|addslashes}}';
        {{if $qid gt $maxQuestionId}}{{assign var='maxQuestionId' value=$qid}}{{/if}}
        {{/foreach}}
    });
/* ]]> */
</script>

        <div>
            <input type="hidden" id="max_qid" name="max_qid" value="{$maxQuestionId}" />
        </div>
    {/surveymanagerFormFrame}
{/form}

</div>
{include file='admin/footer.tpl'}

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        surveymanAddCommonValidationRules('survey', '{{if $mode eq 'create'}}{{else}}{{$survey.id}}{{/if}}');

        // observe button events instead of form submit
        valid = new Validation('{{$__formid}}', { onSubmit: false, immediate: true, focusOnError: true });
        {{if $mode ne 'create'}}
            var result = valid.validate();
        {{/if}}

        {{if $mode eq 'create'}}$('btnCreate'){{else}}$('btnUpdate'){{/if}}.observe('click', processFormSubmit);
        initWizard();
    });

/* ]]> */
</script>
