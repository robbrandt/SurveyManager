{* purpose of this template: questions display view in user area *}
{include file='user/header.tpl'}
<div class="surveymanager-question surveymanager-display with-rightbox">
    {gt text='Question' assign='templateTitle'}
    {assign var='templateTitle' value=$question->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <h2>{$templateTitle|notifyfilters:'surveymanager.filter_hooks.questions.filter'}{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h2>

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <div class="surveymanager-rightbox">
            <h3>{gt text='Response datas'}</h3>
            
            {if isset($question.answers) && $question.answers ne null}
                {include file='user/responseData/include_displayItemListMany.tpl' items=$question.answers}
            {/if}
            
        </div>
    {/if}

    <dl>
        <dt>{gt text='Name'}</dt>
        <dd>{$question.name}</dd>
        <dt>{gt text='Description'}</dt>
        <dd>{$question.description}</dd>
        <dt>{gt text='Weight'}</dt>
        <dd>{$question.weight}</dd>
        <dt>{gt text='Question type'}</dt>
        <dd>{$question.questionType}</dd>
        <dt>{gt text='Question values'}</dt>
        <dd>{$question.questionValues}</dd>
        <dt>{gt text='Correct values'}</dt>
        <dd>{$question.correctValues}</dd>
        <dt>{gt text='Required'}</dt>
        <dd>{$question.required|yesno:true}</dd>
        <dt>{gt text='Dependencies'}</dt>
        <dd>{$question.dependencies}</dd>
        <dt>{gt text='Page'}</dt>
        <dd>
        {if isset($question.Page) && $question.Page ne null}
          {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
          <a href="{modurl modname='SurveyManager' type='user' func='display' ot='page' id=$question.Page.id}">{strip}
            {$question.Page->getTitleFromDisplayPattern()|default:""}
          {/strip}</a>
          <a id="pageItem{$question.Page.id}Display" href="{modurl modname='SurveyManager' type='user' func='display' ot='page' id=$question.Page.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
          <script type="text/javascript">
          /* <![CDATA[ */
              document.observe('dom:loaded', function() {
                  surveymanInitInlineWindow($('pageItem{{$question.Page.id}}Display'), '{{$question.Page->getTitleFromDisplayPattern()|replace:"'":""}}');
              });
          /* ]]> */
          </script>
          {else}
            {$question.Page->getTitleFromDisplayPattern()|default:""}
          {/if}
        {else}
            {gt text='Not set.'}
        {/if}
        </dd>
        
    </dl>
    {include file='user/include_standardfields_display.tpl' obj=$question}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='surveymanager.ui_hooks.questions.display_view' id=$question.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($question._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$question._actions}
                <a href="{$option.url.type|surveymanagerActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    surveymanInitItemActions('question', 'display', 'itemActions');
                });
            /* ]]> */
            </script>
        {/if}
        <br style="clear: right" />
    {/if}
</div>
{include file='user/footer.tpl'}
