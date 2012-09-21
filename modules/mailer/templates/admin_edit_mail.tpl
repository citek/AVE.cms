<div class="title">
  <h5>{#MAILER_MAILS_ADD_TITLE#}</h5>
</div>
<div class="widget" style="margin-top: 0px;">
  <div class="body">
    {#MAILER_MAILS_ADD_INFO#}
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
      <li>
        <a href="index.php?do=modules&action=modedit&mod=mailer&moduleaction=1&cp={$sess}">{#MAILER_MODULE_NAME#}</a>
      </li>
      <li>{if !$smarty.request.id}{#MAILER_MAILS_ADD_TITLE#}{else}{#MAILER_MAILS_EDIT_TITLE#}{/if}</li>
      <li><strong class="code">{if !$smarty.request.id}{#MAILER_MAILS_NEW_TITLE#}{else}{$mail->subject}{/if}</strong></li>
    </ul>
  </div>
</div>
<form action="index.php?do=modules&action=modedit&mod=mailer&moduleaction=savemail&id={$smarty.request.id}&cp={$sess}" method="post" enctype="multipart/form-data" class="mainForm" id="mail_form">
  <div class="widget first">
    <div class="head">
      <h5 class="iFrames">{#MAILER_MAILS_ADD_TITLE#}</h5>
    </div>
    <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
       <tr>
        <td>{#MAILER_MAILS_FROM_NAME#}</td>
        <td><div class="pr12">
            <input class="mousetrap" name="from_name" type="text" id="from_name" value="{$mail->from_name}" style="width:300px" />
          </div></td>
      </tr>
      <tr>
        <td>{#MAILER_MAILS_FROM_EMAIL#}</td>
        <td><div class="pr12">
            <input class="mousetrap" name="from_email" type="text" id="from_email" value="{$mail->from_email}" style="width:300px" onchange="if($(this).val()) checkemail($(this).val());" />
          </div></td>
      </tr>
      <tr>
        <td>{#MAILER_MAILS_FROM_COPY#}</td>
        <td><div class="pr12">
            <input class="mousetrap" name="from_copy" type="checkbox" value="1"{if $mail->from_copy} checked{/if} />
          </div></td>
      </tr>
      <tr class="noborder">
        <td width="250">{#MAILER_MAILS_RECIEVERS#}: {#MAILER_MAILS_REC_GROUPS#} "{$mail->site_name}"<br />
          <small>{#MAILER_MAILS_REC_INFO#}</small></td>
        <td><div class="pr12">
            <select class="mousetrap" id="groups" name="to_groups[]" size="4" multiple="multiple" style="width:310px">
              {foreach from=$mail->usergroups item=usergroup}
              <option value="{$usergroup->user_group}" {if $usergroup->user_group|in_array:$mail->to_groups} selected="selected"{/if}>{$usergroup->user_group_name|escape}</option>
              {/foreach}
            </select>
          </div></td>
      </tr>
      <tr>
        <td width="250">{#MAILER_MAILS_RECIEVERS#}: {#MAILER_MAILS_REC_LISTS#}<br />
          <small>{#MAILER_MAILS_REC_INFO#}</small></td>
        <td><div class="pr12">
            <select class="mousetrap" id="lists" name="to_lists[]" size="4" multiple="multiple" style="width:310px">
              {foreach from=$mail->lists item=title key=id}
              <option value="{$id}" {if $id|in_array:$mail->to_lists} selected="selected"{/if}>{$title|escape}</option>
              {/foreach}
            </select>
          </div></td>
      </tr>
      <tr>
        <td>{#MAILER_MAILS_REC_ADD#}<br /><small>{#MAILER_MAILS_REC_ADD_I#}</small></td>
        <td><div class="pr12">
            <textarea class="mousetrap" name="to_add" id="to_add" style="width:300px; height:50px" onchange="if($(this).val()) checkemail($(this).val());">{$mail->to_add}</textarea>
          </div></td>
      </tr>
      <tr>
        <td>{#MAILER_MAILS_SUBJECT#}</td>
        <td><div class="pr12">
            <input class="mousetrap" name="subject" type="text" id="subject" style="width:300px" value="{$mail->subject}" />
          </div></td>
      </tr>
      <tr>
        <td>{#MAILER_MAILS_FORMAT#}</td>
        <td><div class="pr12">
            <input id="radio_text" type="radio" name="type" value="text" {if $mail->type=='text'}checked="checked"{/if}/>
            <label>{#MAILER_MAILS_TEXT#}</label>
            <input type="radio" name="type" value="html" {if $mail->type!='text'}checked="checked"{/if}/>
            <label>HTML</label>
          </div></td>
      </tr>
      <tr>
        <td>{#MAILER_MAILS_TEXT#}<br /><small>{#MAILER_MAILS_TEXT_I#}</small></td>
        <td><div class="pr12" id="ed1">
            <textarea class="mousetrap" name="body" cols="50" rows="15" id="body" style="width:100%;height:300px">{$mail->body}</textarea>
          </div>
          <div class="pr12" id="ed2" style="height:0;overflow:hidden">
            {$Editor}
          </div></td>
      </tr>
      <tr>
        <td>{#MAILER_MAILS_APPEAL#}<br /><small>{#MAILER_MAILS_APPEAL_I#}</small></td>
        <td><div class="pr12" id="ed1">
            <input class="mousetrap" type="text" name="appeal" value="{$mail->appeal}" style="width:300px" />
          </div></td>
      </tr>
      <tr>
        <td>{#MAILER_MAILS_ATTACH#}<br /><small>{#MAILER_MAILS_ATTACH_I#}</small></td>
        <td id="attach_td">
          <div style="clear:both;margin:4px 0;">
            <input name="attach[]" type="file" class="fileInput multi" />
          </div>
        </td>
      </tr>
      <tr>
        <td>{#MAILER_MAILS_SAVEATTACH#}</td>
        <td><div class="pr12">
            <input type="radio" name="saveattach" value="1" {if $mail->saveattach}checked="checked"{/if} />
            <label>{#MAILER_YES#}</label>
            <input type="radio" name="saveattach" value="0" {if !$mail->saveattach}checked="checked"{/if} />
            <label>{#MAILER_NO#}</label>
          </div></td>
      </tr>
    </table>
    <div class="rowElem">
      <input onclick="save_func(false);" class="basicBtn" type="button" value="{#MAILER_MAILS_SAVE_BTN#}" />
      &nbsp;{#MAILER_OR#}&nbsp;
      <input class="blackBtn SaveEdit" type="button" value="{#MAILER_MAILS_SAVE_BTN_C#}" />
      &nbsp;{#MAILER_OR#}&nbsp;
      <input type="button" onclick="presend();" id="butt_send" class="redBtn" value="{#MAILER_MAILS_SEND_BTN#}" />
      <div id="progressbar" style="display:none;clear:both;margin-top:10px;"></div>
      <div id="sent_ok" class="highlight yellow" style="{if !$mail->sent}display:none;{/if}margin-top:10px;">{if $mail->sent}{$mail->date|date_format:$TIME_FORMAT|pretty_date}: {/if}{#MAILER_SENT_OK_TEXT#}
      <strong><a href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=1&amp;cp={$sess}">&raquo;&nbsp;{#MAILER_SENT_OK_LINK#}</a></strong></div>
    </div>
  </div>
</form>
<script language="javascript">
{if $mail->sent} $(':input').attr('disabled','disabled');{/if}

function presend() {ldelim}
if (full_check()) {ldelim}
	$("#mail_form").ajaxSubmit({ldelim}
		url: 'index.php?do=modules&action=modedit&mod=mailer&moduleaction=savemail&id={$smarty.request.id}&cp={$sess}',
		data: ({ldelim}send: 1{rdelim}),
		beforeSubmit: function() {ldelim}
			$("#progressbar").show().progressbar({ldelim}value: 0{rdelim});
			$.alerts._overlay('show');
		{rdelim},
		success: function(data) {ldelim}
			$(':input').attr('disabled','disabled');
			mail_id = Number(data);
			send();
		{rdelim}
	{rdelim});
{rdelim}
{rdelim}

function send() {ldelim}
	$("#mail_form").ajaxSubmit({ldelim}
		url: 'index.php?do=modules&action=modedit&mod=mailer&moduleaction=sendmail&id={$smarty.request.id}&cp={$sess}',
		data: ({ldelim}mail_id: mail_id{rdelim}),
		success: function(data) {ldelim}
			if (data == 'finish') {ldelim}
				$.alerts._overlay('hide');
				$.jGrowl("{#MAILER_SENT_OK#}");
				$("#sent_ok").show();
			{rdelim}
			else {ldelim}
				$("#progressbar").progressbar({ldelim}value: Number(data){rdelim});
				send();
			{rdelim}
		{rdelim}
	{rdelim});
{rdelim}

var save_form = {ldelim}
	url: 'index.php?do=modules&action=modedit&mod=mailer&moduleaction=savemail&id={$smarty.request.id}&cp={$sess}',
	beforeSubmit: function() {ldelim}$.alerts._overlay('show');{rdelim},
	data: ({ldelim}"return": 1{rdelim}),
	success: function(data) {ldelim}
		$.alerts._overlay('hide');
		$.jGrowl('{#MAILS_SAVED#}');
		{if !$smarty.request.id} location.href="index.php?do=modules&action=modedit&mod=mailer&moduleaction=editmail&id="+data+"&cp={$sess}"; {/if}
	{rdelim}
{rdelim}

function save_func(ajax) {ldelim}
	if (!$("#subject").val()) {ldelim}
		jAlert('{#MAILER_ERR_SUBJECT#}','{#MAILER_SENDING#}',
		function() {ldelim}$("#subject").focus();{rdelim});
		return false;
	{rdelim}

	if ($(".fileInput").val()) {ldelim}
		jAlert('{#MAILER_ALERT_ATTACH#}','{#MAILER_SAVING#}',
		function() {ldelim}
			if(!ajax) $("#mail_form").submit();
			else {ldelim}
				$(".fileInput").val("");
				$("#mail_form").ajaxSubmit(save_form);
			{rdelim}
		{rdelim});
	{rdelim}
	else {ldelim}
		if(!ajax) $("#mail_form").submit();
		else $("#mail_form").ajaxSubmit(save_form);
	{rdelim}
{rdelim}

{literal}
$(document).ready(function() {
	Mousetrap.bind(['ctrl+s', 'meta+s'], function(e) {
		if (e.preventDefault) e.preventDefault();
		else e.returnValue = false;
		save_func(true);
		return false;
	});

	$(".SaveEdit").click(function(e) {
		if (e.preventDefault) e.preventDefault();
		else e.returnValue = false;
		save_func(true);
		return false;
	});
});
{/literal}

function checkemail(in_email){ldelim}
	emails = in_email.split(";");

	for (var key in emails) {ldelim}
		var email = emails[key];
		$.ajax({ldelim}
			beforeSend: function() {ldelim}
				$.alerts._overlay('show');
			{rdelim},
			url: 'index.php?do=modules&action=modedit&mod=mailer&cp={$sess}',
			data: ({ldelim}moduleaction:'checkemail', 'email':emails[key]{rdelim}),
			success: function(data) {ldelim}
				$.alerts._overlay('hide');
				switch (Number(data)) {ldelim}
					case 0:
						$.jGrowl("{#MAILER_ER_EMAIL_SYN#}");
						break;
					case 1: case 2:
						$.jGrowl("{#MAILER_EMAIL_OK#}");
						break;
				{rdelim}
			{rdelim}
		{rdelim});
	{rdelim}
{rdelim};

function full_check() {ldelim}
	if (!$("#from_name").val()) {ldelim}
		jAlert('{#MAILER_ERR_FROM_NAME#}','{#MAILER_SENDING#}',
			function() {ldelim}$("#from_name").focus();{rdelim});
		return false;
	{rdelim}

	if (!$("#from_email").val()) {ldelim}
		jAlert('{#MAILER_ERR_FROM_EMAIL#}','{#MAILER_SENDING#}',
			function() {ldelim}$("#from_email").focus();{rdelim});
		return false;
	{rdelim}

	if (!$("#groups").val() && !$("#lists").val() && !$("#to_add").val()) {ldelim}
		jAlert('{#MAILER_ERR_TO#}','{#MAILER_SENDING#}',
			function() {ldelim}$("#groups").focus();{rdelim});
		return false;
	{rdelim}

	if (!$("#subject").val()) {ldelim}
		jAlert('{#MAILER_ERR_SUBJECT#}','{#MAILER_SENDING#}',
			function() {ldelim}$("#subject").focus();{rdelim});
		return false;
	{rdelim}

	if (!$("#body").val()) {ldelim}
		jAlert('{#MAILER_ERR_BODY#}','{#MAILER_SENDING#}',
			function() {ldelim}$("#body").focus();{rdelim});
		return false;
	{rdelim}
	
	return true;
{rdelim}
</script>