{* purpose of this template: show message about that the maximum amount of responses for this user id has been reached *}
{include file='user/header.tpl'}
<div class="surveymanager-uidmaxxed surveymanager-uidmaxxed">
{gt text='Sorry!' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>
    <p>{gt text='You've taken this survey as many times as you\'re allowed to. Please visit our other pages.'}</p>
</div>
</div>
{include file='user/footer.tpl'}
