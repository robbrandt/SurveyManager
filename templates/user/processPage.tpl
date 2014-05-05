{* purpose of this template: show output of process page action in user area *}
{include file='user/header.tpl'}
<div class="surveymanager-processpage surveymanager-processpage">
    {gt text='Process page' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    <p>Please override this template by moving it from <em>/modules/SurveyManager/templates/user/processPage.tpl</em> to either your <em>/themes/YourTheme/templates/modules/SurveyManager/user/processPage.tpl</em> or <em>/config/templates/SurveyManager/user/processPage.tpl</em>.</p>
</div>
{include file='user/footer.tpl'}
