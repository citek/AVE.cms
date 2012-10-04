<div class="title">
  <h5>{#MAILER_MANAGE_MAILS#}</h5>
</div>
<div class="widget" style="margin-top: 0px;">
  <div class="body">
    {#MAILER_MODULE_INFO#}
  </div>
</div>
<div class="breadCrumbHolder module">
  <div class="breadCrumb module">
    <ul>
      <li class="firstB">
        <a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a>
      </li>
      <li>
        <a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a>
      </li>
      <li> {#MAILER_MODULE_NAME#} </li>
      <li>
        <strong class="code">{#MAILER_MANAGE_MAILS#}</strong>
      </li>
    </ul>
  </div>
</div>
<div class="widget first">
  <div class="head">
    <h5 class="iFrames">{#MAILER_MAILS_TPL_H#}</h5>
    <div class="num">
      <a class="basicNum" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editmail&amp;cp={$sess}">{#MAILER_NEW_MAIL#}</a>
    </div>
    <div class="num">
      <a class="greenNum" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=showlists&amp;cp={$sess}">{#MAILER_MANAGE_LISTS#}</a>
    </div>
  </div>
  <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
    <col width="30" />
    <col />
    <col width="100" />
    <col width="90" />
    <col width="140" />
    <col width="200" />
    <col width="1" />
    <col width="1" />
    <col width="1" />
    <thead>
      <tr class="noborder">
        <td>Id</td>
        <td>{#MAILER_MAILS_SUBJECT#}</td>
        <td>{#MAILER_MAILS_AUTHOR#}</td>
        <td>{#MAILER_MAILS_CREATED#}</td>
        <td>{#MAILER_MAILS_FROM#}</td>
        <td>{#MAILER_MAILS_RECIEVERS#}</td>
        <td colspan="3">{#MAILER_ACTIONS#}</td>
      </tr>
    </thead>
    <tbody>
      {foreach from=$mails.tpl item=mail}
      <tr>
        <td>{$mail->id}</td>
        <td><a class="toprightDir" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editmail&amp;id={$mail->id}&amp;cp={$sess}" title="{#MAILER_ACTIONS_EDIT#}"><strong>{$mail->subject|escape}</strong></a></td>
        <td><a class="topDir" title="{#MAILER_SHOW_AUTHOR_TIT#}" href="index.php?do=user&amp;action=edit&amp;id={$list->author_id}&amp;cp={$sess}">{$mail->author_name}</a></td>
        <td align="right" class="date_text dgrey">{$mail->date|date_format:$TIME_FORMAT|pretty_date}</td>
        <td><a class="topDir" href="mailto:{$mail->from_email|escape}" target="_blank" title="{#MAILER_WRITE_EMAIL#}">{$mail->from_email|escape}</a><br/>{$mail->from_name|escape}</td>
        <td style="padding:0 0 0 10px">
          <div style="overflow:auto;max-height:60px">
          {if $mail->from_copy}{#MAILER_MAILS_FROM#}
            {if $mail->to_groups || $mail->to_lists || $mail->to_add}<hr />{/if}
          {/if}
          {foreach from=$mail->to_groups item=group name=foreach}
            {$group->user_group_name|escape}{if !$smarty.foreach.foreach.last}, {/if}{/foreach}
          {if $mail->to_groups && ($mail->to_lists || $mail->to_add)}<hr />{/if}
          {foreach from=$mail->to_lists item=list name=foreach}
            <a target="_blank" class="topDir" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editlist&amp;id={$list->id}&amp;cp={$sess}" title="{#MAILER_LOOK_LIST#} '{$list->title|escape}'">{$list->title|escape}</a>{if !$smarty.foreach.foreach.last}, {/if}{/foreach}
          {if $mail->to_lists && $mail->to_add}<hr />{/if}
          {foreach from=$mail->to_add item=add name=foreach}
            <a class="topDir" href="mailto:{$add|escape}" target="_blank" title="{#MAILER_WRITE_EMAIL#}">{$add|escape}</a>{if !$smarty.foreach.foreach.last}, {/if}
          {/foreach}
          </div>
        </td>
        <td align="center"><a class="topDir icon_sprite ico_edit" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editmail&amp;id={$mail->id}&amp;cp={$sess}" title="{#MAILER_ACTIONS_EDIT#}"></a></td>
        <td align="center"><a class="topleftDir icon_sprite ico_list" target="_blank" href="/index.php?module=mailer&amp;action=show&amp;id={$mail->id}&amp;onlycontent=1" title="{#MAILER_ACTIONS_SHOW#}"></a></td>
        <td align="center"><a class="topleftDir icon_sprite ico_delete ConfirmDelete" dir="{#MAILER_DELETING#}" name="{#MAILER_MAILS_DEL_Q#} '{$mail->subject}'?" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=savemail&amp;id={$mail->id}&amp;act=delete&amp;cp={$sess}&amp;page={$smarty.request.page}" title="{#MAILER_ACTIONS_DEL#}"></a></td>
      </tr>
      {/foreach}
    </tbody>
  </table>
  {if !$mails.tpl}
  <div class="rowElem">
    <ul class="messages">
      <li class="highlight yellow">{#MAILER_MAILS_TPL_NO#}</li>
    </ul>
  </div>
  {/if}
</div>
<div class="widget first">
  <ul class="tabs">
    <li{if !$search} class="activeTab"{/if}><a href="#tab1">{#MAILER_MAILS_HEAD#}</a></li>
    <li{if $search} class="activeTab"{/if}><a href="#tab2">{#MAILER_MAILS_SEARCH#}</a></li>
  </ul>
  <div class="tab_container">
    <div id="tab1" class="tab_content" style="display:{if $search}none{else}block{/if}">
      <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
        <col width="30" />
        <col />
        <col width="100" />
        <col width="90" />
        <col width="140" />
        <col width="200" />
        <col width="140" />
        <col width="1" />
        <col width="1" />
        <col width="1" />
        <thead>
          <tr class="noborder">
            <td>Id</td>
            <td>{#MAILER_MAILS_SUBJECT#}</td>
            <td>{#MAILER_MAILS_AUTHOR#}</td>
            <td>{#MAILER_MAILS_DATE#}</td>
            <td>{#MAILER_MAILS_FROM#}</td>
            <td>{#MAILER_MAILS_RECIEVERS#}</td>
            <td>{#MAILER_MAILS_ATTACHS#}</td>
            <td colspan="3">{#MAILER_ACTIONS#}</td>
          </tr>
        </thead>
        <tbody>
          {foreach from=$mails.sent item=mail}
          <tr>
            <td>{$mail->id}</td>
            <td><a class="toprightDir" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editmail&amp;id={$mail->id}&amp;cp={$sess}" title="{#MAILER_LOOK#}"><strong>{$mail->subject|escape}</strong></a></td>
            <td><a class="topDir" title="{#MAILER_SHOW_AUTHOR_TIT#}" href="index.php?do=user&amp;action=edit&amp;id={$list->author_id}&amp;cp={$sess}">{$mail->author_name|escape}</a></td>
            <td align="right" class="date_text dgrey">{$mail->date|date_format:$TIME_FORMAT|pretty_date}</td>
            <td><a href="mailto:{$mail->from_email|escape}" target="_blank">{$mail->from_email|escape}</a><br/>{$mail->from_name|escape}</td>
            <td style="padding:0 0 0 10px">
              <div style="overflow:auto;max-height:60px">
              {if $mail->from_copy}{#MAILER_MAILS_FROM#}
                {if $mail->to_groups || $mail->to_lists || $mail->to_add}<hr />{/if}
              {/if}
              {foreach from=$mail->to_groups item=group name=foreach}
                {$group->user_group_name|escape}{if !$smarty.foreach.foreach.last}, {/if}{/foreach}
              {if $mail->to_groups && ($mail->to_lists || $mail->to_add)}<hr />{/if}
              {foreach from=$mail->to_lists item=list name=foreach}
                <a target="_blank" class="topDir" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editlist&amp;id={$list->id}&amp;cp={$sess}" title="{#MAILER_LOOK_LIST#} '{$list->title|escape}'">{$list->title|escape}</a>{if !$smarty.foreach.foreach.last}, {/if}{/foreach}
              {if $mail->to_lists && $mail->to_add}<hr />{/if}
              {foreach from=$mail->to_add item=add name=foreach}
                <a class="topDir" href="mailto:{$add|escape}" target="_blank" title="{#MAILER_WRITE_EMAIL#}">{$add|escape}</a>{if !$smarty.foreach.foreach.last}, {/if}
              {/foreach}
              </div>
            </td>
            <td style="padding:0 0 0 10px">
              <div style="overflow:auto;max-height:60px">
              {if $mail->saveattach !='1'}
                {foreach from=$mail->attach item=attachment name=foreach}
                {$attachment.name}{if !$smarty.foreach.foreach.last},<br />{/if}
                {/foreach}
              {else}
                {foreach from=$mail->attach item=attachment name=foreach}
                <a onClick="get_file('{$attachment.path}')" class="pointer">{$attachment.name}</a>{if !$smarty.foreach.foreach.last},<br />{/if}
                {/foreach}
              {/if}
              </div>
            </td>
            <td align="center"><a class="topleftDir icon_sprite ico_look" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editmail&amp;id={$mail->id}&amp;cp={$sess}" title="{#MAILER_LOOK#}"></a></td>
            <td align="center"><a class="topleftDir icon_sprite ico_list" target="_blank" href="/index.php?module=mailer&amp;action=show&amp;id={$mail->id}&amp;onlycontent=1" title="{#MAILER_ACTIONS_SHOW#}"></a></td>
            <td align="center"><a class="topleftDir icon_sprite ico_copy" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editmail&amp;copy_id={$mail->id}&amp;cp={$sess}" title="{#MAILER_ACTIONS_COPY#}"></a></td>
          </tr>
          {/foreach}
        </tbody>
      </table>
      {if !$mails.sent}
      <div class="rowElem">
        <ul class="messages">
          <li class="highlight yellow">{#MAILER_MAILS_NOITEMS#}</li>
        </ul>
      </div>
      {/if}
    </div>
  </div>
  <div id="tab2" class="tab_content" style="display:{if !$search}none{else}block{/if}">
    <form method="post" action="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=1&amp;cp={$sess}" class="mainForm" onSubmit="return check_find();" id="search">
      <div class="rowElem">
        <label>{#MAILER_MAILS_FIND#}</label>
        <div style="float:left;margin-top:10px">
          <input placeholder="{#MAILER_MAILS_FIND_IN#}" name="search_words" type="text" value="{$search_words}" style="width:400px">&nbsp;
          <input type="submit" class="basicBtn" value="{#MAILER_MAILS_SEARCH#}" /><br>
          <input type="checkbox" class="float" name="search[from_email]" value="1"{if !$search || $search.from_email} checked="checked"{/if}><label>{#MAILER_SEARCH_FROM_E#}</label>
          <input type="checkbox" class="float" name="search[from_name]" value="1"{if !$search || $search.from_name} checked="checked"{/if}><label>{#MAILER_SEARCH_FROM_N#}</label>
          <input type="checkbox" class="float" name="search[subject]" value="1"{if !$search || $search.subject} checked="checked"{/if}><label>{#MAILER_SEARCH_SUB#}</label>
          <input type="checkbox" class="float" name="search[body]" value="1"{if !$search || $search.body} checked="checked"{/if}><label>{#MAILER_SEARCH_BODY#}</label>
          <input type="checkbox" class="float" name="search[done]" value="1"{if !$search || $search.done} checked="checked"{/if}><label>{#MAILER_SEARCH_REC#}</label>
        </div>
        <div class="fix"></div>
      </div>
    </form>
    {if $search}
      <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
        <col width="30" />
        <col />
        <col width="100" />
        <col width="90" />
        <col width="140" />
        <col width="200" />
        <col width="140" />
        <col width="1" />
        <col width="1" />
        <thead>
          <tr class="noborder">
            <td>Id</td>
            <td>{#MAILER_MAILS_SUBJECT#}</td>
            <td>{#MAILER_MAILS_AUTHOR#}</td>
            <td>{#MAILER_MAILS_DATE#}</td>
            <td>{#MAILER_MAILS_FROM#}</td>
            <td>{#MAILER_MAILS_RECIEVERS#}</td>
            <td>{#MAILER_MAILS_ATTACHS#}</td>
            <td colspan="2">{#MAILER_ACTIONS#}</td>
          </tr>
        </thead>
        <tbody>
        
        {foreach from=$mails.find item=mail}
        <tr>
          <td>{$mail->id}</td>
          <td><a class="toprightDir" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editmail&amp;id={$mail->id}&amp;cp={$sess}" title="{#MAILER_LOOK#}"><strong>{$mail->subject|escape}</strong></a></td>
          <td><a class="topDir" title="{#MAILER_SHOW_AUTHOR_TIT#}" href="index.php?do=user&amp;action=edit&amp;id={$list->author_id}&amp;cp={$sess}">{$mail->author_name|escape}</a></td>
          <td align="right" class="date_text dgrey">{$mail->date|date_format:$TIME_FORMAT|pretty_date}</td>
          <td><a href="mailto:{$mail->from_email|escape}" target="_blank">{$mail->from_email|escape}</a><br/>{$mail->from_name|escape}</td>
          <td style="padding:0 0 0 10px">
            <div style="overflow:auto;max-height:60px">
            {if $mail->from_copy}{#MAILER_MAILS_FROM#}
              {if $mail->to_groups || $mail->to_lists || $mail->to_add}<hr />{/if}
            {/if}
            {foreach from=$mail->to_groups item=group name=foreach}
              {$group->user_group_name|escape}{if !$smarty.foreach.foreach.last}, {/if}{/foreach}
            {if $mail->to_groups && ($mail->to_lists || $mail->to_add)}<hr />{/if}
            {foreach from=$mail->to_lists item=list name=foreach}
              <a target="_blank" class="topDir" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editlist&amp;id={$list->id}&amp;cp={$sess}" title="{#MAILER_LOOK_LIST#} '{$list->title|escape}'">{$list->title|escape}</a>{if !$smarty.foreach.foreach.last}, {/if}{/foreach}
            {if $mail->to_lists && $mail->to_add}<hr />{/if}
            {foreach from=$mail->to_add item=add name=foreach}
              <a class="topDir" href="mailto:{$add|escape}" target="_blank" title="{#MAILER_WRITE_EMAIL#}">{$add|escape}</a>{if !$smarty.foreach.foreach.last}, {/if}
            {/foreach}
            </div>
          </td>
          <td style="padding:0 0 0 10px">
            <div style="overflow:auto;max-height:60px">
            {if $mail->saveattach !='1'}
              {foreach from=$mail->attach item=attachment name=foreach}
              {$attachment.name}{if !$smarty.foreach.foreach.last},<br />{/if}
              {/foreach}
            {else}
              {foreach from=$mail->attach item=attachment name=foreach}
              <a onClick="get_file('{$attachment.path}');" style="cursor:pointer">{$attachment.name}</a>{if !$smarty.foreach.foreach.last},<br />{/if}
              {/foreach}
            {/if}
            </div>
          </td>
          <td align="center"><a class="topleftDir icon_sprite ico_look" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editmail&amp;id={$mail->id}&amp;cp={$sess}" title="{#MAILER_LOOK#}"></a></td>
          <td align="center"><a class="topleftDir icon_sprite ico_copy" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editmail&amp;copy_id={$mail->id}&amp;cp={$sess}" title="{#MAILER_ACTIONS_COPY#}"></a></td>
        </tr>
        {/foreach}
        </tbody>
      </table>
      {if !$mails.find}
      <div class="rowElem">
        <ul class="messages">
          <li class="highlight yellow">{#MAILER_MAILS_FIND_NO#}</li>
        </ul>
      </div>
      {/if}
    {/if}
  </div>
  <div class="fix"></div>
</div>
{if $page_nav}
<div class="pagination">
  <ul class="pages">
    {$page_nav}
  </ul>
</div>
{/if}
<script>
function get_file(file) {ldelim}
	$.ajax({ldelim}
		url: 'index.php?do=modules&action=modedit&mod=mailer&cp={$sess}',
		data: ({ldelim}
			'moduleaction': 'getfile',
			'file': file,
			'check': true
		{rdelim}),
		beforeSend: function() {ldelim}$.alerts._overlay('show');{rdelim},
		success: function(data) {ldelim}
			if (data == '1') {ldelim}
				document.location.href = "index.php?do=modules&action=modedit&mod=mailer&moduleaction=getfile&file="+file+"&cp={$sess}";
				$.alerts._overlay('hide');
			{rdelim}
			else {ldelim}
				jAlert(file,'{#MAILER_NOFILE#}');
			{rdelim}
		{rdelim}
	{rdelim});
{rdelim};
function check_find() {ldelim}
	if (!$("input[name=search_words]").val()) {ldelim}
		jAlert('{#MAILER_ERR_SEACRH_WORDS#}','{#MAILER_SEARCHING#}',
			function() {ldelim}$("input[name=search_words]").focus();{rdelim});
		return false;
	{rdelim}

	if (!$("#search input[type=checkbox]:checked").val()) {ldelim}
		jAlert('{#MAILER_ERR_SEACRH#}','{#MAILER_SEARCHING#}',
			function() {ldelim}$("#search").focus();{rdelim});
		return false;
	{rdelim}
{rdelim}
</script>