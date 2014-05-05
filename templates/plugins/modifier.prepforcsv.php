<?php

/**
 * smarty_modifier_prepforcsv()
 *
 * Prepares data for insertion into one field of a CSV file.
 *
 * @param    $input        The input text
 * @return                The output text
 */
function smarty_modifier_prepforcsv($input)
{
    $input = str_replace('"', '""', $input);
    
    return $input;
}
