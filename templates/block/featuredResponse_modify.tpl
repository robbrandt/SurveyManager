<div class="z-formrow">
    <label for="SurveyManager_response">{gt text='Response'}</label>
    <select id="SurveyManager_response" name="id">
        <option value="0"{if !$id} selected="selected"{/if}>{gt text='No response'}</option>
    {foreach item='survey' from=$surveys}
        <optgroup label="{$survey.name}">
        {foreach item='surveyResponse' from=$survey.responses}
            {assign var='responseId' value=$surveyResponse.id}
            <option value="{$responseId}"{if $responseId eq $id} selected="selected"{/if}>{gt text='Response ID'} {$responseId}{if $surveyResponse.name_id && $surveyResponse.email_from} ({$surveyResponse.name_id|safetext}: {$surveyResponse.email_from|safetext}){elseif $surveyResponse.name_id} ({$surveyResponse.name_id|safetext}){elseif $surveyResponse.email_from} ({$surveyResponse.email_from|safetext}){/if}</option>
        {/foreach}
        </optgroup>
    {/foreach}
    </select>
</div>
