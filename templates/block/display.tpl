<div id="SurveyManager_block_display">
    <h2>{$survey.name}</h2>
    <br />
    <form enctype="multipart/form-data" id="inputformblock" method="post" action="{modurl modname='SurveyManager' type='user' func='processPage' id=$id}" onsubmit="return checkRequiredQuestions();">
    <div>
        <input type="hidden" name="id" id="id" value="{$survey.id}" />
        <input type="hidden" name="page" id="page" value="{$page.id}" />
        <input type="hidden" name="MAX_FILE_SIZE" id="MAX_FILE_SIZE" value="{$maxFileSizeB}" />
    {foreach item='question' from=$questions}
        {assign var='questionId' value=$question.id}
        {assign var='questionType' value=$question.questionType}
        {$questionHandlers.$questionType->getEditIntro($question)}
        {$questionHandlers.$questionType->getEditInput($question, $responses.$questionId, 'block_survey_display')}
    {/foreach}
        <p class="z-center">
            <input type="submit" />
        </p>
    </div>
    </form>
</div>

{include file='include_question_jsinit.tpl' questions=$questions context='block'}
