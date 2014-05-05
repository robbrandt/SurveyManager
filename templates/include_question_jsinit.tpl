{if !isset($context)}
{assign var='context' value='survey_display'}
{/if}
{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    {pageaddvar name='javascript' value='prototype'}
    {pageaddvar name='javascript' value='validation.js'}
    {pageaddvar name='javascript' value='modules/SurveyManager/javascript/SurveyManager_utils.js'}
    <script type="text/javascript">
    /* <![CDATA[ */
        var questionTypes = new Array();
        var questionNames = new Array();
        var requiredQuestions = new Array();
        var questionValues = new Array();

{{* Note question selection types *}}
{{foreach item='question' from=$questions}}
        questionTypes[{{$question.id}}] = '{{$question.questionType}}';
{{/foreach}}

{{* Set up required questions for this step and collect question names as well as all values for single_ and multi_selection type questions *}}
{{foreach item='question' from=$questions}}
        questionNames[{{$question.id}}] = '{{$question.name|addslashes}}';
{{if $question.required}}
        requiredQuestions[requiredQuestions.length] = {{$question.id}};
{{if $question.questionType eq 'single_selection' || $question.questionType eq 'multi_selection'}}
        questionValues[{{$question.id}}] = new Array();
{{foreach key='valueKey' item='value' from=$question.questionValues}}
        questionValues[{{$question.id}}][{{$valueKey}}] = '{{$value|addslashes}}';
{{/foreach}}
{{/if}}
{{/if}}
{{/foreach}}

        document.observe('dom:loaded', function() {
            var valid = new Validation('inputform{{if $context eq 'block'}}block{{/if}}', {immediate: true, focusOnError: false});
        });
    /* ]]> */
    </script>
{/if}
