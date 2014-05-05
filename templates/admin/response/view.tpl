{* purpose of this template: responses view view in admin area *}
{pageaddvar name='stylesheet' value='modules/SurveyManager/style/manual.css'}
{include file='admin/header.tpl'}
<div class="surveymanager-response surveymanager-view">
{gt text='Response list' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-admin-content-pagetitle">
    {icon type='view' size='small' alt=$templateTitle}
    <h3>{$templateTitle}</h3>
</div>

{*checkpermissionblock component='SurveyManager:Response:' instance='.*' level='ACCESS_ADD'}
    {gt text='Create response' assign='createTitle'}
    <a href="{modurl modname='SurveyManager' type='admin' func='edit' ot='response'}" title="{$createTitle}" class="z-icon-es-add">
        {$createTitle}
    </a>
{/checkpermissionblock*}
{assign var='own' value=0}
{if isset($showOwnEntries) && $showOwnEntries eq 1}
    {assign var='own' value=1}
{/if}
{assign var='all' value=0}
{*if isset($showAllEntries) && $showAllEntries eq 1}
    {gt text='Back to paginated view' assign='linkTitle'}
    <a href="{modurl modname='SurveyManager' type='admin' func='view' ot='response'}" title="{$linkTitle}" class="z-icon-es-view">
        {$linkTitle}
    </a>
    {assign var='all' value=1}
{else}
    {gt text='Show all entries' assign='linkTitle'}
    <a href="{modurl modname='SurveyManager' type='admin' func='view' ot='response' all=1}" title="{$linkTitle}" class="z-icon-es-view">
        {$linkTitle}
    </a>
{/if*}

{include file='admin/response/view_quickNav.tpl'}{* see template file for available options *}

<div class="z-informationmsg">
    <p>{gt text='Here you can browse the list of responses that have been submitted. Click "Edit" by a response to edit its details. If you prefer to jump directly to a Response ID, use the box directly below this text.'}</p>
</div>

<div class="surveymanager_response_jump">
    <label for="response_id">{gt text='Jump to a Response ID:'}</label>
    <input type="text" name="response_id" id="response_id" value="" size="10" />
    <input type="button" name="response_jump" id="response_jump" value="Go" /><br />
</div>

{surveymanagerHasResponseValue questionType='name_id' responses=$items assign='useNameIdColumn'}
{surveymanagerHasResponseValue questionType='email_from' responses=$items assign='useEmailFromColumn'}

<table class="z-datatable">
    <colgroup>
        <col id="cid" />
        {if $useNameIdColumn}<col id="crespondant" />{/if}
        {if $useEmailFromColumn}<col id="cemail" />{/if}
        <col id="csurvey" />
        <col id="cresponsetimestamp" />
        <col id="cipaddress" />
{*        <col id="cfeatured" />*}
        <col id="citemactions" />
    </colgroup>
    <thead>
    <tr>
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
            {sortlink __linktext='Survey' sort='survey' currentsort=$sort sortdir=$sdir all=$all own=$own Survey=$Survey searchterm=$searchterm pageSize=$pageSize featured=$featured modname='SurveyManager' type='admin' func='view' ot='response'}
        </th>
        <th id="hresponsetimestamp" scope="col" class="z-left">
            {sortlink __linktext='Timestamp' sort='responseTimestamp' currentsort=$sort sortdir=$sdir all=$all own=$own Survey=$Survey searchterm=$searchterm pageSize=$pageSize featured=$featured modname='SurveyManager' type='admin' func='view' ot='response'}
        </th>
        <th id="hipaddress" scope="col" class="z-left">
            {sortlink __linktext='IP address' sort='ipAddress' currentsort=$sort sortdir=$sdir all=$all own=$own Survey=$Survey searchterm=$searchterm pageSize=$pageSize featured=$featured modname='SurveyManager' type='admin' func='view' ot='response'}
        </th>
{*        <th id="hfeatured" scope="col" class="z-center">
            {sortlink __linktext='Featured' sort='featured' currentsort=$sort sortdir=$sdir all=$all own=$own Survey=$Survey searchterm=$searchterm pageSize=$pageSize featured=$featured modname='SurveyManager' type='admin' func='view' ot='response'}
        </th>*}
        <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
    </tr>
    </thead>
    <tbody>
{foreach item='response' from=$items}
    <tr class="{cycle values='z-odd, z-even'}">
        <td headers="hid" class="z-left">
            {$response.id}{if $response.featured} ({gt text='Featured'}){/if}
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
{*        <td headers="hfeatured" class="z-center">
            {$response.featured|yesno:true}
        </td>*}
        <td id="itemactions{$response.id}" headers="hitemactions" class="z-right z-nowrap z-w02">
            {checkpermission component='SurveyManager:Response:' instance="`$response.id`::" level='ACCESS_EDIT' assign='mayEdit'}
            {if $mayEdit}
                <a href="{modurl modname='SurveyManager' type='admin' func='edit' ot='response' id=$response.id}">{gt text='Edit'}</a>
            {else}&nbsp;
            {/if}
            {*if count($response._actions) gt 0}
                {foreach item='option' from=$response._actions}
                    <a href="{$option.url.type|surveymanagerActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                {/foreach}
                {icon id="itemactions`$response.id`trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                <script type="text/javascript">
                /* <![CDATA[ */
                    document.observe('dom:loaded', function() {
                        surveymanInitItemActions('response', 'view', 'itemactions{{$response.id}}');
                    });
                /* ]]> */
                </script>
            {/if*}
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

{if !isset($showAllEntries) || $showAllEntries ne 1}
    {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
{/if}

</div>
{include file='admin/footer.tpl'}

<script type="text/javascript">
/* <![CDATA[ */
    function smJumpToResponse () {
        location.href = 'index.php?module=SurveyManager&type=admin&func=edit&ot=response&id=' + $F('response_id');
    }

    document.observe('dom:loaded', function () {
        $('response_jump').observe('click', smJumpToResponse);
    });
/* ]]> */
</script>
