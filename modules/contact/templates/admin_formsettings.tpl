<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
	<tr class="noborder">
		<td width="1%"><a class="toprightDir icon_sprite ico_info" title="{#CONTACT_FORM_TITEL#}" href="#"></a></td>
		<td width="250">{#CONTACT_FORM_NAME2#}</td>
		<td><div class="pr12"><input name="contact_form_title" type="text" id="contact_form_title" placeholder="{#CONTACT_FORM_NAME#}" value="{$row->contact_form_title}" size="50" style="width: 500px;" /></div></td>
	</tr>

	<tr>
		<td width="1%"><a class="toprightDir icon_sprite ico_info" title="{#CONTACT_MAX_CHARS_EMAIL_TIP#}" href="#"></a></td>
		<td width="250">{#CONTACT_MAX_CHARS_EMAIL#}</td>
		<td><div class="pr12"><input name="contact_form_mail_max_chars" type="text" id="contact_form_mail_max_chars" value="{$row->contact_form_mail_max_chars|default:20000}" size="10" maxlength="10" style="width: 60px;" /></div></td>
	</tr>

	<tr>
		<td width="1%"><a class="toprightDir icon_sprite ico_info" title="{#CONTACT_DEFAULT_EMAIL#}" href="#"></a></td>
		<td width="250">{#CONTACT_DEFAULT_RECIVER#}</td>
		<td><div class="pr12"><input name="contact_form_reciever" type="text" id="contact_form_reciever" value="{$row->contact_form_reciever}" placeholder="{#CONTACT_DEFAULT_RECIVER#}" size="50" style="width: 300px;" /></div></td>
	</tr>

	<tr>
		<td width="1%"><a class="toprightDir icon_sprite ico_info" title="{#CONTACT_MULTI_LIST#}" href="#"></a></td>
		<td width="250">{#CONTACT_MULTI_LIST_FIELD#}</td>
		<td><div class="pr12"><input name="contact_form_reciever_multi" type="text" id="contact_form_reciever_multi" value="{$row->contact_form_reciever_multi}" placeholder="{#CONTACT_MULTI_LIST_FIELD#}" style="width: 300px;" /></div></td>
	</tr>

	<tr>
		<td width="1%"><a class="toprightDir icon_sprite ico_info" title="{#CONTACT_SCODE_INFO#}" href="#"></a></td>
		<td width="250">{#COUNACT_USE_SCODE_FIELD#}</td>
		<td><input type="radio" name="contact_form_antispam" value="1" {if $row->contact_form_antispam==1}checked{/if} /><label>{#CONTACT_YES#}</label>&nbsp;<input type="radio" name="contact_form_antispam" value="0" {if $row->contact_form_antispam!=1}checked{/if} /><label>{#CONTACT_NO#}</label></td>
	</tr>

	<tr>
		<td><a class="toprightDir icon_sprite ico_info" title="{#CONTACT_MAX_SIZE_INFO#}" href="#"></a></td>
		<td width="250">{#CONTACT_MAX_UPLOAD_FIELD#}</td>
		<td><div class="pr12"><input name="contact_form_max_upload" type="text" id="contact_form_max_upload" value="{$row->contact_form_max_upload|default:120}" size="10" maxlength="5" style="width: 60px;" /></div></td>
	</tr>

	<tr>
		<td><a class="toprightDir icon_sprite ico_info" title="{#CONTACT_SUBJECT_FIELD_INFO#}" href="#"></a></td>
		<td width="250">{#CONTACT_USE_SUBJECT_FIELD#}</td>
		<td><input type="radio" name="contact_form_subject_show" value="1" {if $row->contact_form_subject_show==1}checked{/if} /><label>{#CONTACT_YES#}</label>&nbsp;<input type="radio" name="contact_form_subject_show" value="0" {if $row->contact_form_subject_show!=1}checked{/if} /><label>{#CONTACT_NO#}</label></td>
	</tr>

	<tr>
		<td><a class="toprightDir icon_sprite ico_info" title="{#CONTACT_DEFAULT_SUBJ_INFO#}" href="#"></a></td>
		<td width="250">{#CONTACT_DEFAULT_SUBJECT#}</td>
		<td><div class="pr12"><input name="contact_form_subject_default" type="text" id="contact_form_subject_default" value="{$row->contact_form_subject_default|stripslashes|escape}" placeholder="{#CONTACT_DEFAULT_SUBJECT#}" style="width: 500px;" size="50" /></div></td>
	</tr>

	<tr>
		<td>&nbsp;</td>
		<td>{#CONTACT_USE_COPY_FIELD#}</td>
		<td><input type="radio" name="contact_form_send_copy" value="1" {if $row->contact_form_send_copy==1}checked{/if} /><label>{#CONTACT_YES#}</label>&nbsp;<input type="radio" name="contact_form_send_copy" value="0" {if $row->contact_form_send_copy!=1}checked{/if} /><label>{#CONTACT_NO#}</label></td>
	</tr>

	<tr>
		<td>&nbsp;</td>
		<td width="200" valign="top">{#CONTACT_PERMISSIONS_FIELD#}<br /><small>{#CONTACT_GROUPS_INFO#}</small></td>
		<td>
			<select style="width:200px" name="contact_form_allow_group[]" size="5" multiple="multiple">
				{foreach from=$groups item=group}
					<option value="{$group->user_group}" {if @in_array($group->user_group, $groups_form) || $smarty.request.moduleaction=="new"}selected="selected"{/if}>{$group->user_group_name|escape}</option>
				{/foreach}
			</select>
		</td>
	</tr>

	<tr>
		<td>&nbsp;</td>
		<td width="200" valign="top">{#CONTACT_TEXT_NO_PERMISSION#}</td>
		<td><textarea style="width:500px; height:100px" name="contact_form_message_noaccess" id="contact_form_message_noaccess">{$row->contact_form_message_noaccess|escape|stripslashes}</textarea></td>
	</tr>
</table>