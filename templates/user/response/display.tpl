{* purpose of this template: responses display view in user area *}
{include file='user/header.tpl'}
<div class="surveymanager-response surveymanager-display with-rightbox">
    {gt text='Response' assign='templateTitle'}
    {assign var='templateTitle' value=$response->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <h2>{$templateTitle|notifyfilters:'surveymanager.filter_hooks.responses.filter'}{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h2>

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <div class="surveymanager-rightbox">
            <h3>{gt text='Response datas'}</h3>
            
            {if isset($response.answers) && $response.answers ne null}
                {include file='user/responseData/include_displayItemListMany.tpl' items=$response.answers}
            {/if}
            
        </div>
    {/if}

    <dl>
        <dt>{gt text='Ip address'}</dt>
        <dd>{$response.ipAddress}</dd>
        <dt>{gt text='Response timestamp'}</dt>
        <dd>{$response.responseTimestamp}</dd>
        <dt>{gt text='Featured'}</dt>
        <dd>{$response.featured|yesno:true}</dd>
        <dt>{gt text='Survey'}</dt>
        <dd>
        {if isset($response.Survey) && $response.Survey ne null}
          {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
          <a href="{modurl modname='SurveyManager' type='user' func='display' ot='survey' id=$response.Survey.id slug=$response.Survey.slug}">{strip}
            {$response.Survey->getTitleFromDisplayPattern()|default:""}
          {/strip}</a>
          <a id="surveyItem{$response.Survey.id}Display" href="{modurl modname='SurveyManager' type='user' func='display' ot='survey' id=$response.Survey.id slug=$response.Survey.slug theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
          <script type="text/javascript">
          /* <![CDATA[ */
              document.observe('dom:loaded', function() {
                  surveymanInitInlineWindow($('surveyItem{{$response.Survey.id}}Display'), '{{$response.Survey->getTitleFromDisplayPattern()|replace:"'":""}}');
              });
          /* ]]> */
          </script>
          {else}
            {$response.Survey->getTitleFromDisplayPattern()|default:""}
          {/if}
        {else}
            {gt text='Not set.'}
        {/if}
        </dd>
        
    </dl>
    {include file='user/include_standardfields_display.tpl' obj=$response}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='surveymanager.ui_hooks.responses.display_view' id=$response.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($response._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$response._actions}
                <a href="{$option.url.type|surveymanagerActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    surveymanInitItemActions('response', 'display', 'itemActions');
                });
            /* ]]> */
            </script>
        {/if}
        <br style="clear: right" />
    {/if}
</div>
{include file='user/footer.tpl'}
