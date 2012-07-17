<script type="text/javascript" language="JavaScript">
function check_name() {ldelim}
	if (document.getElementById('contact_field_title').value == '') {ldelim}
		jAlert("{#CONTACT_ENTER_NAME#}","{#CONTACT_NEW_FILED_ADD#}");
		document.getElementById('contact_field_title').focus();
		return false;
	{rdelim}
	return true;
{rdelim}
</script>

<script type="text/javascript" language="JavaScript">
$(document).ready(function(){ldelim}

		$(".AddForm").click( function(e) {ldelim}
			e.preventDefault();
			var user_group = $('#add_form #contact_form_title').fieldValue();
			var title = '{#CONTACT_CREATE_FORM#}';
			var text = '{#CONTACT_FORM_NAME_C#}';
			if (user_group == ""){ldelim}
				jAlert(text,title);
			{rdelim}else{ldelim}
				$.alerts._overlay('show');
				$("#add_form").submit();
			{rdelim}
		{rdelim});

{rdelim});
</script>

<div class="title"><h5>{if $smarty.request.moduleaction=='new'}{#CONTACT_CREATE_FORM2#}{else}{#CONTACT_FORM_FIELDS#}{/if}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#CONTACT_FIELD_INFO#}
    </div>
</div>

<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><a href="index.php?do=modules&action=modedit&mod=contact&moduleaction=1&cp={$sess}">{#CONTACT_MODULE_NAME#}</a></li>
	        <li>{if $smarty.request.moduleaction=='new'}{#CONTACT_CREATE_FORM2#}{else}{#CONTACT_FORM_FIELDS#}{/if}</li>
	        <li><strong class="code">{if $smarty.request.moduleaction=='new'}{#CONTACT_CREATE_FORM2#}{else}{$row->contact_form_title}{/if}</strong></li>
	    </ul>
	</div>
</div>

<form method="post" action="{$formaction}" class="mainForm" id="add_form">

	<div class="widget first">
	<div class="head"><h5 class="iFrames">{#CONTACT_FORM_FIELDS#}</h5></div>

	{include file="$include_path/admin_formsettings.tpl"}

	{if $smarty.request.id != '' && $items}
		</div>
		<div class="widget first">
		<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
			<thead>
			<tr>
				<td width="1%" align="center"><div align="center"><span class="icon_sprite ico_delete"></span></div></td>
				<td align="center">{#CONTACT_FILED_NAME#}</td>
				<td align="center">{#CONTACT_FIELD_TYPE#}</td>
				<td align="center">{#CONTACT_FIELD_POSITION#}</td>
				<td align="center">{#CONTACT_FIELD_SIZE#}</td>
				<td align="center">{#CONTACT_DATA_TYPE#}</td>
				<td align="center">{#CONTACT_MAX_CHARS#}</td>
				<td align="center">{#CONTACT_REQUIRED_FIELD#}</td>
				<td>{#CONTACT_FIELD_ACTIVE#}</td>
			</tr>
			<tr>
				<td colspan="3" align="center">{#CONTACT_DEFAULT_VALUE#}</td>
				<td colspan="2" align="center">{#CONTACT_NEW_LINE#}</td>
				<td colspan="3" align="center">{#CONTACT_REG_STRING#}</td>
				<td align="center"></td>
			</tr>
			</thead>
			<tbody>
			{foreach from=$items item=item}
			<tr>
				<td width="1%" rowspan="2" align="center"><input title="{#CONTACT_MARK_DELETE#}" name="del[{$item->Id}]" type="checkbox" id="del[{$item->Id}]" value="1" /></td>
				<td><input placeholder="{#CONTACT_FILED_NAME#}" style="width:200px;" name="contact_field_title[{$item->Id}]" type="text" id="contact_field_title[{$item->Id}]" value="{$item->contact_field_title|escape|stripslashes}" /></td>
				<td>
						<select style="width:200px;" name="contact_field_type[{$item->Id}]" id="contact_field_type[{$item->Id}]">
							<option value="title"{if $item->contact_field_type == 'title'} selected{/if}>{#CONTACT_TITLE_FILED#}</option>
							<option value="text"{if $item->contact_field_type == 'text'} selected{/if}>{#CONTACT_TEXT_FILED#}</option>
							<option value="textfield"{if $item->contact_field_type == 'textfield'} selected{/if}>{#CONTACT_MULTI_FIELD#}</option>
							<option value="checkbox"{if $item->contact_field_type == 'checkbox'} selected{/if}>{#CONTACT_CHECKBOX_FIELD#}</option>
							<option value="dropdown"{if $item->contact_field_type == 'dropdown'} selected{/if}>{#CONTACT_DROPDOWN_FIELD#}</option>
							<option value="fileupload"{if $item->contact_field_type == 'fileupload'} selected{/if}>{#CONTACT_UPLOAD_FIELD#}</option>
						</select>
				</td>
				<td><input style="width:65px;" placeholder="{#CONTACT_FIELD_POSITION#}" type="text" name="contact_field_position[{$item->Id}]" id="contact_field_position[{$item->Id}]" size="5" maxlength="3" value="{$item->contact_field_position}" /></td>
				<td><input style="width:65px;" placeholder="{#CONTACT_FIELD_SIZE#}" type="text" name="contact_field_size[{$item->Id}]" id="contact_field_size[{$item->Id}]" size="5" maxlength="4" value="{$item->contact_field_size}" /></td>
				<td>
						<select style="width:150px;" name="contact_field_datatype[{$item->Id}]" id="contact_field_datatype[{$item->Id}]"{if $item->contact_field_type != 'textfield' && $item->contact_field_type != 'text'} disabled{/if}>
							<option value="anysymbol"{if $item->contact_field_datatype == 'anysymbol'} selected{/if}>{#CONTACT_ANY_SYMBOL#}</option>
							<option value="onlydecimal"{if $item->contact_field_datatype == 'onlydecimal'} selected{/if}>{#CONTACT_ONLY_DECIMAL#}</option>
							<option value="onlychars"{if $item->contact_field_datatype == 'onlychars'} selected{/if}>{#CONTACT_ONLY_CHARS#}</option>
						</select>
				</td>
				<td><input style="width:65px;" placeholder="{#CONTACT_MAX_CHARS#}" type="text" name="contact_field_max_chars[{$item->Id}]" id="contact_field_max_chars[{$item->Id}]" size="5" maxlength="20" value="{$item->contact_field_max_chars}"{if $item->contact_field_type != 'textfield' && $item->contact_field_type != 'text'} disabled{/if} /></td>
				<td align="center"><input title="{#CONTACT_REQUIRED_FIELD#}" name="contact_field_required[{$item->Id}]" type="checkbox" id="contact_field_required[{$item->Id}]" value="1" {if $item->contact_field_required!=0} checked{/if} /></td>
				<td align="center" rowspan="2"><input name="contact_field_status[{$item->Id}]" type="checkbox" id="contact_field_status[{$item->Id}]"{if $item->contact_field_status!=0} checked{/if} value="1" /></td>
			</tr>
			<tr>
				<td colspan="2"><input placeholder="{#CONTACT_DEFAULT_VALUE#}" style="width:400px;" type="text" name="contact_field_default[{$item->Id}]" value="{$item->contact_field_default|escape|stripslashes}"{if $item->contact_field_type == 'fileupload'} disabled{/if} /></td>
				<td colspan="2" align="center"><input type="radio" name="contact_field_newline[{$item->Id}]" value="1"{if $item->contact_field_newline==1} checked{/if} /><label>{#CONTACT_YES#}</label> <input type="radio" name="contact_field_newline[{$item->Id}]" value="0"{if $item->contact_field_newline!=1} checked{/if} /><label>{#CONTACT_NO#}</label></td>
				<td colspan="3" align="center"><input placeholder="{#CONTACT_REG_STRING#}" style="width:264px;" type="text" name="contact_field_value[{$item->Id}]" value="{$item->contact_field_value|escape|stripslashes}"{if $item->contact_field_type != 'textfield' && $item->contact_field_type != 'text' && $item->contact_field_required != 1} disabled{/if} /></td>
			</tr>
			<tr>
				<td colspan="9"></td>
			</tr>
			{/foreach}
			</tbody>
		</table>
	{/if}

			<div class="rowElem">
				<input type="submit" class="basicBtn ConfirmSettings AddForm" value="{#CONTACT_BUTTON_SAVE#}" />
			</div>

	</div>
</form>


{if $smarty.request.id != ''}
	<form class="mainForm" method="post" action="index.php?do=modules&action=modedit&mod=contact&moduleaction=save_new&cp={$sess}&id={$smarty.request.id|escape}&pop=1" name="new" onSubmit='return check_name()'>
	<div class="widget first">
	<div class="head"><h5 class="iFrames">{#CONTACT_NEW_FILED_ADD#}</h5></div>
		<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
			<thead>
			<tr>
				<td width="1%" align="center"><div align="center"><span class="icon_sprite ico_delete"></span></div></td>
				<td align="center">{#CONTACT_FILED_NAME#}</td>
				<td align="center">{#CONTACT_FIELD_TYPE#}</td>
				<td align="center">{#CONTACT_FIELD_POSITION#}</td>
				<td align="center">{#CONTACT_FIELD_SIZE#}</td>
				<td align="center">{#CONTACT_DATA_TYPE#}</td>
				<td align="center">{#CONTACT_MAX_CHARS#}</td>
				<td align="center">{#CONTACT_REQUIRED_FIELD#}</td>
				<td>{#CONTACT_FIELD_ACTIVE#}</td>
			</tr>
			<tr>
				<td colspan="3" align="center">{#CONTACT_DEFAULT_VALUE#}</td>
				<td colspan="2" align="center">{#CONTACT_NEW_LINE#}</td>
				<td colspan="3" align="center">{#CONTACT_REG_STRING#}</td>
				<td align="center"></td>
			</tr>
			</thead>
			<tbody>

			<tr>
				<td width="1%" rowspan="2" align="center"></td>
				<td><input placeholder="{#CONTACT_FILED_NAME#}" style="width:200px;" name="contact_field_title" type="text" id="contact_field_title" value="" /></td>
				<td>
						<select style="width:200px;" name="contact_field_type" id="contact_field_type">
							<option value="title">{#CONTACT_TITLE_FILED#}</option>
							<option value="text">{#CONTACT_TEXT_FILED#}</option>
							<option value="textfield">{#CONTACT_MULTI_FIELD#}</option>
							<option value="checkbox">{#CONTACT_CHECKBOX_FIELD#}</option>
							<option value="dropdown">{#CONTACT_DROPDOWN_FIELD#}</option>
							<option value="fileupload">{#CONTACT_UPLOAD_FIELD#}</option>
						</select>
				</td>
				<td><input style="width:65px;" placeholder="{#CONTACT_FIELD_POSITION#}" type="text" name="contact_field_position" id="contact_field_position" size="5" maxlength="3" value="" /></td>
				<td><input style="width:65px;" placeholder="{#CONTACT_FIELD_SIZE#}" type="text" name="contact_field_size" id="contact_field_size" size="5" maxlength="4" value="" /></td>
				<td>
						<select style="width:150px;" name="contact_field_datatype" id="contact_field_datatype">
							<option value="anysymbol">{#CONTACT_ANY_SYMBOL#}</option>
							<option value="onlydecimal">{#CONTACT_ONLY_DECIMAL#}</option>
							<option value="onlychars">{#CONTACT_ONLY_CHARS#}</option>
						</select>
				</td>
				<td><input style="width:65px;" placeholder="{#CONTACT_MAX_CHARS#}" type="text" name="contact_field_max_chars" id="contact_field_max_chars" size="5" maxlength="20" value="" /></td>
				<td align="center"><input title="{#CONTACT_REQUIRED_FIELD#}" name="contact_field_required" type="checkbox" id="contact_field_required" value="1" /></td>
				<td align="center" rowspan="2"><input name="contact_field_status" type="checkbox" id="contact_field_status" value="1" /></td>
			</tr>
			<tr>
				<td colspan="2"><input placeholder="{#CONTACT_DEFAULT_VALUE#}" style="width:400px;" type="text" name="contact_field_default" value="" /></td>
				<td colspan="2" align="center"><input type="radio" name="contact_field_newline" value="1" /><label>{#CONTACT_YES#}</label> <input type="radio" name="contact_field_newline" value="0" /><label>{#CONTACT_NO#}</label></td>
				<td colspan="3" align="center"><input placeholder="{#CONTACT_REG_STRING#}" style="width:264px;" type="text" name="contact_field_value" value="" /></td>
			</tr>

		</tbody>
		</table>

			<div class="rowElem">
				<input type="submit" class="basicBtn ConfirmSettings" value="{#CONTACT_BUTTON_ADD#}" />
				<div class="fix"></div>
			</div>

		</div>
	</form>
{/if}