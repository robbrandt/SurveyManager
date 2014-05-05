{* purpose of this template: questions view json view in user area *}
{surveymanagerTemplateHeaders contentType='application/json'}
[
{foreach item='item' from=$items name='questions'}
    {if not $smarty.foreach.questions.first},{/if}
    {$item->toJson()}
{/foreach}
]
