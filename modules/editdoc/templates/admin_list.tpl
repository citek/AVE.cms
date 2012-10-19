<script type="text/javascript" language="JavaScript">
$(document).ready(function(){ldelim}

		$(".AddEditDoc").click( function(e) {ldelim}
			e.preventDefault();
			var user_group = $('#add_editdoc #editdoc_name').fieldValue();
			var title = '{#EDITDOC_ADD#}';
			var text = '{#EDITDOC_INNAME#}';
			if (user_group == ""){ldelim}
				jAlert(text,title);
			{rdelim}else{ldelim}
				$.alerts._overlay('show');
				$("#add_editdoc").submit();
			{rdelim}
		{rdelim});

{rdelim});
</script>

<div class="title"><h5>{#EDITDOC_EDIT#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#EDITDOC_EDIT_TIP#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li>{#EDITDOC_EDIT#}</li>
	    </ul>
	</div>
</div>


<div class="widget first">
	<ul class="tabs">
	    <li class="activeTab"><a href="#tab1">{#EDITDOC_EDIT#}</a></li>
	    <li class=""><a href="#tab2">{#EDITDOC_ADD#}</a></li>
	</ul>

		<div class="tab_container">
			<div id="tab1" class="tab_content" style="display: block;">

			<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
				<col width="20">
				<col>
				<col width="150">
				<col width="20">
				<col width="20">
				<thead>
					<tr>
						<td>{#EDITDOC_ID#}</td>
						<td>{#EDITDOC_NAME#}</td>
						<td>{#EDITDOC_TAG#}</td>
						<td colspan="2">{#EDITDOC_ACTIONS#}</td>
					</tr>
				</thead>

				<tbody>
				{if $editdocs}

				{foreach from=$editdocs item=editdoc}
					<tr>
						<td>{$editdoc->id}</td>
						<td>
							<a class="topDir" title="{#EDITDOC_EDIT_HINT#}" href="index.php?do=modules&action=modedit&mod=editdoc&moduleaction=edit&cp={$sess}&id={$editdoc->id}"><strong>{$editdoc->editdoc_name|escape}</a></strong>
								<br />
								<span class="date_text dgrey">
								{foreach from=$rubs item=rub}
									{if $rub->Id==$editdoc->editdoc_rub}
										({$rub->rubric_title})
									{/if}
								{/foreach}
								</span>
						</td>
						<td>
							<div class="pr12"><input name="textfield" type="text" readonly style="width: 150px;" value="[mod_editdoc:{$editdoc->id}]"  /></div>
						</td>
						</td>
						<td align="center">
							<a class="topleftDir icon_sprite ico_edit" title="{#EDITDOC_EDIT_HINT#}" href="index.php?do=modules&action=modedit&mod=editdoc&moduleaction=edit&cp={$sess}&id={$editdoc->id}"></a>
						</td>
						<td align="center">
							<a class="topleftDir ConfirmDelete icon_sprite ico_delete" title="{#EDITDOC_DELETE_HINT#}" dir="{#EDITDOC_DELETE_HINT#}" name="{#EDITDOC_DEL_HINT#}" href="index.php?do=modules&action=modedit&mod=editdoc&moduleaction=del&cp={$sess}&id={$editdoc->id}"></a>
						</td>
					</tr>
				{/foreach}

				{else}
					<tr>
						<td colspan="9">
							<ul class="messages">
								<li class="highlight yellow">{#EDITDOC_NO_ITEMS#}</li>
							</ul>
						</td>
					</tr>
				{/if}
				</tbody>
			</table>

		</div>

			<div id="tab2" class="tab_content" style="display: none;">
					<form id="add_editdoc" method="post" action="index.php?do=modules&action=modedit&mod=editdoc&moduleaction=new&cp={$sess}" class="mainForm">
					<div class="rowElem">
						<label>{#EDITDOC_NAME#}</label>
						<div class="formRight"><input name="editdoc_name" type="text" id="editdoc_name" value="" placeholder="{#EDITDOC_NAME#}" style="width: 400px">
						&nbsp;<input type="button" class="basicBtn AddEditDoc" value="{#EDITDOC_BUTTON_ADD#}" />
						</div>
						<div class="fix"></div>
					</div>
					</form>
			</div>
		</div>
	<div class="fix"></div>
</div>