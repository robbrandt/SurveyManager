{* purpose of this template: pages view json view in admin area *}
{surveymanagerTemplateHeaders contentType='application/json'}
[
{foreach item='item' from=$items name='pages'}
    {if not $smarty.foreach.pages.first},{/if}
    {$item->toJson()}
{/foreach}
]
