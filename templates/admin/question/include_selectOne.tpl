{* purpose of this template: inclusion template for managing related question in admin area *}
{if !isset($displayMode)}
    {assign var='displayMode' value='dropdown'}
{/if}
{if !isset($allowEditing)}
    {assign var='allowEditing' value=false}
{/if}
{if isset($panel) && $panel eq true}
    <h3 class="question z-panel-header z-panel-indicator z-pointer">{gt text='Question'}</h3>
    <fieldset class="question z-panel-content" style="display: none">
{else}
    <fieldset class="question">
{/if}
    <legend>{gt text='Question'}</legend>
    <div class="z-formrow">
    {if $displayMode eq 'dropdown'}
        {formlabel for=$alias __text='Choose question'}
            {surveymanagerRelationSelectorList group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the question' selectionMode='single' objectType='question' linkingItem=$linkingItem}
    {elseif $displayMode eq 'autocomplete'}
        {assign var='createLink' value=''}
        {if $allowEditing eq true}
            {modurl modname='SurveyManager' type='admin' func='edit' ot='question' assign='createLink'}
        {/if}
        {surveymanagerRelationSelectorAutoComplete group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the question' selectionMode='single' objectType='question' linkingItem=$linkingItem idPrefix=$idPrefix createLink=$createLink withImage=false}
        <div class="surveymanager-relation-leftside">
            {if isset($linkingItem.$alias)}
                {include file='admin/question/include_selectItemListOne.tpl'  item=$linkingItem.$alias}
            {else}
                {include file='admin/question/include_selectItemListOne.tpl' }
            {/if}
        </div>
        <br class="z-clearer" />
    {/if}
    </div>
</fieldset>
