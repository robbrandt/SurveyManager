{* purpose of this template: show output of view response action in user area *}
{include file='user/header.tpl'}
<div class="surveymanager-viewresponse surveymanager-viewresponse">
    {gt text='View response' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    <p>Please override this template by moving it from <em>/modules/SurveyManager/templates/user/viewResponse.tpl</em> to either your <em>/themes/YourTheme/templates/modules/SurveyManager/user/viewResponse.tpl</em> or <em>/config/templates/SurveyManager/user/viewResponse.tpl</em>.</p>
</div>
{include file='user/footer.tpl'}
