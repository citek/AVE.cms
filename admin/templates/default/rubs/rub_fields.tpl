<script language="Javascript" type="text/javascript">
$(document).ready(function(){ldelim}
	$('tr.tpls').hide();

	$("#selall").click(function(){ldelim}
		if ($("#selall").is(":checked")){ldelim}
			$(".checkbox").removeAttr("checked");
			$("#Fields a.jqTransformCheckbox").removeClass("jqTransformChecked");
		{rdelim}else{ldelim}
	   		$(".checkbox").attr("checked","checked");
			$("#Fields a.jqTransformCheckbox").addClass("jqTransformChecked");
		{rdelim}
	{rdelim});

	$(".selall").click(function(){ldelim}
		if ($(this).is(":checked")) {ldelim}
			$("tr."+this.id).find(".checkbox").removeAttr("checked");
			$("tr."+this.id).find("a.jqTransformCheckbox").removeClass("jqTransformChecked");
		{rdelim}
		else {ldelim}
			$("tr."+this.id).find(".checkbox").attr("checked","checked");
			$("tr."+this.id).find("a.jqTransformCheckbox").addClass("jqTransformChecked");
		{rdelim}
	{rdelim});

	{literal}
	$('.collapsible').collapsible({
		defaultOpen: 'opened',
		cssOpen: 'inactive',
		cssClose: 'normal',
		cookieName: 'collaps_rub',
		cookieOptions: {
	        expires: 7,
			domain: ''
    	},
		speed: 200
	});
	{/literal}

{rdelim});
</script>


<div class="title"><h5>{#RUBRIK_EDIT_FIELDS#}</h5></div>
	{if !$rub_fields}
<div class="widget" style="margin-top: 0px;"><div class="body">{#RUBRIK_NO_FIELDS#}</div></div>
	{else}
<div class="widget" style="margin-top: 0px;"><div class="body">{#RUBRIK_FIELDS_INFO#}</div></div>
	{/if}

<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=rubs&amp;cp={$sess}">{#RUBRIK_SUB_TITLE#}</a></li>
	        <li>{#RUBRIK_EDIT_FIELDS#}</li>
	        <li><strong class="code">{$rubric_title}</strong></li>
	    </ul>
	</div>
</div>


{if $rub_fields}

<form action="index.php?do=rubs&amp;action=edit&amp;Id={$smarty.request.Id|escape}&amp;cp={$sess}" method="post" class="mainForm" id="Rubric">

<div class="widget first">
<div class="head"><h5 class="iFrames">{#RUBRIK_FIELDS_TITLE#}</h5><div class="num"><a class="basicNum" href="index.php?do=rubs&action=template&Id={$smarty.request.Id|escape}&cp={$sess}">{#RUBRIK_EDIT_TEMPLATE#}</a></div></div>

	{assign var=js_form value='kform'}
<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic" id="Fields">
		<col width="20">
		<col width="100">
		<col width="220">
		<col width="220">
		<col>
		<col width="72">
		<col width="20">
		<thead>
		<tr>
			<td align="center"><div align="center"><input type="checkbox" id="selall" value="1" /></div></td>
			<td>{#RUBRIK_ID#}</td>
			<td>{#RUBRIK_FIELD_NAME#}</td>
			<td>{#RUBRIK_FIELD_TYPE#}</td>
			<td>{#RUBRIK_FIELD_DEFAULT#}</td>
			<td>{#RUBRIK_POSITION#}</td>
			<td align="center">
				<div align="center"><a class="topleftDir icon_sprite ico_template" title="{#RUBRIK_TEMPLATE_HIDE#}" href="javascript:void(0);" onclick="$('tr.tpls').hide();"></a></div>
			</td>
		</tr>
		</thead>
		<tbody>
		{foreach from=$rub_fields item=rf}
			<tr>
				<td align="center"><input title="{#RUBRIK_MARK_DELETE#}" name="del[{$rf->Id}]" type="checkbox" id="del[{$rf->Id}]" value="1" class="checkbox" /></td>
				<td>[tag:fld:{$rf->Id}]</td>
				<td><div class="pr12"><input name="title[{$rf->Id}]" type="text" id="title[{$rf->Id}]" value="{$rf->rubric_field_title|escape}" style="width:100%;" /></div></td>
				<td>
					<select name="rubric_field_type[{$rf->Id}]" id="rubric_field_type[{$rf->Id}]" style="width: 250px;">
						{section name=feld loop=$felder}
							<option value="{$felder[feld].id}" {if $rf->rubric_field_type==$felder[feld].id}selected{/if}>{$felder[feld].name}</option>
						{/section}
					</select>
				</td>
				<td><div class="pr12"><input name="rubric_field_default[{$rf->Id}]" type="text" id="rubric_field_default[{$rf->Id}]" value="{$rf->rubric_field_default}" style="width:100%;" /></div></td>
				<td>
					<div class="pr12"><input name="rubric_field_position[{$rf->Id}]" type="text" id="rubric_field_position[{$rf->Id}]" value="{$rf->rubric_field_position}" size="4" maxlength="5" autocomplete="off" /></div>
				</td>
				<td align="center">
					<a class="topleftDir icon_sprite ico_template" title="{#RUBRIK_TEMPLATE_TOGGLE#}" href="javascript:void(0);" onclick="$('#tpl_{$rf->Id}').toggle();"></a>
				</td>
			</tr>
			<tr id="tpl_{$rf->Id}" class="tpls">
				<td colspan="7">

				<div style="padding-right: 12px">
				<div style="width:50%; float:left;">
					<div><strong>{#RUBRIK_FIELDS_TPL#}</strong></div>
					<textarea wrap="off" style="width:100%; height:70px" name="rubric_field_template[{$rf->Id}]" id="rubric_field_template[{$rf->Id}]">{$rf->rubric_field_template|escape}</textarea>
                    	|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_insert('[tag:parametr:]', 'rubric_field_template[{$rf->Id}]', 'Rubric');"><strong>[tag:parametr:XXX]</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_insert('[tag:X000x000:[tag:parametr:]]', 'rubric_field_template[{$rf->Id}]', 'Rubric');"><strong>[tag:X000x000:[tag:parametr:XXX]]</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_insert('[tag:path]', 'rubric_field_template[{$rf->Id}]', 'Rubric');"><strong>[tag:path]</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_insert('[tag:docid]', 'rubric_field_template_request[{$rf->Id}]', 'Rubric');"><strong>[tag:docid]</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_tag('tag:if_empty', 'rubric_field_template[{$rf->Id}]', 'Rubric');"><strong>[tag:if_empty]&nbsp;[/tag:if_empty]</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_tag('tag:if_notempty', 'rubric_field_template[{$rf->Id}]', 'Rubric');"><strong>[tag:if_notempty]&nbsp;[/tag:if_notempty]</strong></a>
						&nbsp;|

						<br />

						|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_code('div', 'rubric_field_template[{$rf->Id}]', 'Rubric');"><strong>DIV</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_code('p', 'rubric_field_template[{$rf->Id}]', 'Rubric');"><strong>P</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_code('strong', 'rubric_field_template[{$rf->Id}]', 'Rubric');"><strong>B</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_code('em', 'rubric_field_template[{$rf->Id}]', 'Rubric');"><strong>I</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_code('h1', 'rubric_field_template[{$rf->Id}]', 'Rubric');"><strong>H1</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_code('h2', 'rubric_field_template[{$rf->Id}]', 'Rubric');"><strong>H2</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_code('h3', 'rubric_field_template[{$rf->Id}]', 'Rubric');"><strong>H3</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_code('pre', 'rubric_field_template[{$rf->Id}]', 'Rubric');"><strong>PRE</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_insert('<br />', 'rubric_field_template[{$rf->Id}]', 'Rubric');"><strong>BR</strong></a>
						&nbsp;|
				</div>
				<div style="width:50%; float:left;">
					<div><strong>{#RUBRIK_REQUEST_TPL#}</strong></div>
					<textarea wrap="off" style="width:100%; height:70px" name="rubric_field_template_request[{$rf->Id}]" id="rubric_field_template_request[{$rf->Id}]">{$rf->rubric_field_template_request|escape}</textarea>
                    	|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_insert('[tag:parametr:]', 'rubric_field_template_request[{$rf->Id}]', 'Rubric');"><strong>[tag:parametr:XXX]</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_insert('[tag:X000x000:[tag:parametr:]]', 'rubric_field_template_request[{$rf->Id}]', 'Rubric');"><strong>[tag:X000x000:[tag:parametr:XXX]]</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_insert('[tag:path]', 'rubric_field_template_request[{$rf->Id}]', 'Rubric');"><strong>[tag:path]</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_insert('[tag:docid]', 'rubric_field_template_request[{$rf->Id}]', 'Rubric');"><strong>[tag:docid]</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_tag('tag:if_empty', 'rubric_field_template_request[{$rf->Id}]', 'Rubric');"><strong>[tag:if_empty]&nbsp;[/tag:if_empty]</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_tag('tag:if_notempty', 'rubric_field_template_request[{$rf->Id}]', 'Rubric');"><strong>[tag:if_notempty]&nbsp;[/tag:if_notempty]</strong></a>
						&nbsp;|

						<br />

						|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_code('div', 'rubric_field_template_request[{$rf->Id}]', 'Rubric');"><strong>DIV</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_code('p', 'rubric_field_template_request[{$rf->Id}]', 'Rubric');"><strong>P</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_code('strong', 'rubric_field_template_request[{$rf->Id}]', 'Rubric');"><strong>B</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_code('em', 'rubric_field_template_request[{$rf->Id}]', 'Rubric');"><strong>I</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_code('h1', 'rubric_field_template_request[{$rf->Id}]', 'Rubric');"><strong>H1</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_code('h2', 'rubric_field_template_request[{$rf->Id}]', 'Rubric');"><strong>H2</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_code('h3', 'rubric_field_template_request[{$rf->Id}]', 'Rubric');"><strong>H3</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_code('pre', 'rubric_field_template_request[{$rf->Id}]', 'Rubric');"><strong>PRE</strong></a>&nbsp;|&nbsp;
						<a class="docname" href="javascript:void(0);" onclick="javascript:cp_insert('<br />', 'rubric_field_template_request[{$rf->Id}]', 'Rubric');"><strong>BR</strong></a>
						&nbsp;|
				</div>
				</div>
				</td>
			</tr>
		{/foreach}
		<tr>
			<td colspan="7">
				<input type="hidden" name="submit" value="" id="nf_save_next" />
				<input type="submit" class="basicBtn" value="{#RUBRIK_BUTTON_SAVE#}" onclick="document.getElementById('nf_save_next').value='save'" />&nbsp;
				<input type="submit" class="redBtn" value="{#RUBRIK_BUTTON_TEMPL#}" onclick="document.getElementById('nf_save_next').value='next'" />
			</td>
		</tr>
		</tbody>
	</table>

</div>
</form>
{/if}

<div class="widget first">
	<div class="head collapsible" id="opened"><h5>{#RUBRIK_NEW_FIELD#}</h5></div>
	<div style="display: block;">
	<form id="newfld" action="index.php?do=rubs&amp;action=edit&amp;Id={$smarty.request.Id|escape}&amp;cp={$sess}" method="post" class="mainForm">
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
		<col width="356" class="second">
		<col width="220" class="second">
		<col class="second">
		<col width="100" class="second">
		<thead>
		<tr>
			<td>{#RUBRIK_FIELD_NAME#}</td>
			<td>{#RUBRIK_FIELD_TYPE#}</td>
			<td>{#RUBRIK_FIELD_DEFAULT#}</td>
			<td>{#RUBRIK_POSITION#}</td>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td>
				<div class="pr12"><input name="TitelNew" type="text" id="TitelNew" value="" style="width:100%;" /></div>
			</td>

			<td>
				<select name="RubTypNew" id="RubTypNew" style="width: 250px;">
					{section name=feld loop=$felder}
						<option value="{$felder[feld].id}">{$felder[feld].name}</option>
					{/section}
				</select>
			</td>

			<td>
				<div class="pr12"><input name="StdWertNew" type="text" id="StdWertNew" value="" style="width:100%;" /></div>
			</td>

			<td>
				<div class="pr12"><input name="rubric_field_position_new" type="text" id="rubric_field_position_new" value="100" size="4" maxlength="5" autocomplete="off" /></div>
			</td>
		</tr>

		<tr>
			<td colspan="4" class="third">
				<input type="hidden" name="submit" value="" id="nf_hidd" />
				<input class="basicBtn" type="submit" value="{#RUBRIK_BUTTON_ADD#}" onclick="document.getElementById('nf_hidd').value='newfield'" /><br />
			</td>
		</tr>
		</tbody>
	</table>
</form>
</div>
</div>


{if check_permission('rubric_perms')}


<div class="widget first">
	<div class="head closed active"><h5>{#RUBRIK_SET_PERMISSION#}</h5></div>
	<div style="display: block;">
	<form id="rubperm" action="index.php?do=rubs&amp;action=edit&amp;Id={$smarty.request.Id|escape}&amp;cp={$sess}" method="post" class="mainForm">
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
		<col width="10%">
		<col width="15%">
		<col width="15%">
		<col width="15%">
		<col width="15%">
		<col width="15%">
		<col width="15%">
		<thead>
		<tr>
			<td>{#RUBRIK_USER_GROUP#}</td>
			<td align="center">{#RUBRIK_ALL_PERMISSION#} <div align="center"><a title="{#RUBRIK_ALL_TIP#}" href="javascript:void(0);" class="toprightDir icon_sprite ico_info_no"></a></div></td>
			<td align="center">{#RUBRIK_DOC_READ#} <div align="center"><a title="{#RUBRIK_VIEW_TIP#}" href="javascript:void(0);" class="toprightDir icon_sprite ico_info_no"></a></div></td>
			<td align="center">{#RUBRIK_CREATE_DOC#} <div align="center"><a title="{#RUBRIK_DOC_TIP#}" href="javascript:void(0);" class="toprightDir icon_sprite ico_info_no"></a></div></td>
			<td align="center">{#RUBRIK_CREATE_DOC_NOW#} <div align="center"><a title="{#RUBRIK_DOC_NOW_TIP#}" href="javascript:void(0);" class="topleftDir icon_sprite ico_info_no"></a></div></td>
			<td align="center">{#RUBRIK_EDIT_OWN#} <div align="center"><a title="{#RUBRIK_OWN_TIP#}" href="javascript:void(0);" class="topleftDir icon_sprite ico_info_no"></a></div></td>
			<td align="center">{#RUBRIK_EDIT_OTHER#} <div align="center"><a title="{#RUBRIK_OTHER_TIP#}" href="javascript:void(0);" class="topleftDir icon_sprite ico_info_no"></a></div></td>
		</tr>
		</thead>
		<tbody>
		{foreach from=$groups item=group}
			{assign var=doall value=$group->doall}
			<tr class="perm_group_{$group->user_group}">
				<td>
					{$group->user_group_name|escape:html}
				</td>

				<td align="center">
					{if $group->doall_h==1}
						<input type="hidden" name="perm[{$group->user_group}][]" value="alles" />
						<input name="{$group->user_group}" type="checkbox" value="1"{$doall} />
					{else}
						<input id="perm_group_{$group->user_group}" class="selall" name="perm[{$group->user_group}][]" type="checkbox" value="alles"{if in_array('alles', $group->permissions)} checked="checked"{/if}{if $group->user_group==2} disabled="disabled"{/if} />
					{/if}
				</td>

				<td align="center">
					{if $group->doall_h==1}
						<input type="hidden" name="perm[{$group->user_group}][]" value="docread" />
						<input name="{$group->user_group}" type="checkbox" value="1"{$doall} />
					{else}
						<input class="checkbox" name="perm[{$group->user_group}][]" type="checkbox" value="docread"{if in_array('docread', $group->permissions)} checked="checked"{/if} />
					{/if}
				</td>

				<td align="center">
					<input type="hidden" name="user_group[{$group->user_group}]" value="{$group->user_group}" />
					{if $group->doall_h==1}
						<input type="hidden" name="perm[{$group->user_group}][]" value="new" />
						<input name="{$group->user_group}" type="checkbox" value="1"{$doall} />
					{else}
						<input class="checkbox" onclick="document.getElementById('newnow_{$group->user_group}').checked = '';" id="new_{$group->user_group}" name="perm[{$group->user_group}][]" type="checkbox" value="new"{if in_array('new', $group->permissions)} checked="checked"{/if}{if $group->user_group==2} disabled="disabled"{/if} />
					{/if}
				</td>

				<td align="center">
					<input type="hidden" name="user_group[{$group->user_group}]" value="{$group->user_group}" />
					{if $group->doall_h==1}
						<input type="hidden" name="perm[{$group->user_group}][]" value="newnow" />
						<input name="{$group->user_group}" type="checkbox" value="1"{$doall} />
					{else}
						<input class="checkbox" onclick="document.getElementById('new_{$group->user_group}').checked = '';" id="newnow_{$group->user_group}" name="perm[{$group->user_group}][]" type="checkbox" value="newnow"{if in_array('newnow', $group->permissions)} checked="checked"{/if}{if $group->user_group==2} disabled="disabled"{/if} />
					{/if}
				</td>

				<td align="center">
					{if $group->doall_h==1}
						<input type="hidden" name="perm[{$group->user_group}][]" value="editown" />
						<input name="{$group->user_group}" type="checkbox" value="1"{$doall} />
					{else}
						<input class="checkbox" id="editown_{$group->user_group}" name="perm[{$group->user_group}][]" type="checkbox" value="editown"{if in_array('editown', $group->permissions)} checked="checked"{/if}{if $group->user_group==2} disabled="disabled"{/if} />
					{/if}
				</td>

				<td align="center">
					{if $group->doall_h==1}
						<input type="hidden" name="perm[{$group->user_group}][]" value="editall" />
						<input name="{$group->user_group}" type="checkbox" value="1"{$doall} />
					{else}
						<input class="checkbox" name="perm[{$group->user_group}][]" type="checkbox" value="editall"{if in_array('editall', $group->permissions)} checked="checked"{/if}{if $group->user_group==2} disabled="disabled"{/if} />
					{/if}
				</td>
			</tr>
		{/foreach}
		<tr>
			<td colspan="7" class="third">
				<input type="hidden" name="submit" value="" id="nf_sub" />
				<input type="submit" class="basicBtn" value="{#RUBRIK_BUTTON_PERM#}" onclick="document.getElementById('nf_sub').value='saveperms'" />
			</td>
		</tr>
		</tbody>
	</table>
</form>
</div></div>

{/if}