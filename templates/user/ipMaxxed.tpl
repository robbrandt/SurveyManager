{* purpose of this template: show message about that the maximum amount of responses for this ip address has been reached *}
{include file='user/header.tpl'}
<div class="surveymanager-ipmaxxed surveymanager-ipmaxxed">
{gt text='Sorry!' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>
    <p>{gt text='You've taken this survey as many times as you\'re allowed to. Please visit our other pages.'}</p>
</div>
</div>
{include file='user/footer.tpl'}
