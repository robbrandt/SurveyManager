{assign var='first' value=true}
{foreach item='columnName' from=$headerRow}{if $first}{assign var='first' value=false}{else},{/if}"{$columnName|prepforcsv}"{/foreach}

{foreach item='row' from=$exportData}{assign var='first' value='true'}{foreach item='columnData' from=$row}{if $first}{assign var='first' value=false}{else},{/if}"{$columnData|prepforcsv}"{/foreach}

{/foreach}
