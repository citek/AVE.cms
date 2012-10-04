{assign var="id" value=$smarty.request.id}
<div class="title" style="margin-top:25px">
  <h5>{#MAILER_COUNT_TITLE#} '{$smarty.session.mailer.$id.title}'</h5>
</div>
<div class="widget first">
  <div class="head">
    <h5 class="iFrames">{#MAILER_LISTS_HEAD#}</h5>
  </div>
  <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
    <col width="34" />
    <col width="150" />
    <col width="1" />
    <col width="150" />
    <col width="150" />
    <col />
    <thead>
      <tr class="noborder">
        <td align="center"><div align="center"><a href="javascript:void(0);" class="help rightDir icon_sprite ico_info" title="{#MAILER_COUNT_INFO#}"></a></div></td>
        <td>{#MAILER_LIST_HEAD#}</td>
        <td>{#MAILER_REC_EMAIL#}</td>
        <td>{#MAILER_REC_LASTN#}</td>
        <td>{#MAILER_REC_FIRSTN#}</td>
        <td>{#MAILER_REC_COMMENTS#}</td>
      </tr>
    </thead>
    <tbody>
    {foreach from=$smarty.session.mailer.$id.lists key=title item=list}
      {foreach from=$list item=rec}
      <tr class="{if $rec->s}red{/if}">
        <td>{if $rec->s}<a class="help rightDir icon_sprite ico_info" href="javascript:void(0);" title="{if $rec->status == 0}{#MAILER_REC_UNCHECKED#}{elseif $rec->status == 2}{#MAILER_REC_REFUSED#}{else}{#MAILER_COUNT_ER_REPEAT#}{/if}"></a>{/if}</td>
        <td>{$title|escape}</td>
        <td><a href="mailto:{$rec->email|escape}" target="_blank">{$rec->email}</a></td>
        <td>{$rec->lastname|escape}</td>
        <td>{$rec->firstname|escape}</td>
        <td>{$rec->comments|escape}</td>
      </tr>
      {/foreach}
    {/foreach}
    </tbody>
  </table>
  {if !$smarty.session.mailer.$id.lists}
  <div class="rowElem">
    <ul class="messages">
      <li class="highlight yellow">{#MAILER_COUNT_NOLISTS#}</li>
    </ul>
  </div>
  {/if}
</div>
<div class="widget first">
  <div class="head">
    <h5 class="iFrames">{#MAILER_GROUPS#}</h5>
  </div>
  <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
    <col width="34" />
    <col width="150" />
    <col width="150" />
    <col width="150" />
    <col width="150" />
    <col />
    <thead>
      <tr class="noborder">
        <td align="center"><div align="center"><a href="javascript:void(0);" class="help rightDir icon_sprite ico_info" title="{#MAILER_COUNT_INFO#}"></a></div></td>
        <td>{#MAILER_GROUP#}</td>
        <td>{#MAILER_REC_EMAIL#}</td>
        <td>{#MAILER_LOGIN#}</td>
        <td>{#MAILER_REC_LASTN#}</td>
        <td>{#MAILER_REC_FIRSTN#}</td>
      </tr>
    </thead>
    <tbody>
    {foreach from=$smarty.session.mailer.$id.groups key=title item=group}
      {foreach from=$group item=rec}
      <tr{if $rec->s} class="red"{/if}>
        <td>{if $rec->s}<a class="help rightDir icon_sprite ico_info" href="javascript:void(0);" title="{#MAILER_COUNT_ER_REPEAT#}"></a>{/if}</td>
        <td>{$title|escape}</td>
        <td><a href="mailto:{$rec->email|escape}" target="_blank">{$rec->email}</a></td>
        <td>{$rec->user_name|escape}</td>
        <td>{$rec->lastname|escape}</td>
        <td>{$rec->firstname|escape}</td>
      </tr>
      {/foreach}
    {/foreach}
    </tbody>
  </table>
  {if !$smarty.session.mailer.$id.groups}
  <div class="rowElem">
    <ul class="messages">
      <li class="highlight yellow">{#MAILER_COUNT_NOGROUPS#}</li>
    </ul>
  </div>
  {/if}
</div>
<div class="widget first">
  <div class="head">
    <h5 class="iFrames">{#MAILER_MAILS_REC_ADD#}</h5>
  </div>
  <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
    <col width="34" />
    <col />
    <thead>
      <tr class="noborder">
        <td align="center"><div align="center"><a href="javascript:void(0);" class="help rightDir icon_sprite ico_info" title="{#MAILER_COUNT_INFO#}"></a></div></td>
        <td>{#MAILER_REC_EMAIL#}</td>
      </tr>
    </thead>
    <tbody>
    {foreach from=$smarty.session.mailer.$id.add item=rec}
      <tr{if $rec.s} class="red"{/if}>
        <td>{if $rec.s}<a class="help rightDir icon_sprite ico_info" href="javascript:void(0);" title="{if $rec.s == 1}{#MAILER_COUNT_ER_REPEAT#}{elseif $rec.s == 2}{#MAILER_ER_EMAIL_SYN#}{/if}"></a>{/if}</td>
        <td><a {if $rec.s == 2}style="text-decoration:line-through"{/if} href="mailto:{$rec.email|escape}" target="_blank">{$rec.email}</a>{if $rec.from} ({#MAILER_MAILS_FROM#}){/if}</td>
      </tr>
    {/foreach}
    </tbody>
  </table>
  {if !$smarty.session.mailer.$id.add}
  <div class="rowElem">
    <ul class="messages">
      <li class="highlight yellow">{#MAILER_COUNT_NOADD#}</li>
    </ul>
  </div>
  {/if}
</div>
<div class="widget first">
  <div class="head">
    <h5 class="iFrames">{#MAILER_COUNT_SUM#}</h5>
  </div>
  <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
    <tr class="noborder">
      <td width="250">{#MAILER_COUNT_ALL#}<br /><small>{#MAILER_COUNT_ALL_INFO#}</small></td>
      <td>
        <div class="pr12">
          {$smarty.session.mailer.$id.number}
        </div>
      </td>
    </tr>
  </table>
</div>