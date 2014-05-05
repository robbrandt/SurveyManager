{* purpose of this template: surveys view view in user area *}
{include file='user/header.tpl'}
<div class="surveymanager-survey surveymanager-view">
{gt text='Survey list' assign='templateTitle'}
{gt text='Surveys' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>

    {foreach item='content' from=$renderedSurveys}
        {$content}
    {/foreach}
</div>
</div>
{include file='user/footer.tpl'}
