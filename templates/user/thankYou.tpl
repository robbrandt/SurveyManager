{* purpose of this template: show output of thank you action in user area *}
{include file='user/header.tpl'}
<div class="surveymanager-thankyou surveymanager-thankyou">
{gt text='Survey complete' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
{if $survey.thankYouTitle ne ''}
    {assign var='templateTitle' value=$survey.thankYouTitle}
{/if}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>
    {$survey.thankYou|linebreaks}
</div>
</div>
{include file='user/footer.tpl'}
