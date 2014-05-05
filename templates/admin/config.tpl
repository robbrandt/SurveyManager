{* purpose of this template: module configuration *}
{include file='admin/header.tpl'}
<div class="surveymanager-config">
    {gt text='Settings' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='config' size='small' __alt='Settings'}
        <h3>{$templateTitle}</h3>
    </div>

    {form cssClass='z-form'}


        {* add validation summary and a <div> element for styling the form *}
        {surveymanagerFormFrame}
            {formsetinitialfocus inputId='pageSize'}
            {formtabbedpanelset}
            {gt text='General' assign='tabTitle'}
            {formtabbedpanel title=$tabTitle}
            <fieldset>
                <legend>{gt text='Modify general settings for the SurveyManager module here.'}</legend>
            
                <div class="z-formrow">
                    {formlabel for='pageSize' __text='Page size'}
                    {formintinput id='pageSize' group='config' maxLength=255 __title='Enter this setting. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='Use Featured Responses?' assign='toolTip'}
                    {formlabel for='useFeaturedResponses' __text='Use featured responses' class='surveymanagerFormTooltips' title=$toolTip}
                    {formcheckbox id='useFeaturedResponses' group='config'}
                </div>
                <div class="z-formrow">
                    {gt text='Email all submissions to' assign='toolTip'}
                    {formlabel for='submissionRecipients' __text='Submission recipients' class='surveymanagerFormTooltips' title=$toolTip}
                    {formtextinput id='submissionRecipients' group='config' textMode='multiline' __title='Enter this setting.'}
                    <div class="z-formnote">{gt text='(One per line)'}</div>
                </div>
                <div class="z-formrow">
                    {gt text='Technical Email Recipients' assign='toolTip'}
                    {formlabel for='techEmailRecipients' __text='Tech email recipients' class='surveymanagerFormTooltips' title=$toolTip}
                    {formtextinput id='techEmailRecipients' group='config' textMode='multiline' __title='Enter this setting.'}
                    <div class="z-formnote">{gt text='(One per line)'}</div>
                </div>
            </fieldset>
            {/formtabbedpanel}
            {gt text='Media' assign='tabTitle'}
            {formtabbedpanel title=$tabTitle}
            <fieldset>
                <legend>{gt text='Modify media settings for the SurveyManager module here.'}</legend>
            
                <div class="z-formrow">
                    {gt text='Maximum upload file size in kilobytes.' assign='toolTip'}
                    {formlabel for='maxFileSizeKb' __text='Max file size kb' class='surveymanagerFormTooltips' title=$toolTip}
                    <div>
                        {formintinput id='maxFileSizeKb' group='config' maxLength=255 __title='Enter this setting. Only digits are allowed.'} {gt text='kb'}
                    </div>
                </div>
                <div class="z-formrow">
                    {gt text='File upload directory.' assign='toolTip'}
                    {formlabel for='fileUploadDirectory' __text='File upload directory' class='surveymanagerFormTooltips' title=$toolTip}
                    {formtextinput id='fileUploadDirectory' group='config' maxLength=255 __title='Enter this setting.'}
                </div>
                <div class="z-formrow">
                    {formlabel for='maxPhotoWidth' __text='Max photo width'}
                    <div>
                        {formintinput id='maxPhotoWidth' group='config' maxLength=255 __title='Enter this setting. Only digits are allowed.'} {gt text='px'}
                    </div>
                </div>
                <div class="z-formrow">
                    {formlabel for='maxPhotoHeight' __text='Max photo height'}
                    <div>
                        {formintinput id='maxPhotoHeight' group='config' maxLength=255 __title='Enter this setting. Only digits are allowed.'} {gt text='px'}
                    </div>
                </div>
                <div class="z-formrow">
                    {formlabel for='maxThumbWidth' __text='Max thumb width'}
                    <div>
                        {formintinput id='maxThumbWidth' group='config' maxLength=255 __title='Enter this setting. Only digits are allowed.'} {gt text='px'}
                    </div>
                </div>
                <div class="z-formrow">
                    {formlabel for='maxThumbHeight' __text='Max thumb height'}
                    <div>
                        {formintinput id='maxThumbHeight' group='config' maxLength=255 __title='Enter this setting. Only digits are allowed.'} {gt text='px'}
                    </div>
                </div>
            </fieldset>
            {/formtabbedpanel}
            {gt text='Optional fields' assign='tabTitle'}
            {formtabbedpanel title=$tabTitle}
            <fieldset>
                <legend>{gt text='Here you can enable/disable optional fields for storing additional data for your surveys.'}</legend>
            
                <div class="z-formrow">
                    {gt text='This is a string field with a maximum size of 100 chars.' assign='toolTip'}
                    {formlabel for='useAddition1' __text='Use addition1' class='surveymanagerFormTooltips' title=$toolTip}
                    {formcheckbox id='useAddition1' group='config'}
                </div>
                <div class="z-formrow">
                    {gt text='This is a string field with a maximum size of 100 chars.' assign='toolTip'}
                    {formlabel for='useAddition2' __text='Use addition2' class='surveymanagerFormTooltips' title=$toolTip}
                    {formcheckbox id='useAddition2' group='config'}
                </div>
                <div class="z-formrow">
                    {gt text='This is a string field with a maximum size of 100 chars.' assign='toolTip'}
                    {formlabel for='useAddition3' __text='Use addition3' class='surveymanagerFormTooltips' title=$toolTip}
                    {formcheckbox id='useAddition3' group='config'}
                </div>
                <div class="z-formrow">
                    {gt text='This is a string field with a maximum size of 255 chars.' assign='toolTip'}
                    {formlabel for='useAddition4' __text='Use addition4' class='surveymanagerFormTooltips' title=$toolTip}
                    {formcheckbox id='useAddition4' group='config'}
                </div>
                <div class="z-formrow">
                    {gt text='This is a text field with a maximum size of 2000 chars.' assign='toolTip'}
                    {formlabel for='useAddition5' __text='Use addition5' class='surveymanagerFormTooltips' title=$toolTip}
                    {formcheckbox id='useAddition5' group='config'}
                </div>
            </fieldset>
            {/formtabbedpanel}
            {/formtabbedpanelset}

            <div class="z-buttons z-formbuttons">
                {formbutton commandName='save' __text='Update configuration' class='z-bt-save'}
                {formbutton commandName='cancel' __text='Cancel' class='z-bt-cancel'}
            </div>
        {/surveymanagerFormFrame}
    {/form}
</div>
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        Zikula.UI.Tooltips($$('.surveymanagerFormTooltips'));
    });
/* ]]> */
</script>
{include file='admin/footer.tpl'}
