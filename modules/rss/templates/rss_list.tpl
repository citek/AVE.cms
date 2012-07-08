<script type="text/javascript" language="JavaScript">
$(document).ready(function(){ldelim}

		$(".AddRSS").click( function(e) {ldelim}
			e.preventDefault();
			var user_group = $('#add_rss #new_rss').fieldValue();
			var title = '{#RSS_ADD#}';
			var text = '{#RSS_ENTER_NAME#}';
			if (user_group == ""){ldelim}
				jAlert(text,title);
			{rdelim}else{ldelim}
				$.alerts._overlay('show');
				$("#add_rss").submit();
			{rdelim}
		{rdelim});

{rdelim});
</script>

<div class="title"><h5>{#RSS_LIST#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#RSS_LIST_TIP#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li>{#RSS_LIST#}</li>
	    </ul>
	</div>
</div>




<div class="widget first">
	<ul class="tabs">
	    <li class="activeTab"><a href="#tab1">{#RSS_LIST#}</a></li>
	    <li class=""><a href="#tab2">{#RSS_ADD#}</a></li>
	</ul>

		<div class="tab_container">
			<div id="tab1" class="tab_content" style="display: block;">

	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
		<thead>
		<tr>
			<td width="1%">{#RSS_ID#}</td>
			<td width="30%">{#RSS_CHANNEL_NAME#}</td>
			<td width="15%">{#RSS_ONPAGE_LIMIT#}</td>
			<td width="15%">{#RSS_DESCR_LIMIT#}</td>
			<td width="20%">{#RSS_CHANNEL_URL#}</td>
			<td width="10%">{#RSS_TAG#}</td>
			<td width="5%" colspan="2" align="center">{#RSS_ACTIONS#}</td>
		</tr>
		</thead>
		<tbody>
		{if $channels}
		{foreach from=$channels item=channel}
			<tr>
				<td class="itcen">{$channel->id}</td>
				<td><a title="{#RSS_EDIT_HINT#}" href="index.php?do=modules&action=modedit&mod=rss&moduleaction=edit&cp={$sess}&id={$channel->id}">{$channel->rss_site_name|escape}</a></td>
				<td>{$channel->rss_item_on_page}</td>
				<td>{$channel->rss_description_lenght} {#RSS_SYMBOLS#}</td>
				<td>{if $channel->rss_site_url == ''}{#RSS_SITE_NAME_NO#}{else}{$channel->rss_site_url}{/if}</td>
				<td><input name="textfield" type="text" value="{$channel->tag}" readonly /></td>
				<td align="center">
					<a class="topleftDir icon_sprite ico_edit" title="{#RSS_EDIT_HINT#}" href="index.php?do=modules&action=modedit&mod=rss&moduleaction=edit&cp={$sess}&id={$channel->id}"></a>
				</td>
				<td align="center">
					<a class="topleftDir ConfirmDelete icon_sprite ico_delete" title="{#RSS_DELETE_HINT#}" dir="{#RSS_DELETE_HINT#}" name="{#RSS_DELETE_CONF#}" href="index.php?do=modules&action=modedit&mod=rss&moduleaction=del&cp={$sess}&id={$channel->id}"></a>
				</td>
			</tr>
		{/foreach}
		{else}
			<tr>
				<td colspan="8">
					<ul class="messages">
						<li class="highlight yellow">{#RSS_NO_ITEMS#}</li>
					</ul>
				</td>
			</tr>
		{/if}
		</tbody>
	</table>
		</div>

			<div id="tab2" class="tab_content" style="display: none;">
					<form id="add_rss" method="post" action="index.php?do=modules&action=modedit&mod=rss&moduleaction=add&cp={$sess}" class="mainForm">
					<div class="rowElem">
						<label>{#RSS_NAME#}</label>
						<div class="formRight"><input name="new_rss" type="text" id="new_rss" value="" style="width: 400px" placeholder="{#RSS_NAME#}">
						&nbsp;<input type="button" class="basicBtn AddRSS" value="{#RSS_BUTTON_ADD#}" />
						</div>
						<div class="fix"></div>
					</div>
					</form>
			</div>
		</div>
	<div class="fix"></div>
</div>