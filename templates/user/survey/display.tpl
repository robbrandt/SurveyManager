{* purpose of this template: surveys display view in user area *}
{pageaddvar name='javascript' value='modules/SurveyManager/javascript/SurveyManager_utils.js'}
{include file='user/header.tpl'}
<div class="surveymanager-survey surveymanager-display">
{gt text='Survey' assign='templateTitle'}
{assign var='templateTitle' value=$page.name|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-frontendcontainer">
    <form enctype="multipart/form-data" id="inputform" method="post" action="{modurl modname='SurveyManager' type='user' func='processPage'}" onsubmit="return checkRequiredQuestions();">
        <div>
            <input type="hidden" name="id" id="id" value="{$survey.id}" />
            <input type="hidden" name="page" id="page" value="{$page.id}" />
            <input type="hidden" name="MAX_FILE_SIZE" id="MAX_FILE_SIZE" value="{$maxFileSizeB}" />
        </div>
        <div class="surveymanager_step_display">
            <h2>{$templateTitle|notifyfilters:'surveymanager.filter_hooks.surveys.filter'}</h2>
            {checkpermissionblock component='SurveyManager::' instance='.*' level='ACCESS_ADMIN'}
            <p>(<a href="{modurl modname='SurveyManager' type='admin' func='view'}" title="Switch to backend area" class="z-icon-es-config">{gt text='Manage Surveys'}</a>)</p>
            {/checkpermissionblock}

            <div class="surveymanager_page_description">
                {$page.description|default:'&nbsp;'|linebreaks}
            </div>

            {if $missingQuestion && $missingQuestion ne ''}
            {assign var='missingQuestionData' value=$allQuestions.$missingQuestion}
            <p class="surveymanager_missing_question">Please make a selection from "{$missingQuestionData.name|safetext}" before going on to the next page.</p>
            {/if}

            {foreach item='question' key='questionId' from=$questionsInCurrentPage}
                {assign var='questionType' value=$question.questionType}
                {if !$failedDependencyChecks[$questionId]}
                    <div class="surveymanager_question_display">
                        {$questionHandlers.$questionType->getEditIntro($question, true)}
                        <div class="surveymanager_display_data_entry_field">
                            {$questionHandlers.$questionType->getEditInput($question, $responses.$questionId, 'user_survey_display')}
                        </div>
                    </div>
                {/if}
            {/foreach}

            {* include display hooks *}
            {notifydisplayhooks eventname='surveymanager.ui_hooks.surveys.display_view' id=$survey.id urlobject=$currentUrlObject assign='hooks'}
            {foreach key='providerArea' item='hook' from=$hooks}
                {if $providerArea ne 'provider.tag.ui_hooks.service' && ($survey.useCaptcha || $providerArea ne 'provider.captcha.ui_hooks.service')}
                    {$hook}
                {/if}
            {/foreach}

            <div class="surveymanager_clearance">&nbsp;</div>
            <p>&nbsp;</p>

            {if !$isLastPage}
                <input type="submit" name="submitbutton" id="submit" value="{gt text='Next page'} &gt;&gt;" />
            {else}
                <input type="submit" name="submitbutton" id="submit" value="{gt text='Send response'}" />
            {/if}
        </div>
    </form>
    <div class="surveymanager_clearance">&nbsp;</div>
</div>
</div>
{include file='user/footer.tpl'}

{include file='include_question_jsinit.tpl' questions=$questionsInCurrentPage context='survey_display'}
