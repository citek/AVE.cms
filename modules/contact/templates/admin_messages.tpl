<div class="title"><h5>{if $smarty.request.moduleaction == 'showmessages_new'}{#CONTACT_TITLE_NOANSWERED#}{else}{#CONTACT_TITLE_ANSWERED#}{/if}</h5></div>

<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><a href="index.php?do=modules&action=modedit&mod=contact&moduleaction=1&cp={$sess}">{#CONTACT_MODULE_NAME#}</a></li>
	        <li><strong class="code">{if $smarty.request.moduleaction == 'showmessages_new'}{#CONTACT_TITLE_NOANSWERED#}{else}{#CONTACT_TITLE_ANSWERED#}{/if}</strong></li>
	    </ul>
	</div>
</div>

	<div class="widget first">
	<div class="head"><h5 class="iFrames">{if $smarty.request.moduleaction == 'showmessages_new'}{#CONTACT_TITLE_NOANSWERED#}{else}{#CONTACT_TITLE_ANSWERED#}{/if}</h5></div>

<form method="post" action="index.php?do=modules&action=modedit&mod=contact&moduleaction=del_attachment&cp={$sess}">
		<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
		<thead>
		<tr>
			<td align="center" width="1%"><span class="icon_sprite ico_delete"></span></td>
			<td>{#CONTACT_MESSAGE_SUBJECT#} </td>
			<td>{#CONTACT_FROM_NAME#}</td>
			<td>{#CONTACT_SEND_TIME#}</td>
			<td>{#CONTACT_ANSWER_TIME#}</td>
			<td>{#CONTACT_ACTIONS#}</td>
		</tr>
		</thead>
		{foreach from=$items item=item}
			<tr>
				<td><input title="{#CONTACT_MARK_DELETE#}" name="del[{$item->Id}]" type="checkbox" id="del[{$item->Id}]" value="1" /></td>
				<td><a href="javascript:void(0);" onclick="cp_pop('index.php?do=modules&action=modedit&mod=contact&moduleaction=showmessages_new&sub=view&cp={$sess}&id={$item->Id}&pop=1','','','1','modcontactedit');"><strong>{$item->contact_form_in_subject|stripslashes|escape:html|truncate:30}</strong></a></td>
				<td><a href="mailto:{$item->contact_form_in_email}">{$item->contact_form_in_email}</a></td>
				<td>{$item->contact_form_in_date|date_format:$DATE_FORMAT|pretty_date}</td>
				<td>
					{if $smarty.request.moduleaction=='showmessages_new'}
						-
					{else}
						{$item->contact_form_out_date|date_format:$DATE_FORMAT|pretty_date}
					{/if}
				</td>
				<td width="1%" align="center">
					{if $smarty.request.moduleaction=='showmessages_new'}
						<a title="{#CONTACT_SHOW_ANSWER#}" href="javascript:void(0);" onclick="cp_pop('index.php?do=modules&action=modedit&mod=contact&moduleaction=showmessages_new&sub=view&cp={$sess}&id={$item->Id}&pop=1','','','1','modcontactedit');"><img src="{$tpl_dir}/images/icon_edit.gif" alt="" border="0" /></a>
					{else}
						<a title="{#CONTACT_SHOW_ANSWER#}" href="javascript:void(0);" onclick="cp_pop('index.php?do=modules&action=modedit&mod=contact&moduleaction=showmessages_new&sub=view&cp={$sess}&id={$item->Id}&pop=1&reply=no','','','1','modcontactedit');"><img src="{$tpl_dir}/images/icon_edit.gif" alt="" border="0" /></a>
					{/if}
				</td>
			</tr>
		{/foreach}
			{if $items}
			<tr>
				<td colspan="8">
					<input type="submit" class="basicBtn" value="{#CONTACT_BUTTON_DELETE#}" />
				</td>
			</tr>
			{else}
				<tr>
					<td colspan="9">
					<ul class="messages">
						<li class="highlight yellow">{#CONTACT_NO_ANSWER_ITEMS#}</li>
					</ul>
					</td>
				</tr>
			{/if}
	</table>


</form>
</div>

{if $page_nav}
	<div class="pagination">
	<ul class="pages">
		{$page_nav}
	</ul>
	</div>
{/if}