<div class="title">
  <h5>{#MAILER_MANAGE_LISTS#}</h5>
</div>
{*<div class="widget" style="margin-top: 0px;">
  <div class="body">
    {#MAILER_LISTS_INFO#}
  </div>
</div>*}
<div class="breadCrumbHolder module">
  <div class="breadCrumb module">
    <ul>
      <li class="firstB">
        <a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a>
      </li>
      <li>
        <a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a>
      </li>
      <li>
        <a href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=1&amp;cp={$sess}">{#MAILER_MODULE_NAME#}</a>
      </li>
      <li>
        <strong class="code">{#MAILER_MANAGE_LISTS#}</strong>
      </li>
    </ul>
  </div>
</div>
<div class="widget first">
  <div class="head">
    <h5 class="iFrames">{#MAILER_LISTS_HEAD#}</h5>
    <div class="num">
      <a class="greenNum" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editlist&amp;cp={$sess}">{#MAILER_NEW_LIST#}</a>
    </div>
    <div class="num">
      <a class="basicNum" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=1&amp;cp={$sess}">{#MAILER_MANAGE_MAILS#}</a>
    </div>
    <div class="num">
      <a class="redNum botDir" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=multiadd&amp;cp={$sess}" title="{#MAILER_MULTI_HINT#}">{#MAILER_MULTI_TITLE#}</a>
    </div>
  </div>
  <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
    <col width="30" />
    <col width="250" />
    <col />
    <col width="150" />
    <col width="150" />
    <col width="40" />
    <col width="20" />
    <col width="20" />
    <col width="20" />
    <col width="20" />
    <thead>
      <tr class="noborder">
        <td align="center">id</td>
        <td>{#MAILER_LISTS_TITLE#}</td>
        <td>{#MAILER_LISTS_DESCR#}</td>
        <td>{#MAILER_LISTS_AUTHOR#}</td>
        <td>{#MAILER_LISTS_DATE#}</td>
        <td class="topleftDir" title="{#MAILER_LISTS_NUMBER_F#}">{#MAILER_LISTS_NUMBER#}</td>
        <td colspan="4">{#MAILER_ACTIONS#}</td>
      </tr>
    </thead>
    <tbody>
      {foreach from=$lists item=list}
      <tr>
        <td align="center">{$list->id}</td>
        <td><strong>
          <a class="toprightDir" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editlist&amp;id={$list->id}&amp;cp={$sess}" title="{#MAILER_LISTS_A_EDIT#}">{$list->title}</a>
          </strong></td>
        <td>
        <div style="overflow:auto; max-height:80px">{$list->descr}</div></td>
        <td align="center"><a class="topDir" title="{#MAILER_SHOW_AUTHOR_TIT#}" href="index.php?do=user&amp;action=edit&amp;id={$list->author_id}&amp;cp={$sess}">{$list->author_name|escape}</a></td>
        <td align="center">{$list->date|date_format:$TIME_FORMAT|pretty_date}</td>
        <td align="center" class="topDir" title="{#MAILER_LISTS_NUMBER_F#}">{$list->number}</td>
        <td align="center"><a class="topDir icon_sprite ico_edit" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editlist&amp;id={$list->id}&amp;cp={$sess}" title="{#MAILER_ACTIONS_EDIT#}"></a></td>
        <td align="center"><a class="topDir icon_sprite ico_recylce ConfirmDelete" dir="{#MAILER_WIPING#}" name="{#MAILER_ACTIONS_WIPE_2#} '{$list->title}'?" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editlist&amp;wipe=1&amp;id={$list->id}&amp;cp={$sess}&amp;page={$smarty.request.page}" title="{#MAILER_ACTIONS_WIPE#}"></a></td>
        <td align="center"><a class="topDir icon_sprite ico_delete ConfirmDelete" dir="{#MAILER_DELETING#}" name="{#MAILER_ACTIONS_DEL#} '{$list->title}'?" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editlist&amp;delete=1&amp;id={$list->id}&amp;cp={$sess}&amp;page={$smarty.request.page}" title="{#MAILER_ACTIONS_DEL#}"></a></td>
        <td align="center"><a class="topleftDir icon_sprite ico_install" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editlist&amp;download=1&amp;id={$list->id}&amp;cp={$sess}" title="{#MAILER_ACTIONS_DOWNLOAD#}"></a></td>
      </tr>
      {/foreach}
    </tbody>
  </table>
  {if !$lists}
  <div class="rowElem">
    <ul class="messages">
      <li class="highlight yellow">{#MAILER_LISTS_NOITEMS#}</li>
    </ul>
  </div>{/if}
</div>
{if $page_nav}
<div class="pagination">
  <ul class="pages">
    {$page_nav}
  </ul>
</div>
{/if}