{* purpose of this template: surveys view view in admin area *}
{pageaddvar name='stylesheet' value='modules/SurveyManager/style/manual.css'}
{include file='admin/header.tpl'}
<div class="surveymanager-survey surveymanager-view">
{gt text='Survey list' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-admin-content-pagetitle">
    {icon type='view' size='small' alt=$templateTitle}
    <h3>{$templateTitle}</h3>
</div>

{include file='admin/survey/view_quickNav.tpl'}{* see template file for available options *}

<div class="z-informationmsg">
    <p>{gt text='Use the open/close arrows below to browse surveys, pages and individual questions. Click on an item\'s title to edit the item. The data hierarchy is as follows:'}<br />
    <br />
    <strong>"{gt text='Surveys'}"</strong> contain <strong>"{gt text='Pages'}"</strong>. <strong>"{gt text='Pages'}"</strong> contain <strong>"{gt text='Questions'}"</strong>.</p>
</div>

{sessiongetvar name='SM_admin_expanded_surveys' default='' assign='expandedSurveys'}
{sessiongetvar name='SM_admin_expanded_pages' default='' assign='expandedPages'}

<table class="surveymanager_survey_list">
    <tr>
        <td colspan="5" class="surveymanager_swatch_cell">
            <span class="surveymanager_survey_swatch">{gt text='Surveys'}</span>
            <span class="surveymanager_page_swatch">{gt text='Pages'}</span>
            <span class="surveymanager_question_swatch">{gt text='Questions'}</span>
            <hr />
        </td>
    </tr>
    <tr>
        <th colspan="3">&nbsp;</th>
        <th>{gt text='Survey'}/{gt text='Page'}/{gt text='Question'}</th>
        <th>{gt text='Add child'}</th>
    </tr>
    <tr>
        <td colspan="3">&nbsp;</td>
        <td colspan="2">
        {checkpermissionblock component='SurveyManager:Survey:' instance='.*' level='ACCESS_ADD'}
            <a href="{modurl modname='SurveyManager' type='admin' func='edit' ot='survey'}" title="{gt text='Add a new survey'}" class="z-icon-es-add">{gt text='Add new survey'}</a> |
            <a href="{modurl modname='SurveyManager' type='admin' func='wizard'}" title="{gt text='Create survey using the wizard'}" class="z-icon-es-options">{gt text='Quick Survey Wizard'}</a>
        {/checkpermissionblock}
        </td>
    </tr>

{*
{assign var='own' value=0}
{assign var='all' value=0}

<table class="z-datatable">
    <colgroup>
        <col id="cname" />
        <col id="cdescription" />
        <col id="cthankyou" />
        <col id="cthankyoutitle" />
        <col id="cthankyoualternativeurl" />
        <col id="cweight" />
        <col id="cmaxperip" />
        <col id="cmaxperuserid" />
        <col id="cusecaptcha" />
        <col id="crecipients" />
        <col id="cresponsesubject" />
        <col id="cconfirmationsubject" />
        <col id="cconfirmationbody" />
        <col id="carchived" />
        <col id="ctemplate" />
{if $modvars.SurveyManager.useAddition1}
        <col id="caddition1" />
{/if}
{if $modvars.SurveyManager.useAddition2}
        <col id="caddition2" />
{/if}
{if $modvars.SurveyManager.useAddition3}
        <col id="caddition3" />
{/if}
{if $modvars.SurveyManager.useAddition4}
        <col id="caddition4" />
{/if}
{if $modvars.SurveyManager.useAddition5}
        <col id="caddition5" />
{/if}
        <col id="citemactions" />
    </colgroup>
    <thead>
    <tr>
        <th id="hname" scope="col" class="z-left">
            {sortlink __linktext='Name' sort='name' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
        <th id="hdescription" scope="col" class="z-left">
            {sortlink __linktext='Description' sort='description' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
        <th id="hthankyou" scope="col" class="z-left">
            {sortlink __linktext='Thank you' sort='thankYou' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
        <th id="hthankyoutitle" scope="col" class="z-left">
            {sortlink __linktext='Thank you title' sort='thankYouTitle' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
        <th id="hthankyoualternativeurl" scope="col" class="z-left">
            {sortlink __linktext='Thank you alternative url' sort='thankYouAlternativeUrl' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
        <th id="hweight" scope="col" class="z-right">
            {sortlink __linktext='Weight' sort='weight' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
        <th id="hmaxperip" scope="col" class="z-right">
            {sortlink __linktext='Max per ip' sort='maxPerIp' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
        <th id="hmaxperuserid" scope="col" class="z-right">
            {sortlink __linktext='Max per user id' sort='maxPerUserId' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
        <th id="husecaptcha" scope="col" class="z-center">
            {sortlink __linktext='Use captcha' sort='useCaptcha' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
        <th id="hrecipients" scope="col" class="z-left">
            {sortlink __linktext='Recipients' sort='recipients' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
        <th id="hresponsesubject" scope="col" class="z-left">
            {sortlink __linktext='Response subject' sort='responseSubject' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
        <th id="hconfirmationsubject" scope="col" class="z-left">
            {sortlink __linktext='Confirmation subject' sort='confirmationSubject' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
        <th id="hconfirmationbody" scope="col" class="z-left">
            {sortlink __linktext='Confirmation body' sort='confirmationBody' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
        <th id="harchived" scope="col" class="z-center">
            {sortlink __linktext='Archived' sort='archived' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
        <th id="htemplate" scope="col" class="z-center">
            {sortlink __linktext='Template' sort='template' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
{if $modvars.SurveyManager.useAddition1}
        <th id="haddition1" scope="col" class="z-left">
            {sortlink __linktext='Addition1' sort='addition1' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
{/if}
{if $modvars.SurveyManager.useAddition2}
        <th id="haddition2" scope="col" class="z-left">
            {sortlink __linktext='Addition2' sort='addition2' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
{/if}
{if $modvars.SurveyManager.useAddition3}
        <th id="haddition3" scope="col" class="z-left">
            {sortlink __linktext='Addition3' sort='addition3' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
{/if}
{if $modvars.SurveyManager.useAddition4}
        <th id="haddition4" scope="col" class="z-left">
            {sortlink __linktext='Addition4' sort='addition4' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
{/if}
{if $modvars.SurveyManager.useAddition5}
        <th id="haddition5" scope="col" class="z-left">
            {sortlink __linktext='Addition5' sort='addition5' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize useCaptcha=$useCaptcha archived=$archived template=$template modname='SurveyManager' type='admin' func='view' ot='survey'}
        </th>
{/if}
        <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
    </tr>
    </thead>
    <tbody>

{foreach item='survey' from=$items}
    <tr class="{cycle values='z-odd, z-even'}">
        <td headers="hname" class="z-left">
            {$survey.name|notifyfilters:'surveymanager.filterhook.surveys'}
        </td>
        <td headers="hdescription" class="z-left">
            {$survey.description}
        </td>
        <td headers="hthankyou" class="z-left">
            {$survey.thankYou}
        </td>
        <td headers="hthankyoutitle" class="z-left">
            {$survey.thankYouTitle}
        </td>
        <td headers="hthankyoualternativeurl" class="z-left">
            {if $survey.thankYouAlternativeUrl ne ''}
                <a href="{$survey.thankYouAlternativeUrl}" title="{gt text='Visit this page'}">{icon type='url' size='extrasmall' __alt='Homepage'}</a>
            {else}&nbsp;{/if}
        </td>
        <td headers="hweight" class="z-right">
            {$survey.weight}
        </td>
        <td headers="hmaxperip" class="z-right">
            {$survey.maxPerIp}
        </td>
        <td headers="hmaxperuserid" class="z-right">
            {$survey.maxPerUserId}
        </td>
        <td headers="husecaptcha" class="z-center">
            {$survey.useCaptcha|yesno:true}
        </td>
        <td headers="hrecipients" class="z-left">
            {$survey.recipients}
        </td>
        <td headers="hresponsesubject" class="z-left">
            {$survey.responseSubject}
        </td>
        <td headers="hconfirmationsubject" class="z-left">
            {$survey.confirmationSubject}
        </td>
        <td headers="hconfirmationbody" class="z-left">
            {$survey.confirmationBody}
        </td>
        <td headers="harchived" class="z-center">
            {assign var='itemid' value=$survey.id}
            <a id="togglearchived{$itemid}" href="javascript:void(0);" class="z-hide">
            {if $survey.archived}
                {icon type='ok' size='extrasmall' __alt='Yes' id="yesarchived_`$itemid`" __title='This setting is enabled. Click here to disable it.'}
                {icon type='cancel' size='extrasmall' __alt='No' id="noarchived_`$itemid`" __title='This setting is disabled. Click here to enable it.' class='z-hide'}
            {else}
                {icon type='ok' size='extrasmall' __alt='Yes' id="yesarchived_`$itemid`" __title='This setting is enabled. Click here to disable it.' class='z-hide'}
                {icon type='cancel' size='extrasmall' __alt='No' id="noarchived_`$itemid`" __title='This setting is disabled. Click here to enable it.'}
            {/if}
            </a>
            <noscript><div id="noscriptarchived{$itemid}">
                {$survey.archived|yesno:true}
            </div></noscript>
        </td>
        <td headers="htemplate" class="z-center">
            {$survey.template|yesno:true}
        </td>
{if $modvars.SurveyManager.useAddition1}
        <td headers="haddition1" class="z-left">
            {$survey.addition1}
        </td>
{/if}
{if $modvars.SurveyManager.useAddition2}
        <td headers="haddition2" class="z-left">
            {$survey.addition2}
        </td>
{/if}
{if $modvars.SurveyManager.useAddition3}
        <td headers="haddition3" class="z-left">
            {$survey.addition3}
        </td>
{/if}
{if $modvars.SurveyManager.useAddition4}
        <td headers="haddition4" class="z-left">
            {$survey.addition4}
        </td>
{/if}
{if $modvars.SurveyManager.useAddition5}
        <td headers="haddition5" class="z-left">
            {$survey.addition5}
        </td>
{/if}
        <td id="itemactions{$survey.id}" headers="hitemactions" class="z-right z-nowrap z-w02">
            {if count($survey._actions) gt 0}
                {foreach item='option' from=$survey._actions}
                    <a href="{$option.url.type|surveymanagerActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                {/foreach}
                {icon id="itemactions`$survey.id`trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                <script type="text/javascript">
                /* <![CDATA[ */
                    document.observe('dom:loaded', function() {
                        surveymanInitItemActions('survey', 'view', 'itemactions{{$survey.id}}');
                    });
                /* ]]> */
                </script>
            {/if}
        </td>
    </tr>
{foreachelse}
{assign var='columnCount' value=16}
{if $modvars.SurveyManager.useAddition1}
{assign var='columnCount' value=$columnCount+1}
{/if}
{if $modvars.SurveyManager.useAddition2}
{assign var='columnCount' value=$columnCount+1}
{/if}
{if $modvars.SurveyManager.useAddition3}
{assign var='columnCount' value=$columnCount+1}
{/if}
{if $modvars.SurveyManager.useAddition4}
{assign var='columnCount' value=$columnCount+1}
{/if}
{if $modvars.SurveyManager.useAddition5}
{assign var='columnCount' value=$columnCount+1}
{/if}
    <tr class="z-admintableempty">
      <td class="z-left" colspan="{$columnCount}">
    {gt text='No surveys found.'}
      </td>
    </tr>
{/foreach}

    </tbody>
</table>
*}

    <tr>
        <td colspan="5">{pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}</td>
    </tr>
    {if $items ne null && $items ne ''}
    {foreach name='surveyLoop' item='survey' from=$items}
    {if isset($survey.id)}
        <tr class="surveymanager_survey_row">
            <td>
            {if !$smarty.foreach.surveyLoop.first}
                <a href="{modurl modname='SurveyManager' type='admin' func='treeOp' op='moveUp' ot='survey' id=$survey.id}" title="{gt text='Move up'}" class="z-icon-es-up">{gt text='Up'}</a>
            {else}&nbsp;
            {/if}
            </td>
            <td>
            {if !$smarty.foreach.surveyLoop.last}
                <a href="{modurl modname='SurveyManager' type='admin' func='treeOp' op='moveDown' ot='survey' id=$survey.id}" title="{gt text='Move down'}" class="z-icon-es-down">{gt text='Down'}</a>
            {else}&nbsp;
            {/if}
            </td>
            <td>
            {if count($survey.pages) gt 0}
                {assign var='sid' value=$survey.id}
                {if isset($expandedSurveys.$sid)}
                <a href="{modurl modname='SurveyManager' type='admin' func='treeOp' op='collapse' ot='survey' id=$survey.id}" title="{gt text='Collapse'}" class="z-icon-es-collapse">{gt text='Collapse'}</a>
                {else}
                <a href="{modurl modname='SurveyManager' type='admin' func='treeOp' op='expand' ot='survey' id=$survey.id}" title="{gt text='Expand'}" class="z-icon-es-expand">{gt text='Expand'}</a>
                {/if}
            {else}&nbsp;
            {/if}
            </td>
            {checkpermission component='SurveyManager:Survey:' instance="`$survey.id`::" level='ACCESS_EDIT' assign='mayEditSurvey'}
            <td>
                {gt text='Survey'}:
                {if $mayEditSurvey}
                <a href="{modurl modname='SurveyManager' type='admin' func='edit' ot='survey' id=$survey.id}">{$survey.name}</a>
                (<a href="{modurl modname='SurveyManager' type='user' func='display' ot='survey' id=$survey.id}" title="{gt text='Display this survey'}" class="z-icon-es-display" target="_blank">{gt text='View'}</a> 
                {if count($survey.pages) eq 1}
                | <a href="{modurl modname='SurveyManager' type='admin' func='wizard' id=$survey.id}" title="{gt text='Edit survey using the wizard'}" class="z-icon-es-options">{gt text='Wizard'}</a>
                {/if}
                {if $survey.template}
                | <a href="{modurl modname='SurveyManager' type='admin' func='edit' ot='survey' astemplate=$survey.id}" title="{gt text='Reuse this survey'}" class="z-icon-es-saveas">{gt text='Reuse'}</a>
                {/if}
                | <a href="{modurl modname='SurveyManager' type='admin' func='exportSurvey' id=$survey.id}" title="{gt text='Export this survey'}" class="z-icon-es-export">{gt text='Export'}</a>
                {else}
                {$survey.name}
                {/if})
            </td>
            <td>
            {if $mayEditSurvey}
                <a href="{modurl modname='SurveyManager' type='admin' func='edit' ot='page' survey=$survey.id}" title="{gt text='Add child'}" class="z-icon-es-add">{gt text='Add child'}</a>
            {else}&nbsp;
            {/if}
            </td>
        </tr>

        {if $survey.pages && $survey.pages ne ''}
        {foreach name='pageLoop' item='page' from=$survey.pages}
        {assign var='surveyId' value=$page.survey.id}
        {if isset($expandedSurveys.$surveyId)}
            <tr class="surveymanager_page_row">
                <td>
                {if !$smarty.foreach.pageLoop.first}
                    <a href="{modurl modname='SurveyManager' type='admin' func='treeOp' op='moveUp' ot='page' id=$page.id}" title="{gt text='Move up'}" class="z-icon-es-up">{gt text='Up'}</a>
                {else}&nbsp;
                {/if}
                </td>
                <td>
                {if !$smarty.foreach.pageLoop.last}
                    <a href="{modurl modname='SurveyManager' type='admin' func='treeOp' op='moveDown' ot='page' id=$page.id}" title="{gt text='Move down'}" class="z-icon-es-down">{gt text='Down'}</a>
                {else}&nbsp;
                {/if}
                </td>
                <td>
                {if count($page.questions) gt 0}
                    {assign var='pid' value=$page.id}
                    {if isset($expandedPages.$pid)}
                    <a href="{modurl modname='SurveyManager' type='admin' func='treeOp' op='collapse' ot='page' id=$page.id}" title="{gt text='Collapse'}" class="z-icon-es-collapse">{gt text='Collapse'}</a>
                    {else}
                    <a href="{modurl modname='SurveyManager' type='admin' func='treeOp' op='expand' ot='page' id=$page.id}" title="{gt text='Expand'}" class="z-icon-es-expand">{gt text='Expand'}</a>
                    {/if}
                {else}&nbsp;
                {/if}
                </td>
                {checkpermission component='SurveyManager:Page:' instance="`$page.id`::" level='ACCESS_EDIT' assign='mayEditPage'}
                <td class="surveymanager_page_cell">
                    <img src="modules/SurveyManager/images/l.gif" alt="&ndash;&gt;" width="19" height="9" />
                    {gt text='Page'}:
                    {if $mayEditPage}
                    <a href="{modurl modname='SurveyManager' type='admin' func='edit' ot='page' id=$page.id}">{$page.name}</a>
                    {else}
                    {$page.name}
                    {/if}
                </td>
                <td>
                {if $mayEditPage}
                    <a href="{modurl modname='SurveyManager' type='admin' func='edit' ot='question' page=$page.id}" title="{gt text='Add child'}" class="z-icon-es-add">{gt text='Add child'}</a>
                {else}&nbsp;
                {/if}
                </td>
            </tr>

            {if $page.questions && $page.questions ne ''}
            {foreach name='questionLoop' item='question' from=$page.questions}
            {assign var='pageId' value=$question.page.id}
            {if isset($expandedPages.$pageId)}
            <tr class="surveymanager_question_row">
                <td>
                {if !$smarty.foreach.questionLoop.first}
                    <a href="{modurl modname='SurveyManager' type='admin' func='treeOp' op='moveUp' ot='question' id=$question.id}" title="{gt text='Move up'}" class="z-icon-es-up">{gt text='Up'}</a>
                {else}&nbsp;
                {/if}
                </td>
                <td>
                {if !$smarty.foreach.questionLoop.last}
                    <a href="{modurl modname='SurveyManager' type='admin' func='treeOp' op='moveDown' ot='question' id=$question.id}" title="{gt text='Move down'}" class="z-icon-es-down">{gt text='Down'}</a>
                {else}&nbsp;
                {/if}
                </td>
                <td>&nbsp;</td>
                {checkpermission component='SurveyManager:Question:' instance="`$question.id`::" level='ACCESS_EDIT' assign='mayEditQuestion'}
                <td class="surveymanager_question_cell">
                    <img src="modules/SurveyManager/images/l.gif" alt="&ndash;&gt;" width="19" height="9" />
                    {gt text='Question'}:
                    {if $mayEditQuestion}
                    <a href="{modurl modname='SurveyManager' type='admin' func='edit' ot='question' id=$question.id}">{$question.name}</a>
                    {else}
                    {$question.name}
                    {/if}
                    {if !empty($question.dependencies) && is_array($question.dependencies) && count($question.dependencies) > 0}
                        {assign var='hasDependencies' value=false}
                        {foreach item='dependency' from=$question.dependencies}
                            {if $dependency ne '0'}
                                {assign var='hasDependencies' value=true}
                            {/if}
                        {/foreach}
                        {if $hasDependencies}
                            <span class="z-sub">({gt text='has dependencies'})</span>
                        {/if}
                    {/if}
                </td>
                <td>&nbsp;</td>
            </tr>
            {/if}
            {/foreach}
            {/if}
        {/if}
        {/foreach}
        {/if}
    {/if}
    {/foreach}
    {/if}
    <tr>
        <td colspan="5">{pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}</td>
    </tr>
</table>

</div>
{include file='admin/footer.tpl'}
{*
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function () {
    {{foreach item='survey' from=$items}}
        {{assign var='itemid' value=$survey.id}}
        surveymanInitToggle('survey', 'archived', '{{$itemid}}');
    {{/foreach}}
    });
/* ]]> */
</script>
*}
