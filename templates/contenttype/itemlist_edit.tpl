{* Purpose of this template: edit view of generic item list content type *}
<div class="z-formrow">
    {gt text='Object type' domain='module_surveymanager' assign='objectTypeSelectorLabel'}
    {formlabel for='surveyManagerObjectType' text=$objectTypeSelectorLabel}
        {surveymanagerObjectTypeSelector assign='allObjectTypes'}
        {formdropdownlist id='surveyManagerOjectType' dataField='objectType' group='data' mandatory=true items=$allObjectTypes}
        <span class="z-sub z-formnote">{gt text='If you change this please save the element once to reload the parameters below.' domain='module_surveymanager'}</span>
</div>

{formvolatile}
{if $properties ne null && is_array($properties)}
    {nocache}
    {foreach key='registryId' item='registryCid' from=$registries}
        {assign var='propName' value=''}
        {foreach key='propertyName' item='propertyId' from=$properties}
            {if $propertyId eq $registryId}
                {assign var='propName' value=$propertyName}
            {/if}
        {/foreach}
        <div class="z-formrow">
            {modapifunc modname='SurveyManager' type='category' func='hasMultipleSelection' ot=$objectType registry=$propertyName assign='hasMultiSelection'}
            {gt text='Category' domain='module_surveymanager' assign='categorySelectorLabel'}
            {assign var='selectionMode' value='single'}
            {if $hasMultiSelection eq true}
                {gt text='Categories' domain='module_surveymanager' assign='categorySelectorLabel'}
                {assign var='selectionMode' value='multiple'}
            {/if}
            {formlabel for="surveyManagerCatIds`$propertyName`" text=$categorySelectorLabel}
                {formdropdownlist id="surveyManagerCatIds`$propName`" items=$categories.$propName dataField="catids`$propName`" group='data' selectionMode=$selectionMode}
                <span class="z-sub z-formnote">{gt text='This is an optional filter.' domain='module_surveymanager'}</span>
        </div>
    {/foreach}
    {/nocache}
{/if}
{/formvolatile}

<div class="z-formrow">
    {gt text='Sorting' domain='module_surveymanager' assign='sortingLabel'}
    {formlabel text=$sortingLabel}
    <div>
        {formradiobutton id='surveyManagerSortRandom' value='random' dataField='sorting' group='data' mandatory=true}
        {gt text='Random' domain='module_surveymanager' assign='sortingRandomLabel'}
        {formlabel for='surveyManagerSortRandom' text=$sortingRandomLabel}
        {formradiobutton id='surveyManagerSortNewest' value='newest' dataField='sorting' group='data' mandatory=true}
        {gt text='Newest' domain='module_surveymanager' assign='sortingNewestLabel'}
        {formlabel for='surveyManagerSortNewest' text=$sortingNewestLabel}
        {formradiobutton id='surveyManagerSortDefault' value='default' dataField='sorting' group='data' mandatory=true}
        {gt text='Default' domain='module_surveymanager' assign='sortingDefaultLabel'}
        {formlabel for='surveyManagerSortDefault' text=$sortingDefaultLabel}
    </div>
</div>

<div class="z-formrow">
    {gt text='Amount' domain='module_surveymanager' assign='amountLabel'}
    {formlabel for='surveyManagerAmount' text=$amountLabel}
        {formintinput id='surveyManagerAmount' dataField='amount' group='data' mandatory=true maxLength=2}
</div>

<div class="z-formrow">
    {gt text='Template' domain='module_surveymanager' assign='templateLabel'}
    {formlabel for='surveyManagerTemplate' text=$templateLabel}
        {surveymanagerTemplateSelector assign='allTemplates'}
        {formdropdownlist id='surveyManagerTemplate' dataField='template' group='data' mandatory=true items=$allTemplates}
</div>

<div id="customTemplateArea" class="z-formrow z-hide">
    {gt text='Custom template' domain='module_surveymanager' assign='customTemplateLabel'}
    {formlabel for='surveyManagerCustomTemplate' text=$customTemplateLabel}
        {formtextinput id='surveyManagerCustomTemplate' dataField='customTemplate' group='data' mandatory=false maxLength=80}
        <span class="z-sub z-formnote">{gt text='Example' domain='module_surveymanager'}: <em>itemlist_[objectType]_display.tpl</em></span>
</div>

<div class="z-formrow z-hide">
    {gt text='Filter (expert option)' domain='module_surveymanager' assign='filterLabel'}
    {formlabel for='surveyManagerFilter' text=$filterLabel}
        {formtextinput id='surveyManagerFilter' dataField='filter' group='data' mandatory=false maxLength=255}
        <span class="z-sub z-formnote">
            ({gt text='Syntax examples'}: <kbd>name:like:foobar</kbd> {gt text='or'} <kbd>status:ne:3</kbd>)
        </span>
</div>

{pageaddvar name='javascript' value='prototype'}
<script type="text/javascript">
/* <![CDATA[ */
    function surveymanToggleCustomTemplate() {
        if ($F('surveyManagerTemplate') == 'custom') {
            $('customTemplateArea').removeClassName('z-hide');
        } else {
            $('customTemplateArea').addClassName('z-hide');
        }
    }

    document.observe('dom:loaded', function() {
        surveymanToggleCustomTemplate();
        $('surveyManagerTemplate').observe('change', function(e) {
            surveymanToggleCustomTemplate();
        });
    });
/* ]]> */
</script>
