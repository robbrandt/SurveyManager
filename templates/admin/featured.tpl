{* purpose of this template: show output of featured action in admin area *}
{include file='admin/header.tpl'}
<div class="surveymanager-featured surveymanager-featured">
{gt text='Featured' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-admin-content-pagetitle">
    {icon type='gears' size='small' __alt='Featured'}
    <h3>{$templateTitle}</h3>
</div>

<div class="z-warningmsg">
    <p>{gt text='These responses have been flagged as "Featured". They will be displayed on the "Featured Responses" page. To flag a response as "Featured", find it in the main Reponses lists and edit it.'}<br />
    <br />
    {gt text='This page, and this feature, are entirely optional, and not all sites will make use of them.'}</p>
</div>

<div class="surveymanager_response_jump">
    <form id="filterform" method="get" action="{modurl modname='SurveyManager' type='admin' func='featured'}">
        <div>
            <label for="sid">{gt text='Switch surveys:'}</label>
            <select id="sid" name="sid">
            {foreach item='survey' from=$surveys}
                <option value="{$survey.id}"{if $survey.id eq $sid} selected="selected"{/if}>{$survey.name}</option>
            {/foreach}
            </select>
            <input type="submit" name="submit" id="submit" value="Switch" />
        </div>
    </form>
</div>

{surveymanagerHasResponseValue questionType='name_id' responses=$responses assign='useNameIdColumn'}
{surveymanagerHasResponseValue questionType='email_from' responses=$responses assign='useEmailFromColumn'}

<table class="z-datatable">
    <colgroup>
        <col id="cmoveup" />
        <col id="cmovedown" />
        <col id="cid" />
        {if $useNameIdColumn}<col id="crespondant" />{/if}
        {if $useEmailFromColumn}<col id="cemail" />{/if}
        <col id="csurvey" />
        <col id="cresponsetimestamp" />
        <col id="cipaddress" />
        <col id="citemactions" />
    </colgroup>
    <thead>
    <tr>
        <th colspan="2">&nbsp;</th>
        <th id="hid" scope="col" class="z-left">
            {gt text='Response ID'}
        </th>
    {if $useNameIdColumn}
        <th id="hrespondant" scope="col" class="z-left">
            {gt text='Respondant'}
        </th>
    {/if}
    {if $useEmailFromColumn}
        <th id="hemail" scope="col" class="z-left">
            {gt text='Email'}
        </th>
    {/if}
        <th id="hsurvey" scope="col" class="z-left">
            {gt text='Survey'}
        </th>
        <th id="hresponsetimestamp" scope="col" class="z-left">
            {gt text='Timestamp'}
        </th>
        <th id="hipaddress" scope="col" class="z-left">
            {gt text='IP address'}
        </th>
        <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
    </tr>
    </thead>
    <tbody>
{foreach name='responseLoop' item='response' from=$orderedResponses}
    <tr class="{cycle values='z-odd, z-even'}">
        <td class="z-left">
        {if !$smarty.foreach.responseLoop.first}
            <a href="{modurl modname='SurveyManager' type='admin' func='featured' up=$response.responseid sid=$response.survey.id}" class="z-icon-es-up">{gt text='Up'}</a>
        {else}&nbsp;
        {/if}
        </td>
        <td class="z-left">
        {if !$smarty.foreach.responseLoop.last}
            <a href="{modurl modname='SurveyManager' type='admin' func='featured' down=$response.responseid sid=$response.survey.id}" class="z-icon-es-down">{gt text='Down'}</a>
        {else}&nbsp;
        {/if}
        </td>
        <td headers="hid" class="z-left">
            {$response.id}
        </td>
    {if $useNameIdColumn}
        <td headers="hrespondant" class="z-left">
            {$response.name_id}
        </td>
    {/if}
    {if $useEmailFromColumn}
        <td headers="hemail" class="z-left">
            {$response.email_from}
        </td>
    {/if}
        <td headers="hsurvey" class="z-left">
            {if isset($response.Survey) && $response.Survey ne null}
                <a href="{modurl modname='SurveyManager' type='user' func='display' ot='survey' id=$response.Survey.id slug=$response.Survey.slug}">
                  {$response.Survey.name|default:""}
                </a>
            {else}
                {gt text='Not set.'}
            {/if}
        </td>
        <td headers="hresponsetimestamp" class="z-left">
            {$response.responseTimestamp|dateformat:'datetimelong'}
        </td>
        <td headers="hipaddress" class="z-left">
            {$response.ipAddress|notifyfilters:'surveymanager.filterhook.responses'}
        </td>
        <td headers="hitemactions" class="z-right z-nowrap z-w02">
        {checkpermission component='SurveyManager:Response:' instance="`$response.id`::" level='ACCESS_EDIT' assign='mayEdit'}
        {if $mayEdit}
            <a href="{modurl modname='SurveyManager' type='admin' func='edit' ot='response' id=$response.id}">{gt text='Edit'}</a>
        {else}&nbsp;
        {/if}
        </td>
    </tr>
{foreachelse}
    <tr class="z-admintableempty">
      <td class="z-left" colspan="5">
    {gt text='No responses found.'}
      </td>
    </tr>
{/foreach}
    </tbody>
</table>

</div>
{include file='admin/footer.tpl'}
