<script type="text/javascript" language="JavaScript">
$(document).ready(function(){ldelim}

    $(".ConfirmDelete").click(function(e){ldelim}
		e.preventDefault();
		var href = $(this).attr('href');
		var title = $(this).attr('name');
		var confirm = $(this).attr('dir');
		jConfirm(
				confirm,
				title,
				function(b){ldelim}
					if (b){ldelim}
						$.alerts._overlay('show');
						window.location = href;
					{rdelim}
				{rdelim}
			);
	{rdelim});

{rdelim});
</script>
<div class="title"><h5>{#CONTACT_MODULE_NAME#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#CONTACT_MODULE_INFO#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li>{#CONTACT_MODULE#}</li>
	        <li><strong class="code">{#CONTACT_MODULE_NAME#}</strong></li>
	    </ul>
	</div>
</div>

<div class="widget first">
<div class="head">
<h5 class="iFrames">{#CONTACT_MODULE_NAME#}</h5>
<div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=contact&moduleaction=new&cp={$sess}">{#CONTACT_CREATE_FORM#}</a></div>
</div>

<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
	<thead>
	<tr>
		<td>{#CONTACT_FORM_NAME#} </td>
		<td width="150">{#CONTACT_SYSTEM_TAG#}</td>
		<td width="300">{#CONTACT_MESSAGES#}</td>
		<td colspan="2">{#CONTACT_ACTIONS#}</td>
	</tr>
	</thead>
	<tbody>
	{foreach from=$items item=item}
		<tr>
			<td>
				<a class="topDir" href="index.php?do=modules&action=modedit&mod=contact&moduleaction=edit&cp={$sess}&id={$item->Id}" title="{#CONTACT_EDIT_FORM#}"><strong>{$item->contact_form_title|stripslashes|escape}</strong></a>
			</td>

			<td>
				<input type="text" value="[mod_contact:{$item->Id}]" size="20" readonly style="width: 100px;">
			</td>

			<td align="center">
				<a href="index.php?do=modules&action=modedit&mod=contact&moduleaction=showmessages_new&cp={$sess}&id={$item->Id}">{#CONTACT_NO_ANSWERED#}{$item->messages}</a> |
				<a href="index.php?do=modules&action=modedit&mod=contact&moduleaction=showmessages_old&cp={$sess}&id={$item->Id}">{#CONTACT_ANSWERED#}{$item->messages_new}</a>
			</td>

			<td width="1%" align="center">
				<a class="topleftDir icon_sprite ico_edit" title="{#CONTACT_EDIT_FORM#}" href="index.php?do=modules&action=modedit&mod=contact&moduleaction=edit&cp={$sess}&id={$item->Id}"></a>
			</td>

			<td width="1%" align="center">
				<a class="topleftDir ConfirmDelete icon_sprite ico_delete" dir="{#CONTACT_DELETE_CONFIRM#}" name="{#CONTACT_DELETE_FORM#}" title="{#CONTACT_DELETE_FORM#}" href="index.php?do=modules&action=modedit&mod=contact&moduleaction=delete&cp={$sess}&id={$item->Id}"></a>
			</td>
		</tr>
	{/foreach}
	{if ! $items}
		<tr>
			<td colspan="8">
				<ul class="messages">
					<li class="highlight yellow">{#CONTACT_NO_ITEMS#}</li>
				</ul>
			</td>
		</tr>
	{/if}
	</tbody>
</table>

</div>


{if $page_nav}
	<div class="pagination">
	<ul class="pages">
		{$page_nav}
	</ul>
	</div>
{/if}