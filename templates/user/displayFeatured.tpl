{* purpose of this template: show output of display featured action in user area *}
<div class="surveymanager-displayfeatured surveymanager-displayfeatured">
{capture assign='templateTitle'}{gt text='Featured responses for'} {$survey.name}{/capture}
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer">
    <h2>{gt text='Featured Responses for'} <em>{$survey.name}</em></h2>
    {foreach item='response' from=$responses}
        {assign var='rid' value=$response.id}
        {$renderedResponses.$rid}
    {/foreach}
</div>
</div>
