<div class="title">
  <h5>{#MAILER_MULTI_TITLE#}</h5>
</div>
<div class="widget" style="margin-top: 0px;">
  <div class="body">
    {#MAILER_MULTI_INFO#}
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
      <li><strong class="code">{#MAILER_MULTI_TITLE#}</strong></li>
    </ul>
  </div>
</div>
<form action="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=multisave&amp;return=1&amp;cp={$sess}" method="post" class="mainForm">
  <div class="widget first">
    <div class="head{if $smarty.request.id != ''} closed{/if}">
      <h5 class="iFrames">{#MAILER_MULTI_TITLE2#}</h5>
    </div>
    <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
      <tr class="noborder">
        <td width="250">{#MAILER_MULTI_LISTS#}<br />
          <small>{#MAILER_MAILS_CTRL#}</small></td>
        <td><div class="pr12">
            <select class="mousetrap" name="lists[]" size="{if $lists|@count < 16}{$lists|@count}{else}16{/if}" multiple="multiple" style="width:100%" id="lists">
              {foreach from=$lists item=list}
              <option value="{$list->id}" {if $list->id|in_array:$smarty.session.mailer.multi_add} selected="selected"{/if}>{$list->title|escape}</option>
              {/foreach}
            </select>
          </div></td>
      </tr>
    </table>
    <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
      <col width="34" />
      <col width="150" />
      <col width="150" />
      <col width="150" />
      <col width="150" />
      <col />
      <col width="20" />
      <thead>
        <tr class="noborder">
          <td align="center"><div align="center"><a href="javascript:void(0);" style="cursor:help;" class="rightDir icon_sprite ico_info" title="{#MAILER_REC_STATUS_I2#}"></a></div></td>
          <td>{#MAILER_REC_EMAIL#}</td>
          <td>{#MAILER_REC_LASTN#}</td>
          <td>{#MAILER_REC_FIRSTN#}</td>
          <td>{#MAILER_REC_MIDN#}</td>
          <td>{#MAILER_REC_COMMENTS#}</td>
          <td></td>
        </tr>
      </thead>
      <tbody id="receivers_list_body">
        <tr id="input_row_0">
          <td><input type="checkbox" value="1" name="new[0][status]" checked="checked"/></td>
          <td><input autocomplete="off" class="mousetrap" type="text" name="new[0][email]" placeholder="{#MAILER_REC_EMAIL#}" style="width:90%" onchange="if($(this).val()) checkemail($(this).val());" /></td>
          <td><input autocomplete="off" class="mousetrap" type="text" name="new[0][lastn]" placeholder="{#MAILER_REC_LASTN#}" style="width:90%" /></td>
          <td><input autocomplete="off" class="mousetrap" type="text" name="new[0][firstn]" placeholder="{#MAILER_REC_FIRSTN#}" style="width:90%" /></td>
          <td><input autocomplete="off" class="mousetrap" type="text" name="new[0][midn]" placeholder="{#MAILER_REC_MIDN#}" style="width:90%" /></td>
          <td><input autocomplete="off" class="mousetrap" type="text" name="new[0][comments]" placeholder="{#MAILER_REC_COMMENTS#}" style="width:95%" /></td>
          <td align="center">
            <input onclick="input_addrow($(this));" type="button" class="topleftDir basicBtn addrow_btn" value="+" style="padding:2px 6px;" title="{#MAILER_INPUT_ADD_ROW#}" />
            <a class="icon_sprite ico_delete" style="cursor:pointer;display:none" onClick="$(this).parent().parent().remove();"></a></td>
        </tr>
      </tbody>
    </table>
    <div class="rowElem">
      <input class="basicBtn" type="submit" formaction="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=multisave&amp;cp={$sess}" value="{#MAILER_MULTI_BTN#}" />&nbsp;
      <input class="blackBtn" type="submit" value="{#MAILER_MULTI_BTN_CTRL#}" />
    </div>
  </div>
</form>

<script>
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
		if (!$("#lists").val()) {ldelim}
			jAlert('{#MAILER_MULTI_NOLIST#}','{#MAILER_ADDING#}',function(){ldelim}$("#lists").focus();{rdelim});
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
	$("#input_row_"+num_new+" input").not(".addrow_btn").removeAttr("value");
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
					  $.jGrowl("{#MAILER_MULTI_EMAIL_OK#}"); break;
				{rdelim}
			{rdelim}
	{rdelim});
{rdelim};
</script>