<script type="text/javascript" language="JavaScript">
function check_title() {ldelim}
	if (document.getElementById('new_faq_title').value == '') {ldelim}
		alert('{#FAQ_ENTER_NAME#}');
		document.getElementById('new_faq_title').focus();
		return false;
	{rdelim}
	return true;
{rdelim}
</script>


<div class="title"><h5>{#FAQ_LIST#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#FAQ_LIST_TIP#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li>{#FAQ_LIST#}</li>
	    </ul>
	</div>
</div>

<div class="widget first">

	<ul class="tabs">
	    <li class="activeTab"><a href="#tab1">Список рубрик</a></li>
	    <li class=""><a href="#tab2">{#FAQ_ADD#}</a></li>
	</ul>

	<div class="tab_container">

	<div id="tab1" class="tab_content" style="display: block;">
	<form method="post" action="index.php?do=modules&action=modedit&mod=faq&moduleaction=save&cp={$sess}">
		<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
			<col />
			<col />
			<col width="100" />
			<col width="10" />
			<col width="10" />
			<thead>
			<tr>
				<td>{#FAQ_NAME#}</td>
				<td>{#FAQ_DESC#}</td>
				<td>{#FAQ_TAG#}</td>
				<td colspan="2">{#FAQ_ACTIONS#}</td>
			</tr>
			</thead>
			<tbody>
			{foreach from=$faq_arr item=faq}
				<tr>
					<td>
						<div class="pr12"><input style="width:100%" name="faq_title[{$faq->id}]" type="text" id="faq_title[{$faq->id}]" value="{$faq->faq_title|escape}" size="40" /></div>
					</td>

					<td>
						<div class="pr12"><input style="width:100%" name="faq_description[{$faq->id}]" type="text" id="faq_description[{$faq->id}]" value="{$faq->faq_description|escape}" size="40" /></div>
					</td>

					<td>
						<div class="pr12"><input style="width:100%" name="textfield" type="text" value="[mod_faq:{$faq->id}]" readonly /></div>
					</td>

					<td align="center">
						<a class="topleftDir icon_sprite ico_edit" title="{#FAQ_EDIT_HINT#}" href="index.php?do=modules&action=modedit&mod=faq&moduleaction=questlist&fid={$faq->id}&cp={$sess}"></a>
					</td>

					<td align="center">
						<a class="topleftDir ConfirmDelete icon_sprite ico_delete" title="{#FAQ_DELETE_HINT#}" href="index.php?do=modules&action=modedit&mod=faq&moduleaction=del&fid={$faq->id}&cp={$sess}"></a>
					</td>
				</tr>
			{/foreach}
			</tbody>
			<tr>
				<td colspan="5" class="third"><input type="submit" class="basicBtn" value="{#FAQ_BUTTON_SAVE#}" /></td>
			</tr>
		</table>
	</form>
	</div>


{if !$faq_arr}
	<h4 style="color:#800">{#FAQ_NO_ITEMS#}</h4>
{/if}

	<div id="tab2" class="tab_content" style="display: none;">
	<form action="index.php?do=modules&action=modedit&mod=faq&moduleaction=new&cp={$sess}" method="post" onSubmit="return check_title();">
		<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
			<thead>
			<tr>
				<td class="tableheader">{#FAQ_NAME#}</td>
				<td class="tableheader">{#FAQ_DESC#}</td>
			</tr>
			</thead>

			<tr>
				<td class="second"><div class="pr12"><input placeholder="{#FAQ_NAME#}" name="new_faq_title" type="text" id="new_faq_title" size="60" maxlength="100" style="width:100%" /></div></td>
				<td class="second"><div class="pr12"><input placeholder="{#FAQ_DESC#}" name="new_faq_desc" type="text" id="new_faq_desc" size="60" maxlength="255" style="width:100%" /></div></td>
			</tr>
			<tr>
				<td colspan="2" class="third"><input name="submit" type="submit" class="basicBtn" value="{#FAQ_BUTTON_ADD#}" /></td>
			</tr>
		</table>
	</form>
	</div>
	</div>
	<div class="fix"></div>
</div>