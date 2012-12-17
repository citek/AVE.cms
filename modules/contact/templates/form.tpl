<div id="module_contact">
{if $no_access}
	<h3 class="message_info">{$contact_form_message_noaccess|default:#CONTACT_NO_ACCESS#|escape}</h3>
{else}

	<script language="javascript" type="text/javascript">
		function checkForm(obj, elems) {ldelim}
			var element, pattern;
			for (var i = 0; i < obj.elements.length; i++) {ldelim}
				element = obj.elements[i];
				if (elems != undefined)
					if (elems.join().indexOf(element.type) < 0) continue;
				if (!element.getAttribute("check_message")) continue;
				if (pattern = element.getAttribute("check_pattern")) {ldelim}
					pattern = new RegExp(pattern, "g");
					if (!pattern.test(element.value)) {ldelim}
						alert(element.getAttribute("check_message"));
						element.focus();
						return false;
					{rdelim}
				{rdelim}
				else if (/^\s*$/.test(element.value)) {ldelim}
					alert(element.getAttribute("check_message"));
					element.focus();
					return false;
				{rdelim}
			{rdelim}
			return true;
		{rdelim}
	</script>
	<p class="info">{#CONTACT_REQUIRED_INFO#}</p>
	<form method="post" enctype="multipart/form-data" onSubmit='return checkForm(this)'>
		{if $wrong_securecode}
		<h3 class="message_info">{#CONTACT_WRONG_CODE#}</h3>
		{/if}

		<label for="contact_form_in_email">{#CONTACT_FORM_EMAIL#} <span class="star">*</span></label>
		<input type="text" value="{$smarty.request.contact_form_in_email|default:$smarty.session.user_email|stripslashes|escape}" name="contact_form_in_email" id="contact_form_in_email" {literal}check_pattern="^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$"{/literal} check_message="{#CONTACT_CHECK_EMAIL#}" class="default" />

		{if $recievers}
		<label for="reciever">{#CONTACT_FORM_RECIVER#}</label>
		{html_options name=reciever options=$recievers id="reciever"}
		{/if}

		{if $default_subject}
		<input type="hidden" value="{$default_subject}" id="contact_form_in_subject" name="contact_form_in_subject" />
        {else}
		<label for="contact_form_in_subject">{#CONTACT_FORM_SUBJECT#} <span class="star">*</span></label>
		<input type="text" value="{$smarty.request.contact_form_in_subject|stripslashes|escape}" name="contact_form_in_subject" id="contact_form_in_subject" class="default" check_message="{#CONTACT_CHECK_TITLE#}" />
		{/if}

		{foreach from=$fields item=field}
		<label for="cp_{$field->Id}">{$field->contact_field_title|escape}: {if $field->contact_field_required == '1'}<span class="star">*</span>{/if}</label>

		{if $field->contact_field_type == 'textfield'}
		<textarea name="{$field->contact_field_title|escape|replace:' ':'_'}" id="cp_{$field->Id}"{if !empty($field->field_pattern)} check_pattern="{$field->field_pattern}"{/if}{if !empty($field->field_pattern) || $field->contact_field_required == 1} check_message="{$field->contact_field_value|escape}"{/if}>{$field->value|escape}</textarea>

		{elseif $field->contact_field_type == 'text'}
		<input type="text" name="{$field->contact_field_title|escape|replace:' ':'_'}" class="default" id="cp_{$field->Id}" value="{$field->value|default:$field->contact_field_default|escape}"{if !empty($field->field_pattern)} check_pattern="{$field->field_pattern}"{/if}{if !empty($field->field_pattern) || $field->contact_field_required == 1} check_message="{$field->contact_field_value|escape}"{/if} />

		{elseif $field->contact_field_type == 'checkbox'}
		<input type="checkbox" name="{$field->contact_field_title|escape|replace:' ':'_'}" id="cp_{$field->Id}" value="{$field->contact_field_default|escape|default:'1'}"{if $field->contact_field_required == 1} check_message="{$field->contact_field_value|escape}"{/if} /> <span class="checkbox_info">{$field->contact_field_default|escape}</span>

		{elseif $field->contact_field_type == 'fileupload'}
		<input name="upfile[]" type="file"{if $field->contact_field_required == 1} check_message="{$field->contact_field_value|escape}"{/if} />
		{if $field->contact_field_type == 'fileupload' && $maxupload >= 1}
		<span class="maxupload">{#CONTACT_FORM_MAX_FILE#} {$maxupload} {#CONTACT_FILE_KB#}</span>
		{/if}

		{elseif $field->contact_field_type == 'dropdown'}
		<select id="cp_{$field->Id}" name="{$field->contact_field_title|escape|replace:' ':'_'}"{if $field->contact_field_required == 1} check_message="{$field->contact_field_value|escape}"{/if}>
			<option></option>
			{foreach from=$field->contact_field_default item=v}
			<option value="{$v}"{if $v == $field->value} selected{/if}>{$v}</option>
			{/foreach}
		</select>
		{/if}
		{/foreach}

		{if $send_copy}
		<label for="input_sendcopy">{#CONTACT_SEND_COPY#}</label>
		<input name="sendcopy" type="checkbox" id="input_sendcopy" value="1" />
		{/if}

		{if $im}
		<div class="clear"></div>
		<label for="secureimg">{#CONTACT_FORM_CODE#}</label>
		<img id="secureimg" src="{$ABS_PATH}inc/captcha.php" alt="" />

		<label for="securecode">{#CONTACT_FORM_CODE_ENTER#}</label>
		<input name="securecode" type="text" id="securecode" check_message="{#CONTACT_CHECK_CODE#}" />
		{/if}

		<input type="hidden" name="contact_form_id" value="{$contact_form_id}" />
		<input type="hidden" name="contact_action" value="DoPost" />
		<input type="hidden" name="modules" value="contact" />
		<div class="buttons">
			<input type="submit" value="{#CONTACT_BUTTON_SEND#}" />
			<input type="reset" value="{#CONTACT_BUTTON_CLEAN#}" />
		</div>
	</form>

{/if}
</div>