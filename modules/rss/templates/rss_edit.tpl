<script type="text/javascript" language="JavaScript">
function changeRub(select) {ldelim}
	location.href='index.php?do=modules&action=modedit&mod=rss&moduleaction=edit&id={$channel->id}&rubric_id=' + select.options[select.selectedIndex].value + '&cp={$sess}';
{rdelim}
</script>

<div class="title"><h5>{#RSS_EDIT#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#RSS_EDIT_TIP#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><a href="index.php?do=modules&action=modedit&mod=rss&moduleaction=1&cp={$sess}">{#RSS_LIST#}</a></li>
	        <li>{#RSS_EDIT#}</li>
	        <li><strong class="code">{$channel->rss_site_name|escape}</strong></li>
	    </ul>
	</div>
</div>

<div class="widget first">
<div class="head"><h5 class="iFrames">{#RSS_TITLE_EDIT#}</h5></div>
<form method="post" action="index.php?do=modules&action=modedit&mod=rss&moduleaction=saveedit&cp={$sess}" onSubmit="return check_name();" class="mainForm">
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
	<tbody>

		<tr class="noborder">
			<td width="1%"><a title="{#RSS_EDIT_TIP_RUBRIC#}" href="#" class="toprightDir icon_sprite ico_info"></a></td>
			<td width="15%"><strong>{#RSS_RUBS_NAME#}</strong></td>
			<td>
				<select name="rss_rubric_id" onChange="changeRub(this)" id="rss_rubric_id" style="width: 350px;">
					{foreach from=$rubrics item=rubric}
						<option value="{$rubric->Id}" {if $channel->rss_rubric_id == $rubric->Id}selected{/if}>{$rubric->rubric_title|escape}</option>
					{/foreach}
				</select>
			</td>
		</tr>

		<tr>
			<td width="1%"><a title="{#RSS_EDIT_TIP_NAME#}" href="#" class="toprightDir icon_sprite ico_info"></a></td>
			<td width="20%"><strong>{#RSS_ITEM_NAME#}</strong></td>
			<td><input name="rss_site_name" style="width: 500px;" type="text" id="rss_site_name" size="60" value="{$channel->rss_site_name|escape}" /></td>
		</tr>

		<tr>
			<td width="1%"><a title="{#RSS_EDIT_TIP_ADD#}" href="#" class="toprightDir icon_sprite ico_info"></a></td>
			<td width="20%"><strong>{#RSS_CHANNEL_URL#}:</strong></td>
			<td><input name="rss_site_url" style="width: 500px;" type="text" id="rss_site_url" size="60" value="{$channel->rss_site_url}" /></td>
		</tr>

		<tr>
			<td width="1%"><a title="{#RSS_EDIT_TIP_TITLE#}" href="#" class="toprightDir icon_sprite ico_info"></a></td>
			<td width="20%"><strong>{#RSS_CHANNEL_DESCR#}</strong></td>
			<td><textarea style="width: 500px;" name="site_descr" cols="60" rows="4">{$channel->rss_site_description|escape}</textarea></td>
		</tr>

		<tr>
			<td width="1%"></td>
			<td width="20%"><strong>{#RSS_CHANNEL_TITLE#}</strong></td>
			<td>
				<select name="field_title" style="width: 350px;">
					{foreach from=$fields item=field}
						<option value="{$field->Id}"{if $field->Id == $channel->rss_title_id} selected="selected"{/if}>{$field->rubric_field_title|escape}</option>
					{/foreach}
				</select>
			</td>
		</tr>

		<tr>
			<td width="1%"></td>
			<td width="20%"><strong>{#RSS_CHANNEL_DESC#}</strong></td>
			<td>
				<select name="field_descr" style="width: 350px;">
					{foreach from=$fields item=field}
						<option value="{$field->Id}"{if $field->Id == $channel->rss_description_id} selected="selected"{/if}>{$field->rubric_field_title|escape}</option>
					{/foreach}
				</select>
			</td>
		</tr>

		<tr>
			<td width="1%"></td>
			<td width="20%"><strong>{#RSS_LIMIT_NAME#}</strong></td>
			<td><input name="rss_item_on_page" type="text" id="rss_item_on_page" size="10" style="width: 50px;" value="{$channel->rss_item_on_page}" /></td>
		</tr>

		<tr>
			<td width="1%"></td>
			<td width="20%"><strong>{#RSS_DESCR_LIMIT#}:</strong></td>
			<td><input name="rss_description_lenght" type="text" id="rss_description_lenght" size="10" style="width: 50px;" value="{$channel->rss_description_lenght}" /> {#RSS_SYMBOLS#}</td>
		</tr>

		<tr>
			<td class="third" colspan="3"><input type="submit" class="basicBtn" value="{#RSS_BUTTON_SAVE#}" /></td>
		</tr>

		<input type="hidden" name="id" value="{$channel->id}" />
	</tbody>
	</table>
</form>
</div>