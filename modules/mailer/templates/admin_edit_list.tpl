<div class="title">
  <h5>{if !$smarty.request.id}{#MAILER_LISTS_ADD_TITLE#}{else}{#MAILER_LISTS_EDIT_TITLE#}{/if}</h5>
</div>
<div class="widget" style="margin-top: 0px;">
  <div class="body">
    {#MAILER_LISTS_EDIT_INFO#}
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
        <a href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=1&amp;cp={$sess}">{#MAILER_MODULE_NAME#}</a>
      </li>
      <li>
        <a href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=showlists&amp;cp={$sess}">{#MAILER_MANAGE_LISTS#}</a>
      </li>
      <li>{if !$smarty.request.id}{#MAILER_LISTS_ADD_TITLE#}{else}{#MAILER_LISTS_EDIT_TITLE#}{/if}</li>
      <li><strong class="code">{if !$smarty.request.id}{#MAILER_LISTS_CREATE_T#}{else}{$list->title|escape}{/if}</strong></li>
    </ul>
  </div>
</div>
<form action="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=savelist&amp;id={$smarty.request.id}&amp;return=1&amp;cp={$sess}" method="post" class="mainForm" enctype="multipart/form-data">
  <div class="widget first">
    <div class="head{if $smarty.request.id != ''} closed{/if}">
      <h5 class="iFrames">{#MAILER_LISTS_SET_COM#}</h5>
    </div>
    <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic" id="list_com_set">
      <tr class="noborder">
        <td width="250">{#MAILER_LISTS_TITLE#}</td>
        <td><div class="pr12">
            <input id="list_title" class="mousetrap" type="text" value="{$list->title|escape}" name="title" placeholder="{#MAILER_LISTS_TITLE#}" style="width:250px;" />
          </div></td>
      </tr>
      <tr>
        <td width="250">{#MAILER_LISTS_DESCR#}</td>
        <td><div class="pr12">
            <textarea class="mousetrap" name="descr" style="width:300px;height:50px" placeholder="{#MAILER_LISTS_DESCR_INFO#}">{$list->descr}</textarea>
          </div></td>
      </tr>
    </table>
    <div class="rowElem">
      <input type="submit" class="basicBtn"  value="{if !$smarty.request.id}{#MAILER_ADD_BTN#} {else}{#MAILER_EDIT_BTN#}{/if}" formaction="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=savelist&amp;id={$smarty.request.id}&amp;cp={$sess}" />
      &nbsp;
      <input type="submit" class="blackBtn"  value="{if !$smarty.request.id}{#MAILER_ADD_CONT_BTN#} {else}{#MAILER_EDIT_CONT_BTN#}{/if}" />
    </div>
  </div>
  
  {if $page_nav}
  <div class="pagination" style="margin-top:26px;">
    <ul class="pages">
      {$page_nav}
    </ul>
  </div>
  {/if}

  <div class="widget first" id="receivers_list">
    <div class="head">
      <h5 class="iFrames">{#MAILER_LISTS_SET_REC#}</h5>
    </div>
    <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
      <col width="34" />
      <col width="34" />
      <col width="150" />
      <col width="150" />
      <col width="150" />
      <col width="150" />
      <col />
      <col width="20" />
      <col width="20" />
      <thead>
        <tr class="noborder">
          <td></td>
          <td align="center"><div align="center"><a href="javascript:void(0);" class="help rightDir icon_sprite ico_info" title="{#MAILER_REC_STATUS_I#}"></a></div></td>
          <td>{#MAILER_REC_EMAIL#}</td>
          <td>{#MAILER_REC_LASTN#}</td>
          <td>{#MAILER_REC_FIRSTN#}</td>
          <td>{#MAILER_REC_MIDN#}</td>
          <td>{#MAILER_REC_COMMENTS#}</td>
          <td colspan="2">{#MAILER_ACTIONS#}</td>
        </tr>
      </thead>
      <tbody id="receivers_list_body">
        <tr id="input_row_0">
          <td></td>
          <td><input type="checkbox" class="mousetrap status" value="1" name="new[0][status]" checked="checked"/></td>
          <td><input autocomplete="off" class="mousetrap" type="text" name="new[0][email]" placeholder="{#MAILER_REC_EMAIL#}" style="width:90%" onchange="if($(this).val()) checkemail($(this).val());" /></td>
          <td><input autocomplete="off" class="mousetrap" type="text" name="new[0][lastn]" placeholder="{#MAILER_REC_LASTN#}" style="width:90%" /></td>
          <td><input autocomplete="off" class="mousetrap" type="text" name="new[0][firstn]" placeholder="{#MAILER_REC_FIRSTN#}" style="width:90%" /></td>
          <td><input autocomplete="off" class="mousetrap" type="text" name="new[0][midn]" placeholder="{#MAILER_REC_MIDN#}" style="width:90%" /></td>
          <td><input autocomplete="off" class="mousetrap" type="text" name="new[0][comments]" placeholder="{#MAILER_REC_COMMENTS#}" style="width:95%" /></td>
          <td colspan="2" align="center">
            <input onclick="input_addrow($(this));" type="button" class="topleftDir basicBtn addrow_btn" value="+" style="padding:2px 6px;" title="{#MAILER_INPUT_ADD_ROW#}" />
            <a class="icon_sprite ico_delete" style="cursor:pointer;display:none" onClick="$(this).parent().parent().remove();"></a></td>
        </tr>
      {foreach from=$receivers item=rec}
      <tr id="rec_{$rec->id}">
        <td><a class="rightDir icon_sprite ico_info help" href="javascript:void(0);" title="{#MAILER_REC_DATE_ADD#} {$rec->date|date_format:$TIME_FORMAT|pretty_date}"></a></td>
        <td>
          <input type="hidden" name="status[{$rec->id}]" value="{if $rec->status=="2"}2{else}0{/if}"/>
          <input type="checkbox" class="toprightDir" name="status[{$rec->id}]" value="1" {if $rec->status=="1"}checked="checked"{elseif $rec->status=="2"} disabled="disabled" title="{#MAILER_REC_REFUSED#}"{/if}/></td>
        <td><a href="mailto:{$rec->email|escape}" target="_blank">{$rec->email}</a></td>
        <td class="lastn">{$rec->lastname|escape}</td>
        <td class="firstn">{$rec->firstname|escape}</td>
        <td class="midn">{$rec->middlename|escape}</td>
        <td class="comments">{$rec->comments|escape}</td>
        <td align="center"><a id="rec_btn_{$rec->id}" class="topleftDir icon_sprite ico_edit" style="cursor:pointer" onclick="edit_string({$rec->id});" title="{#MAILER_ACTIONS_EDIT#}"></a></td>
        <td align="center"><a class="topleftDir icon_sprite ico_delete" onClick="del_receiver({$rec->id},'{$rec->email|escape}')" title="{#MAILER_ACTIONS_DEL#}" style="cursor:pointer"></a></td>
      </tr>
      {/foreach}
     </tbody>
    </table>
    {if !$receivers}
    <div class="rowElem">
      <ul class="messages">
        <li class="highlight yellow">{#MAILER_REC_NOITEMS#}</li>
      </ul>
    </div>
    {/if}
  </div>
  
  {if $page_nav}
  <div class="pagination" style="margin-top:26px;">
    <ul class="pages">
      {$page_nav}
    </ul>
  </div>
  {/if}

  <div class="widget first">
    <div class="head closed">
      <h5 class="iFrames">{#MAILER_LISTS_IMPORT#}</h5>
    </div>
    <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
      <tr class="noborder">
        <td width="250">{#MAILER_LISTS_IMPORT_T#}<br /><small>{#MAILER_LISTS_IMPORT_T_I#}</small></td>
        <td>
          <div class="pr12">
            <textarea class="mousetrap" name="import" style="width:100%; height:200px;" ></textarea>
          </div>
          <div class="pr12" style="margin-top:10px;">
            <label style="float:left;padding-left:0;">{#MAILER_LISTS_IMPORT_T_1#}</label><input class="mousetrap" type="text" autocomplete="off" name="import_delim_1" style="width:30px;float:left;text-align:center;" value="{if $smarty.session.mailer.list_import_delim_1}{$smarty.session.mailer.list_import_delim_1|stripslashes}{else};{/if}" />
            <label style="float:left">{#MAILER_LISTS_IMPORT_T_2#}</label><input class="mousetrap" type="text" autocomplete="off" name="import_delim_2" style="width:30px;float:left;text-align:center;" value="{if $smarty.session.mailer.list_import_delim_2}{$smarty.session.mailer.list_import_delim_2|stripslashes}{else},{/if}" />
          </div>
          <div class="pr12" style="clear:both;">
            <small>{#MAILER_LISTS_IMPORT_T_H#}</small>
          </div>
        </td>
      </tr>
      <tr>
        <td width="250">{#MAILER_LISTS_IMPORT_F#}<br /><small>{#MAILER_LISTS_IMPORT_F_I#}</small></td>
        <td>
          <div class="pr12">
            <input type="file" name="import_file" class="fileInput" />
          </div>
          <div class="pr12" style="margin-top:10px;">
            <label style="float:left;padding-left:0">{#MAILER_LISTS_IMPORT_F_D#}</label><input class="mousetrap" type="text" autocomplete="off" name="import_file_delim" style="width:30px;float:left;text-align:center;" value="{if $smarty.session.mailer.list_import_delim_csv}{$smarty.session.mailer.list_import_delim_csv|stripslashes}{else};{/if}" />
          </div>
          <div class="pr12" style="clear:both;">
            <small>{#MAILER_LISTS_IMPORT_F_H#}</small>
          </div>
        </td>
      </tr>
    </table>
    <div class="rowElem">
      <input type="submit" class="basicBtn"  value="{if !$smarty.request.id}{#MAILER_ADD_BTN#} {else}{#MAILER_EDIT_BTN#}{/if}" formaction="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=savelist&amp;id={$smarty.request.id}&amp;cp={$sess}" />
      &nbsp;
      <input type="submit" class="blackBtn"  value="{if !$smarty.request.id}{#MAILER_ADD_CONT_BTN#} {else}{#MAILER_EDIT_CONT_BTN#}{/if}" />
      <input type="hidden" value="{$smarty.request.page}" name="page"/>
    </div>
  </div>
</form>

<script language="javascript">
$(document).ready(function() {ldelim}
	Mousetrap.bind(['ctrl+s', 'meta+s'], function(e) {ldelim}
		if (e.preventDefault) {ldelim}
			e.preventDefault();
		{rdelim}
		else {ldelim}
			// internet explorer
			e.returnValue = false;
		{rdelim}
		$("form").submit();
		return false;
	{rdelim});
	input_new = 0;
	
	$("form").submit(function() {ldelim}
		if (!$("#list_title").val()) {ldelim}
			jAlert('{#MAILER_LISTS_NOTITLE#}','{#MAILER_SAVING#}',function(){ldelim}$("#list_com_set").show();$("#list_title").focus();{rdelim});
			return false;
		{rdelim}
	{rdelim});
{rdelim});

function edit_string(id){ldelim}
	fields = {ldelim}0:"lastn",1:"firstn",2:"midn",3:"comments"{rdelim}
	for(var f in fields) {ldelim}
		field = fields[f];
		value = $("#rec_"+id+" td."+field).text();
		$("#rec_"+id+" td."+field).empty();
		$("[name=new\\[0\\]\\["+field+"\\]]").clone().attr("value",value).attr("name","edit["+id+"]["+field+"]").appendTo("#rec_"+id+" td."+field);
	{rdelim}
	$("#rec_btn_"+id).removeAttr("onclick").removeClass("ico_edit").attr("title","{#MAILER_ACTIONS_HOWSAVE#}").addClass("ico_edit_no");
{rdelim}

function input_addrow(object){ldelim}
	id = object.parent().parent().attr("id");
	var tpl = /input_row_([0-9]*)/ig;
	var num_old = Number(tpl.exec(id)[1]);
	var num_new = num_old+1;
	$("#input_row_"+num_old).clone().attr("id","input_row_"+num_new).prependTo("#receivers_list_body");
	$("#input_row_"+num_old+" .addrow_btn").hide();
	$("#input_row_"+num_old+" .ico_delete").show();
	$("#input_row_"+num_new+" input").not(".addrow_btn, .status").removeAttr("value");
	$("#input_row_"+num_new).find("input").each(function(){ldelim}
		var tpl = /new\[[0-9]*\]\[(.*)\]/ig;
		var namepart = tpl.exec($(this).attr("name"))[1];
		$(this).attr("name","new["+num_new+"]["+namepart+"]");
	{rdelim});
{rdelim}

function checkemail(email){ldelim}
	$.ajax({ldelim}
		beforeSend:
			function(){ldelim}
				$.alerts._overlay('show');
			{rdelim},
		url: 'index.php',
		data: ({ldelim}
			'do': 'modules',
			action: 'modedit',
			mod: 'mailer',
			moduleaction: 'checkemail',
			list_id: '{$smarty.request.id}',
			email: email,
			cp: '{$sess}'
			{rdelim}),
		timeout:3000,
		success:
			function(data){ldelim}
				$.alerts._overlay('hide');
				switch (Number(data)) {ldelim}
				   case 0:
					  $.jGrowl("{#MAILER_ER_EMAIL_SYN#}"); break;
				   case 1:
					  $.jGrowl("{#MAILER_REC_EMAIL_OK#}"); break;
				   case 2:
					  $.jGrowl("{#MAILER_REC_EMAIL_NO#}"); break;
				{rdelim}
			{rdelim}
	{rdelim});
{rdelim};

function del_receiver(rec_id,rec_email) {ldelim}
	jConfirm('{#MAILER_REC_DEL#} '+rec_email+'?','{#MAILER_DELETING#}',function(r) {ldelim}
		if(r) {ldelim}
			$.ajax({ldelim}
				url: 'index.php?do=modules&action=modedit&mod=mailer&cp=6c8fgl38te5rgloor09u1dglv1',
				data: ({ldelim}moduleaction:'delreceiver', rec_id:rec_id{rdelim}),
				success: function(data) {ldelim}
					$.jGrowl('{#MAILER_REC_DELETED#}');
					$("#rec_"+rec_id).hide();
				{rdelim}
			{rdelim});
		{rdelim}
	{rdelim});
{rdelim}
</script>