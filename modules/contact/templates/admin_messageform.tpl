<div class="widget first"></div>

<div class="title"><h5>{#CONTACT_SHOW_ANSWER2#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
	{if $smarty.request.reply=='no'}
		{#CONTACT_MODULE_TIP#} {#CONTACT_ALLREADY_REPLIED#}
	{else}
		{#CONTACT_MODULE_TIP#}
	{/if}
    </div>
</div>

<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><a href="index.php?do=modules&action=modedit&mod=contact&moduleaction=1&cp={$sess}">{#CONTACT_MODULE_NAME#}</a></li>
	        <li>{if $smarty.request.moduleaction=='new'}{#CONTACT_CREATE_FORM2#}{else}{#CONTACT_FORM_FIELDS#}{/if}</li>
	        <li><strong class="code">{#CONTACT_AUTHOR#}{$row->contact_form_in_email} ({$row->contact_form_in_date|date_format:$TIME_FORMAT|pretty_date})</strong></li>
	    </ul>
	</div>
</div>


<form name="replay" enctype="multipart/form-data" method="post" action="index.php?do=modules&action=modedit&mod=contact&moduleaction=reply&cp={$sess}&id={$smarty.request.id|escape}&pop=1" class="mainForm">


<div class="widget first">
<div class="head"><h5 class="iFrames">{#CONTACT_AUTHOR#}{$row->contact_form_in_email} ({$row->contact_form_in_date|date_format:$TIME_FORMAT|pretty_date})</h5></div>
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">

		<tr>
			<td colspan="2"><textarea readonly style="width:98%;height:200px">{$row->contact_form_in_message}</textarea></td>
		</tr>

		{if $attachments}
			<tr>
				<td colspan="2"><strong>{#CONTACT_ATTACHMENTS#}</strong>
					{foreach name=am from=$attachments item=att}
						<img class="absmiddle" src="{$tpl_dir}/images/attachment.gif" alt="" />
						<a href="index.php?do=modules&action=modedit&mod=contact&moduleaction=get_attachment&cp={$sess}&file={$att->name}&pop=1">{$att->name}</a> ({$att->size} {#CONTACT_FILE_SIZE#}){if !$smarty.foreach.am.last}, {/if}
					{/foreach}
				</td>
			</tr>
		{/if}

		</table>
</div>

<div class="widget first">
<div class="head"><h5 class="iFrames">{#CONTACT_YOUR_REPLY#}</h5></div>
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">

		<tr>
			<td>{#CONTACT_RECIVER_EMAIL#}</td>
			<td><input name="to" type="text" id="to" value="{$row->contact_form_in_email}" size="50" /></td>
		</tr>

		<tr>
			<td width="150">{#CONTACT_SUJECT_EMAIL#}</td>
			<td><input name="subject" type="text" id="subject" value="RE:{$row->contact_form_in_subject|escape|stripslashes}" size="50" /></td>
		</tr>

		<tr>
			<td width="150">{#CONTACT_REPLY_NAME#}</td>
			<td><input name="fromname" type="text" id="fromname" value="{$smarty.session.user_name|escape}" size="50" /></td>
		</tr>

		<tr>
			<td width="150">{#CONTACT_REPLY_EMAIL#}</td>
			<td><input name="fromemail" type="text" id="fromemail" value="{$smarty.session.user_email|escape}" size="50" /></td>
		</tr>

		<tr>
			<td width="150">{#CONTACT_REPLY_MESSAGE#}</td>
			<td>
				<textarea name="message" id="message" style="width:98%;height:200px">
      {#CONTACT_MESSAGE_HEADER#}
      {#CONTACT_MESSAGE_YOUR_TEXT#}
      {#CONTACT_YOUR_INFO#}{$smarty.session.user_name|escape}
---------------------------------------------------
---------------------------------------------------
{#CONTACT_YOUR_DATE#} {$row->contact_form_in_date|date_format:$TIME_FORMAT|pretty_date}

{$row->replytext}
				</textarea>
			</td>
		</tr>

		{section name=atta loop=3}
			<tr>
				<td>{#CONTACT_ATTACHMENT#}</td>
				<td><input type="file" name="upfile[]" class="fileInput" id="upfile[]" /></td>
			</tr>
		{/section}

			<tr>
				<td colspan="2">
				<input type="submit" value="{#CONTACT_BUTTON_SEND#}" class="basicBtn" />&nbsp;
				<input type="button" class="blackBtn" value="{#CONTACT_BUTTON_CLOSE#}" onclick="self.close();" />
				</td>
			</tr>

	</table>



</div>
</form>

