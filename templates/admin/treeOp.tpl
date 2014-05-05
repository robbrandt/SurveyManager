{* purpose of this template: show output of tree op action in admin area *}
{include file='admin/header.tpl'}
<div class="surveymanager-treeop surveymanager-treeop">
    {gt text='Tree op' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='options' size='small' __alt='Tree op'}
        <h3>{$templateTitle}</h3>
    </div>

    <p>Please override this template by moving it from <em>/modules/SurveyManager/templates/admin/treeOp.tpl</em> to either your <em>/themes/YourTheme/templates/modules/SurveyManager/admin/treeOp.tpl</em> or <em>/config/templates/SurveyManager/admin/treeOp.tpl</em>.</p>
</div>
{include file='admin/footer.tpl'}
