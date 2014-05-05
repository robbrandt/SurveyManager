{* purpose of this template: response datas display view in user area *}
{include file='user/header.tpl'}
<div class="surveymanager-responsedata surveymanager-display">
    {gt text='Response data' assign='templateTitle'}
    {assign var='templateTitle' value=$responseData->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <h2>{$templateTitle|notifyfilters:'surveymanager.filter_hooks.responsedatas.filter'}{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h2>

    <dl>
        <dt>{gt text='Response value'}</dt>
        <dd>{$responseData.responseValue}</dd>
        <dt>{gt text='Grade'}</dt>
        <dd>{$responseData.grade}</dd>
        <dt>{gt text='Correctness'}</dt>
        <dd>{$responseData.correctness}</dd>
        <dt>{gt text='Response'}</dt>
        <dd>
        {if isset($responseData.Response) && $responseData.Response ne null}
          {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
          <a href="{modurl modname='SurveyManager' type='user' func='display' ot='response' id=$responseData.Response.id}">{strip}
            {$responseData.Response->getTitleFromDisplayPattern()|default:""}
          {/strip}</a>
          <a id="responseItem{$responseData.Response.id}Display" href="{modurl modname='SurveyManager' type='user' func='display' ot='response' id=$responseData.Response.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
          <script type="text/javascript">
          /* <![CDATA[ */
              document.observe('dom:loaded', function() {
                  surveymanInitInlineWindow($('responseItem{{$responseData.Response.id}}Display'), '{{$responseData.Response->getTitleFromDisplayPattern()|replace:"'":""}}');
              });
          /* ]]> */
          </script>
          {else}
            {$responseData.Response->getTitleFromDisplayPattern()|default:""}
          {/if}
        {else}
            {gt text='Not set.'}
        {/if}
        </dd>
        <dt>{gt text='Question'}</dt>
        <dd>
        {if isset($responseData.Question) && $responseData.Question ne null}
          {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
          <a href="{modurl modname='SurveyManager' type='user' func='display' ot='question' id=$responseData.Question.id}">{strip}
            {$responseData.Question->getTitleFromDisplayPattern()|default:""}
          {/strip}</a>
          <a id="questionItem{$responseData.Question.id}Display" href="{modurl modname='SurveyManager' type='user' func='display' ot='question' id=$responseData.Question.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
          <script type="text/javascript">
          /* <![CDATA[ */
              document.observe('dom:loaded', function() {
                  surveymanInitInlineWindow($('questionItem{{$responseData.Question.id}}Display'), '{{$responseData.Question->getTitleFromDisplayPattern()|replace:"'":""}}');
              });
          /* ]]> */
          </script>
          {else}
            {$responseData.Question->getTitleFromDisplayPattern()|default:""}
          {/if}
        {else}
            {gt text='Not set.'}
        {/if}
        </dd>
        
    </dl>
    {include file='user/include_standardfields_display.tpl' obj=$responseData}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='surveymanager.ui_hooks.responsedatas.display_view' id=$responseData.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($responseData._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$responseData._actions}
                <a href="{$option.url.type|surveymanagerActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    surveymanInitItemActions('responseData', 'display', 'itemActions');
                });
            /* ]]> */
            </script>
        {/if}
    {/if}
</div>
{include file='user/footer.tpl'}
