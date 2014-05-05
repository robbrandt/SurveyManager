{* purpose of this template: responses view json view in user area *}
{surveymanagerTemplateHeaders contentType='application/json'}
[
{foreach item='item' from=$items name='responses'}
    {if not $smarty.foreach.responses.first},{/if}
    {$item->toJson()}
{/foreach}
]
