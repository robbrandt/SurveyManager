{* purpose of this template: show output of clear responses action in user area *}
{include file='user/header.tpl'}
<div class="surveymanager-clearresponses surveymanager-clearresponses">
    {gt text='Clear responses' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    <p>Please override this template by moving it from <em>/modules/SurveyManager/templates/user/clearResponses.tpl</em> to either your <em>/themes/YourTheme/templates/modules/SurveyManager/user/clearResponses.tpl</em> or <em>/config/templates/SurveyManager/user/clearResponses.tpl</em>.</p>
</div>
{include file='user/footer.tpl'}
