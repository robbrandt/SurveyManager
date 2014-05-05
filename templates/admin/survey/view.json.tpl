{* purpose of this template: surveys view json view in admin area *}
{surveymanagerTemplateHeaders contentType='application/json'}
[
{foreach item='item' from=$items name='surveys'}
    {if not $smarty.foreach.surveys.first},{/if}
    {$item->toJson()}
{/foreach}
]
