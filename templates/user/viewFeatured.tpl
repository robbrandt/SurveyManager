{* purpose of this template: show output of view featured action in user area *}
<div class="surveymanager-viewfeatured surveymanager-viewfeatured">
{if $survey}
{capture assign='templateTitle'}{gt text='Featured responses for'} {$survey.name}{/capture}
{else}
{gt text='Featured responses' assign='templateTitle}
{/if}
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>

    {surveymanagerHasResponseValue questionType='name_id' responses=$orderedResponses assign='useNameIdColumn'}
    <table class="z-datatable">
        <colgroup>
            <col id="cdate" />
            {if $useNameIdColumn}<col id="crespondant" />{/if}
            <col id="citemactions" />
        </colgroup>
        <thead>
        <tr>
            <th id="hdate" scope="col" class="z-left">{gt text='Date'}</th>
            {if $useNameIdColumn}
                <th id="hrespondant" scope="col" class="z-left">{gt text='Respondant'}</th>
            {/if}
            <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
        </tr>
        </thead>
        <tbody>
        {foreach key='rid' item='response' from=$orderedResponses}
        <tr class="{cycle values='z-odd, z-even'}">
            <td headers="hdate" class="z-left">{$response.responseTimestamp|dateformat:'datebrief'}</td>
            {if $useNameIdColumn}<td headers="hrespondant" class="z-left">{$response.name_id|safetext}</td>{/if}
            <td headers="hitemactions" class="z-right z-nowrap z-w02">
                <a href="{modurl modname='SurveyManager' type='user' func='detailFeatured' id=$response.id}">{gt text='View response'}</a>
            </td>
        </tr>
        {/foreach}
        </tbody>
    </table>
    {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
</div>
</div>
