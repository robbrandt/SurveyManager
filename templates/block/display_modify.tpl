<div class="z-formrow">
    <label for="SurveyManager_survey">{gt text='Survey to display'}</label>
    <select id="SurveyManager_survey" name="sid">
    {if !$id}
        <option value="0" selected="selected">{gt text='No survey'}</option>
    {/if}
    {foreach item='survey' from=$surveys}
        <option value="{$survey.id}">{$survey.name}</option>
    {/foreach}
    </select>
</div>
