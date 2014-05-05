{* purpose of this template: response datas view json view in admin area *}
{surveymanagerTemplateHeaders contentType='application/json'}
[
{foreach item='item' from=$items name='responseDatas'}
    {if not $smarty.foreach.responseDatas.first},{/if}
    {$item->toJson()}
{/foreach}
]
