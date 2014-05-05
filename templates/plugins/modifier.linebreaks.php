<?php

function smarty_modifier_linebreaks($string)
{
    if (!preg_match("/<br( \\/)?>/", $string) && !preg_match("/<\\/?p>/", $string)) {
        return preg_replace("/(\r\n|\r|\n)/", "<br />", $string);
    } else {
        return "{$string}";
    }
}
