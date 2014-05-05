{* purpose of this template: pages display view in user area *}
{include file='user/header.tpl'}
<div class="surveymanager-page surveymanager-display with-rightbox">
    {gt text='Page' assign='templateTitle'}
    {assign var='templateTitle' value=$page->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <h2>{$templateTitle|notifyfilters:'surveymanager.filter_hooks.pages.filter'}{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h2>

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <div class="surveymanager-rightbox">
            <h3>{gt text='Questions'}</h3>
            
            {if isset($page.questions) && $page.questions ne null}
                {include file='user/question/include_displayItemListMany.tpl' items=$page.questions}
            {/if}
            
        </div>
    {/if}

    <dl>
        <dt>{gt text='Name'}</dt>
        <dd>{$page.name}</dd>
        <dt>{gt text='Description'}</dt>
        <dd>{$page.description}</dd>
        <dt>{gt text='Weight'}</dt>
        <dd>{$page.weight}</dd>
        <dt>{gt text='Survey'}</dt>
        <dd>
        {if isset($page.Survey) && $page.Survey ne null}
          {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
          <a href="{modurl modname='SurveyManager' type='user' func='display' ot='survey' id=$page.Survey.id slug=$page.Survey.slug}">{strip}
            {$page.Survey->getTitleFromDisplayPattern()|default:""}
          {/strip}</a>
          <a id="surveyItem{$page.Survey.id}Display" href="{modurl modname='SurveyManager' type='user' func='display' ot='survey' id=$page.Survey.id slug=$page.Survey.slug theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
          <script type="text/javascript">
          /* <![CDATA[ */
              document.observe('dom:loaded', function() {
                  surveymanInitInlineWindow($('surveyItem{{$page.Survey.id}}Display'), '{{$page.Survey->getTitleFromDisplayPattern()|replace:"'":""}}');
              });
          /* ]]> */
          </script>
          {else}
            {$page.Survey->getTitleFromDisplayPattern()|default:""}
          {/if}
        {else}
            {gt text='Not set.'}
        {/if}
        </dd>
        
    </dl>
    {include file='user/include_standardfields_display.tpl' obj=$page}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='surveymanager.ui_hooks.pages.display_view' id=$page.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($page._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$page._actions}
                <a href="{$option.url.type|surveymanagerActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    surveymanInitItemActions('page', 'display', 'itemActions');
                });
            /* ]]> */
            </script>
        {/if}
        <br style="clear: right" />
    {/if}
</div>
{include file='user/footer.tpl'}
