{* purpose of this template: build the Form to edit an instance of question *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/SurveyManager/javascript/SurveyManager_editFunctions.js'}
{pageaddvar name='javascript' value='modules/SurveyManager/javascript/SurveyManager_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit question' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create question' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit question' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="surveymanager-question surveymanager-edit">
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
            <label for="">{gt text='Survey'}</label>
            <div>{$parentSurvey.name}</div>
        </div>
        <div class="z-formrow">
            <input type="hidden" id="surveymanQuestion_PageItemList" name="surveymanQuestion_PageItemList" value="{$parentPage.id}" />
            <label for="">{gt text='Page'}</label>
            <div>{$parentPage.name}</div>
        </div>
    </fieldset>
{*
    {include file='admin/page/include_selectOne.tpl' relItem=$question aliasName='page' idPrefix='surveymanQuestion_Page'}
*}
    <div class="z-informationmsg">
        <p>{gt text='Enter information about the question here.'}</p>
    </div>

    <fieldset>
        <legend>{gt text='Content'}</legend>
        
        <div class="z-formrow">
            {formlabel for='name' __text='Name' mandatorysym='1'}
            {formtextinput group='question' id='name' mandatory=true readOnly=false __title='Enter the name of the question' textMode='singleline' maxLength=255 cssClass='required' }
            {surveymanagerValidationError id='name' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='description' __text='Description'}
            {formtextinput group='question' id='description' mandatory=false __title='Enter the description of the question' textMode='multiline' rows='6' cols='50' cssClass='' }
            <div class="z-formnote">{gt text='The question description appears beneath (or near) the question it describes. Use this field to provide some additional guidance to survey respondants.'}</div>
        </div>
{*
        <div class="z-formrow">
            {formlabel for='weight' __text='Weight'}
            {formintinput group='question' id='weight' mandatory=false __title='Enter the weight of the question' maxLength=11 cssClass=' validate-digits' }
            {surveymanagerValidationError id='weight' class='validate-digits'}
        </div>
*}
        <div class="z-formrow">
            {formlabel for='questionType' __text='Type'}
            {formdropdownlist group='question' id='questionType' mandatory=false readOnly=false __title='Choose the question type'}
            <ul class="z-formnote">
                <li>{gt text='If you choose "Email Address (From)" as the question type, the return address of the response report email will be set to the value of this question. If no value is provided, the from address will be the default site administrator address.'}</li>
                <li>{gt text='If you choose "Name identifier" for the type of this question, it will be considered to be the name of the respondant for display purposes.'}</li>
            </ul>
        </div>

        <div class="z-formrow">
            {formlabel for='questionValues' __text='Question values'}
            {formtextinput group='question' id='questionValues' mandatory=false __title='Enter the question values' textMode='multiline' rows='6' cols='50' cssClass='' }
            <div class="z-formnote">{gt text='For Single Selection and Multiple Selection questions only.'}</div>
        </div>

        <div class="z-formrow">
            {formlabel for='correctValues' __text='Correct values'}
            {formtextinput group='question' id='correctValues' mandatory=false __title='Enter the correct values' textMode='multiline' rows='6' cols='50' cssClass='' }
            <div class="z-formnote">{gt text='Either the correct values to be selected or key ideas for open text questions.'}</div>
        </div>

        <div class="z-formrow">
            {formlabel for='required' __text='Required ?'}
            {formcheckbox group='question' id='required' readOnly=false __title='required ?' cssClass='' }
        </div>
    </fieldset>

    {assign var='showDependencies' value=false}
    {foreach item='page' from=$parentSurvey.pages}
        {if $page.weight lt $parentPage.weight}
            {assign var='pageNameWritten' value=false}
            {foreach item='earlierQuestion' from=$page.questions}
                {if $earlierQuestion.questionType eq 'single_selection'
                || $earlierQuestion.questionType eq 'multi_selection'
                || $earlierQuestion.questionType eq 'single_selection_radio'
                || $earlierQuestion.questionType eq 'likert_radio'}
                    {if !$showDependencies}
                        <fieldset>
                            <legend>{gt text='Dependencies'}</legend>
                            <div class="z-formrow">
                                <label>{gt text='ONLY AVAILABLE IF...'}</label>
                            </div>
                        {assign var='showDependencies' value=true}
                    {/if}

                    {* The first time we write in a question row, also add the page name. *}
                    {if !$pageNameWritten}
                    <div class="z-formrow">
                        <label>&nbsp;</label>
                        <div>
                            <em>In "{$page.name}"...</em>
                        </div>
                    </div>
                    {assign var='pageNameWritten' value=true}
                    {/if}

                    {assign var='qid' value=$earlierQuestion.id}
                    <div class="z-formrow">
                        <label for="dependencies_{$qid}">"{$earlierQuestion.name|truncate:32}" is:</label>
                        <select id="dependencies_{$qid}" name="dependencies[{$qid}]">
                            <option value="0"{if $mode eq 'create' || !isset($question.dependencies.$qid)} selected="selected"{/if}>{gt text='Any value'}</option>
                            {foreach item='value' from=$earlierQuestion.questionValues}
                                <option value="{$value|safetext}"{if $mode ne 'create' && isset($question.dependencies.$qid) && $question.dependencies.$qid eq $value} selected="selected"{/if}>{$value|safetext}</option>
                            {/foreach}
                        </select>
                    </div>
                {/if}
            {/foreach}
        {/if}
    {/foreach}
    {if $showDependencies}
    </fieldset>
    {/if}
    
    {if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$question}
    {/if}
    
    {* include display hooks *}
    {if $mode eq 'create'}
        {notifydisplayhooks eventname='surveymanager.ui_hooks.questions.form_edit' id=null assign='hooks'}
    {else}
        {notifydisplayhooks eventname='surveymanager.ui_hooks.questions.form_edit' id=$question.id assign='hooks'}
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
                {formcheckbox group='question' id='repeatCreation' readOnly=false}
            </div>
        </fieldset>
    {/if}
    
    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
        {if $mode eq 'edit'}
            {formbutton id='btnUpdate' commandName='update' __text='Update question' class='z-bt-save'}
          {if !$inlineUsage}
            {gt text='Really delete this question?' assign='deleteConfirmMsg'}
            {formbutton id='btnDelete' commandName='delete' __text='Delete question' class='z-bt-delete z-btred' confirmMessage=$deleteConfirmMsg}
          {/if}
        {elseif $mode eq 'create'}
            {formbutton id='btnCreate' commandName='create' __text='Create question' class='z-bt-ok'}
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
    newItem.ot = 'page';
    newItem.alias = 'Page';
    newItem.prefix = 'surveymanQuestion_PageSelectorDoNew';
    newItem.moduleName = 'SurveyManager';
    newItem.acInstance = null;
    newItem.windowInstance = null;
    relationHandler.push(newItem);
*}}
    document.observe('dom:loaded', function() {
{{*        surveymanInitRelationItemsForm('page', 'surveymanQuestion_Page', false);*}}

        surveymanAddCommonValidationRules('question', '{{if $mode eq 'create'}}{{else}}{{$question.id}}{{/if}}');

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
