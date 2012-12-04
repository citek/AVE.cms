<link rel="stylesheet" href="{$ABS_PATH}admin/codemirror/lib/codemirror.css">
<script src="{$ABS_PATH}admin/codemirror/lib/codemirror.js"></script>
<script src="{$ABS_PATH}admin/codemirror/mode/xml/xml.js"></script>
<script src="{$ABS_PATH}admin/codemirror/mode/javascript/javascript.js"></script>
<script src="{$ABS_PATH}admin/codemirror/mode/css/css.js"></script>
<script src="{$ABS_PATH}admin/codemirror/mode/clike/clike.js"></script>
<script src="{$ABS_PATH}admin/codemirror/mode/php/php.js"></script>
{literal}
<style type="text/css">
	.activeline {background: #e8f2ff !important;}
</style>
{/literal}

<div class="title">
  <h5>{if !$smarty.request.id}{#MAILER_MAILS_ADD_TITLE#}{else}{#MAILER_MAILS_EDIT_TITLE#}{/if}</h5>
</div>
{*<div class="widget" style="margin-top: 0px;">
  <div class="body">
    {#MAILER_MAILS_ADD_INFO#}
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
      <li>{if !$smarty.request.id}{#MAILER_MAILS_ADD_TITLE#}{else}{#MAILER_MAILS_EDIT_TITLE#}{/if}</li>
      <li><strong class="code">{if !$smarty.request.id}{#MAILER_MAILS_NEW_TITLE#}{else}{$mail->subject}{/if}</strong></li>
    </ul>
  </div>
</div>
<form action="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=savemail&amp;act=go&amp;id={$smarty.request.id}&amp;cp={$sess}" method="post" enctype="multipart/form-data" class="mainForm" id="mail_form">
  <div class="widget first">
    <div class="head">
      <h5 class="iFrames">{#MAILER_MAILS_HEAD_MAIL#}</h5>
    </div>
    <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
      <col width="250">
      <tr class="noborder">
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
        <td><div class="pr12" id="html">
            <textarea class="mousetrap" name="body" id="codemirror" style="width:100%;height:300px">{$mail->body}</textarea>
          </div>
          <div class="pr12" id="text">
            <textarea class="mousetrap" name="body" style="width:100%;height:300px">{$mail->body}</textarea>
          </div>
          <div class="pr12" style="margin-top:4px;">
          <a style="float:left; margin:6px 3px 0;" class="icon_sprite ico_list" target="_blank" href="/index.php?module=mailer&amp;action=show&amp;id={$mail->id}&amp;onlycontent=1"></a>
            <strong><a {if !$smarty.request.id}onClick="jAlert('{#MAILER_MAILS_SHOW_ALERT#}','{#MAILER_SHOWING#}');return false;"{/if} style="float:left; padding:4px 0" target="_blank" href="/index.php?module=mailer&amp;action=show&amp;id={$smarty.request.id}&amp;onlycontent=1">{#MAILER_MAILS_SHOW#}&nbsp;&raquo;</a></strong>
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
      &nbsp;
      <input class="blackBtn SaveEdit" type="button" value="{#MAILER_MAILS_SAVE_BTN_C#}" />
    </div>
  </div>

  <div class="widget first">
    <div class="head">
      <h5 class="iFrames">{#MAILER_MAILS_HEAD_SET#}</h5>
    </div>
    <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
      <col width="250">
      <tr class="noborder">
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
            <input class="mousetrap" id="from_copy" name="from_copy" type="checkbox" value="1"{if $mail->from_copy} checked{/if} />
          </div></td>
      </tr>
      <tr>
        <td>{#MAILER_MAILS_RECIEVERS#}: {#MAILER_MAILS_REC_GROUPS#} "{$mail->site_name}"<br />
          <small>{#MAILER_MAILS_CTRL#}</small></td>
        <td><div class="pr12">
            <select class="mousetrap" id="groups" name="to_groups[]" size="{if $mail->usergroups|@count < 8}{$mail->usergroups|@count}{else}8{/if}" multiple="multiple" style="min-width:310px">
              {foreach from=$mail->usergroups item=usergroup}
              <option value="{$usergroup->user_group}" {if $usergroup->user_group|in_array:$mail->to_groups} selected="selected"{/if}>{$usergroup->user_group_name|escape}</option>
              {/foreach}
            </select>
          </div></td>
      </tr>
      <tr>
        <td>{#MAILER_MAILS_RECIEVERS#}: {#MAILER_MAILS_REC_LISTS#}<br />
          <small>{#MAILER_MAILS_CTRL#}</small></td>
        <td><div class="pr12">
            <select class="mousetrap" id="lists" name="to_lists[]" size="{if $mail->lists|@count < 8}{$mail->lists|@count}{else}8{/if}" multiple="multiple" style="min-width:310px">
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
        <td>{#MAILER_MAILS_FINAL_REC#}</td>
        <td><div class="pr12">
            <input type="button" class="greenBtn" onclick="openLinkWinId('document_parent','document_parent');" value="{#MAILER_MAILS_MAKE_FIN#}"/>
          </div></td>
      </tr>
    </table>
    <div class="rowElem">
      <input onclick="save_func(false);" class="basicBtn" type="button" value="{#MAILER_MAILS_SAVE_BTN#}" />
      &nbsp;
      <input class="blackBtn SaveEdit" type="button" value="{#MAILER_MAILS_SAVE_BTN_C#}" />
      &nbsp;
      <input type="button" onclick="test();" class="greenBtn" value="{#MAILER_MAILS_TEST_BTN#}" />
      &nbsp;
      <input type="button" onclick="presend();" id="butt_send" class="redBtn" value="{#MAILER_MAILS_SEND_BTN#}" />
      <div id="progressbar" style="display:none;clear:both;margin-top:10px;"></div>
      <div id="sent_ok" class="highlight yellow" style="{if !$mail->sent}display:none;{/if}margin-top:10px;">{if $mail->sent}{$mail->date|date_format:$TIME_FORMAT|pretty_date}: {/if}{#MAILER_SENT_OK_TEXT#}
      <strong><a href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=1&amp;cp={$sess}">&raquo;&nbsp;{#MAILER_SENT_OK_LINK#}</a></strong></div>
    </div>
  </div>
</form>
<script>
{if $mail->sent} $(':input').attr('disabled','disabled');{/if}

function test() {ldelim}
if (full_check(false)) {ldelim}
	jPrompt('{#MAILER_MAILS_SEND_TEST#}','{$test_email}','{#MAILER_SENDING_TEST#}',function(emails){ldelim}
		if(!emails) return false;
		$("#mail_form").ajaxSubmit({ldelim}
			url: 'index.php?do=modules&action=modedit&mod=mailer&moduleaction=testsend&id={$smarty.request.id}&cp={$sess}',
			data: ({ldelim}'emails': emails{rdelim}),
			beforeSubmit: function() {ldelim}$.alerts._overlay('show');{rdelim},
			success: function(data) {ldelim}
				$.alerts._overlay('hide');
				$.jGrowl('{#MAILER_MAILS_TEST_OK#} '+data);
			{rdelim}
		{rdelim});
	{rdelim});
{rdelim}
{rdelim}

function presend() {ldelim}
if (full_check(true)) {ldelim}
	jConfirm('{#MAILER_MAILS_SEND_Q#}','{#MAILER_SENDING#}',function(b){ldelim}
		if (b){ldelim}
			$("#mail_form").ajaxSubmit({ldelim}
				url: 'index.php?do=modules&action=modedit&mod=mailer&moduleaction=savemail&id={$smarty.request.id}&cp={$sess}',
				data: ({ldelim}act:'send'{rdelim}),
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
				location.reload();
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
	data: ({ldelim}act:'ajaxsave'{rdelim}),
	success: function(data) {ldelim}
		$.jGrowl('{#MAILS_SAVED#}');
		{if !$smarty.request.id} location.href="index.php?do=modules&action=modedit&mod=mailer&moduleaction=editmail&id="+data+"&cp={$sess}";
		{else}$.alerts._overlay('hide');{/if}
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
				$("#mail_form").ajaxSubmit(save_form);
			{rdelim}
		{rdelim});
	{rdelim}
	else {ldelim}
		if(!ajax) $("#mail_form").submit();
		else $("#mail_form").ajaxSubmit(save_form);
	{rdelim}
{rdelim}

{if !$mail->sent}
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
{/if}

{literal}
$(document).ready(function() {
	var active_type = $("input[name=type]:checked").attr("value");
	if (active_type == 'text') {
		$("#html").hide(); $("#text").show(); $("#html textarea").attr("name","");
	}
	else {
		$("#text").hide(); $("#html").show(); $("#text textarea").attr("name","");
	}

	$("input[name=type]").click(function() {
		if($(this).attr("value")=='text') {
			$("#html").hide();
			$("#html textarea").attr("name","");
			$("#text").show();
			$("#text textarea").attr("name","body");
		}
		else {
			$("#text").hide();
			$("#text textarea").attr("name","");
			$("#html").show();
			$("#html textarea").attr("name","body");
		}
	});
});

function openLinkWinId(target,doc) {
	save_func(true);
	var width = screen.width * 0.9;
	var height = screen.height * 0.9;
	var left = ( screen.width - width ) / 2;
	var top = ( screen.height - height ) / 2;
	window.open('index.php?do=modules&action=modedit&mod=mailer&moduleaction=showcount&id={$smarty.request.id}&pop=1&cp={$sess}','pop','left='+left+',top='+top+',width='+width+',height='+height+',scrollbars=1,resizable=1');
}
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
{rdelim}

function full_check(rec) {ldelim}
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

	if (rec && !$("#groups").val() && !$("#lists").val() && !$("#to_add").val()) {ldelim}
		jAlert('{#MAILER_ERR_TO#}','{#MAILER_SENDING#}',
			function() {ldelim}$("#groups").focus();{rdelim});
		return false;
	{rdelim}

	if (!$("#subject").val()) {ldelim}
		jAlert('{#MAILER_ERR_SUBJECT#}','{#MAILER_SENDING#}',
			function() {ldelim}$("#subject").focus();{rdelim});
		return false;
	{rdelim}

	if (!$("textarea[name=body]").val()) {ldelim}
		jAlert('{#MAILER_ERR_BODY#}','{#MAILER_SENDING#}',
			function() {ldelim}$("textarea[name=body]").focus();{rdelim});
		return false;
	{rdelim}
	
	return true;
{rdelim}

var editor = CodeMirror.fromTextArea(document.getElementById("codemirror"),{ldelim}
	readOnly: {if $mail->sent} true {else} false {/if},
	extraKeys: {ldelim}"Ctrl-S": function(cm){ldelim}save_func(true);{rdelim}{rdelim},
	lineNumbers: true,
	lineWrapping: true,
	matchBrackets: true,
	mode: "application/x-httpd-php",
	indentUnit: 4,
	indentWithTabs: true,
	enterMode: "keep",
	tabMode: "shift",
	onChange: function(){ldelim}editor.save();{rdelim},
	onCursorActivity: function() {ldelim}
		editor.setLineClass(hlLine, null, null);
		hlLine = editor.setLineClass(editor.getCursor().line, null, "activeline");
	{rdelim}
{rdelim});
var hlLine = editor.setLineClass(0, "activeline");
</script>