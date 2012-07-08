<script type="text/javascript" language="JavaScript">
$(document).ready(function(){ldelim}

		$(".AddSysBlock").click( function(e) {ldelim}
			e.preventDefault();
			var user_group = $('#add_sysblock #sysblock_name').fieldValue();
			var title = '{#SYSBLOCK_ADD#}';
			var text = '{#SYSBLOCK_INNAME#}';
			if (user_group == ""){ldelim}
				jAlert(text,title);
			{rdelim}else{ldelim}
				$.alerts._overlay('show');
				$("#add_sysblock").submit();
			{rdelim}
		{rdelim});

{rdelim});
</script>

<div class="title"><h5>{#SYSBLOCK_EDIT#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#SYSBLOCK_EDIT_TIP#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li>{#SYSBLOCK_EDIT#}</li>
	    </ul>
	</div>
</div>


<div class="widget first">
	<ul class="tabs">
	    <li class="activeTab"><a href="#tab1">{#SYSBLOCK_EDIT#}</a></li>
	    <li class=""><a href="#tab2">{#SYSBLOCK_ADD#}</a></li>
	</ul>

		<div class="tab_container">
			<div id="tab1" class="tab_content" style="display: block;">

<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
		<col width="20">
		<col>
		<col width="100">
		<col width="20">
		<col width="20">
		<thead>
		<tr>
			<td>{#SYSBLOCK_ID#}</td>
			<td>{#SYSBLOCK_NAME#}</td>
			<td>{#SYSBLOCK_TAG#}</td>
			<td colspan="2">{#SYSBLOCK_ACTIONS#}</td>
		</tr>
		</thead>
		<tbody>
		{if $sysblocks}
		{foreach from=$sysblocks item=sysblock}
			<tr>
				<td class="itcen">{$sysblock->id}</td>
				<td>
					<a class="topDir" title="{#SYSBLOCK_EDIT_HINT#}" href="index.php?do=modules&action=modedit&mod=sysblock&moduleaction=edit&cp={$sess}&id={$sysblock->id}">
						<strong>{$sysblock->sysblock_name|escape}</strong>
					</a>
				</td>
				<td>
					<div><input name="textfield" type="text" value="[mod_sysblock:{$sysblock->id}]" readonly style="width: 150px;" /></div>
				</td>
				<td align="center">
					<a class="topleftDir icon_sprite ico_edit" title="{#SYSBLOCK_EDIT_HINT#}" href="index.php?do=modules&action=modedit&mod=sysblock&moduleaction=edit&cp={$sess}&id={$sysblock->id}"></a>
				</td>
				<td align="center">
					<a class="topleftDir ConfirmDelete icon_sprite ico_delete" title="{#SYSBLOCK_DELETE_HINT#}" dir="{#SYSBLOCK_DELETE_HINT#}" name="{#SYSBLOCK_DEL_HINT#}" href="index.php?do=modules&action=modedit&mod=sysblock&moduleaction=del&cp={$sess}&id={$sysblock->id}"></a>
				</td>
			</tr>
		{/foreach}
		{else}
			<tr>
				<td colspan="8">
					<ul class="messages">
						<li class="highlight yellow">{#SYSBLOCK_NO_ITEMS#}</li>
					</ul>
				</td>
			</tr>
		{/if}
	</tbody>
</table>
		</div>

			<div id="tab2" class="tab_content" style="display: none;">
					<form id="add_sysblock" method="post" action="index.php?do=modules&action=modedit&mod=sysblock&moduleaction=edit&cp={$sess}" class="mainForm">
					<div class="rowElem">
						<label>{#SYSBLOCK_NAME#}</label>
						<div class="formRight"><input name="sysblock_name" type="text" id="sysblock_name" value="" placeholder="{#SYSBLOCK_NAME#}" style="width: 400px">
						&nbsp;<input type="button" class="basicBtn AddSysBlock" value="{#SYSBLOCK_ADD_BUTTON#}" />
						</div>
						<div class="fix"></div>
					</div>
					</form>
			</div>
		</div>
	<div class="fix"></div>
</div>

