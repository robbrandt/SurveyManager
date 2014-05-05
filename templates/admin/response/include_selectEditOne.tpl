{* purpose of this template: inclusion template for managing related response in admin area *}
{if !isset($displayMode)}
    {assign var='displayMode' value='dropdown'}
{/if}
{if !isset($allowEditing)}
    {assign var='allowEditing' value=false}
{/if}
{if isset($panel) && $panel eq true}
    <h3 class="response z-panel-header z-panel-indicator z-pointer">{gt text='Response'}</h3>
    <fieldset class="response z-panel-content" style="display: none">
{else}
    <fieldset class="response">
{/if}
    <legend>{gt text='Response'}</legend>
    <div class="z-formrow">
    {if $displayMode eq 'dropdown'}
        {formlabel for=$alias __text='Choose response'}
            {surveymanagerRelationSelectorList group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the response' selectionMode='single' objectType='response' linkingItem=$linkingItem}
    {elseif $displayMode eq 'autocomplete'}
        {assign var='createLink' value=''}
        {if $allowEditing eq true}
            {modurl modname='SurveyManager' type='admin' func='edit' ot='response' assign='createLink'}
        {/if}
        {surveymanagerRelationSelectorAutoComplete group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the response' selectionMode='single' objectType='response' linkingItem=$linkingItem idPrefix=$idPrefix createLink=$createLink withImage=false}
        <div class="surveymanager-relation-leftside">
            {if isset($linkingItem.$alias)}
                {include file='admin/response/include_selectEditItemListOne.tpl'  item=$linkingItem.$alias}
            {else}
                {include file='admin/response/include_selectEditItemListOne.tpl' }
            {/if}
        </div>
        <br class="z-clearer" />
    {/if}
    </div>
</fieldset>
