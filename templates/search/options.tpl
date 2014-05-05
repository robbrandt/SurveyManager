{* Purpose of this template: Display search options *}
<input type="hidden" id="surveyManagerActive" name="active[SurveyManager]" value="1" checked="checked" />
<div>
    <input type="checkbox" id="active_surveyManagerSurveys" name="surveyManagerSearchTypes[]" value="survey"{if $active_survey} checked="checked"{/if} />
    <label for="active_surveyManagerSurveys">{gt text='Surveys' domain='module_surveymanager'}</label>
</div>
<div>
    <input type="checkbox" id="active_surveyManagerPages" name="surveyManagerSearchTypes[]" value="page"{if $active_page} checked="checked"{/if} />
    <label for="active_surveyManagerPages">{gt text='Pages' domain='module_surveymanager'}</label>
</div>
<div>
    <input type="checkbox" id="active_surveyManagerQuestions" name="surveyManagerSearchTypes[]" value="question"{if $active_question} checked="checked"{/if} />
    <label for="active_surveyManagerQuestions">{gt text='Questions' domain='module_surveymanager'}</label>
</div>
<div>
    <input type="checkbox" id="active_surveyManagerResponses" name="surveyManagerSearchTypes[]" value="response"{if $active_response} checked="checked"{/if} />
    <label for="active_surveyManagerResponses">{gt text='Responses' domain='module_surveymanager'}</label>
</div>
<div>
    <input type="checkbox" id="active_surveyManagerResponseDatas" name="surveyManagerSearchTypes[]" value="responseData"{if $active_responseData} checked="checked"{/if} />
    <label for="active_surveyManagerResponseDatas">{gt text='Response datas' domain='module_surveymanager'}</label>
</div>
