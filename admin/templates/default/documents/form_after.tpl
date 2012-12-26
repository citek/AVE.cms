<script language="Javascript" type="text/javascript">
$(document).ready(function(){ldelim}
	$('#addInNav').hide();
{rdelim});
</script>

<div class="title"><h5>{#DOC_AFTER_CREATE_TITLE#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#DOC_AFTER_CREATE_INFO#}
    </div>
</div>


<ul id="doclinks" style="padding-left:70px">
	<li><span class="icon_sprite ico_edit floatleft"></span>&nbsp;<a href="index.php?do=docs&action=edit&Id={$document_id}&cp={$sess}">{#DOC_EDIT_THIS_DOCUMENT#}</a></li>
	<li><span class="icon_sprite ico_look floatleft"></span>&nbsp;<a href="/index.php?id={$document_id}" target="_blank">{#DOC_DISPLAY_NEW_WINDOW#}</a><br /><br /></li>
	<li><span class="icon_sprite ico_look floatleft"></span>&nbsp;<a href="/{if $document_id!=1}index.php?id={$document_id}&amp;cp={$sess}{/if}" target="_blank">{#DOC_DISPLAY_NEW_WINDOW#}</a><br /><br /></li>
	{if $innavi}
		<li class="navig"><span class="icon_sprite ico_navigation floatleft"></span><a href="javascript:void(0);" onclick="$('#addInNav').toggle();">{#DOC_INCLUDE_NAVIGATION#}</a><br /><br /></li>
	{/if}
	<li><span class="icon_sprite ico_add floatleft"></span>&nbsp;<a href="index.php?do=docs&action=copy&rubric_id={$rubric_id}&Id={$document_id}&cp={$sess}">{#DOC_ADD_COPY_DOCUMENT#}</a><br /></li>
	<li><span class="icon_sprite ico_add floatleft"></span>&nbsp;<a href="index.php?do=docs&action=new&rubric_id={$rubric_id}&cp={$sess}">{#DOC_ADD_NEW_DOCUMENT#}</a><br /><br /></li>
	<li><span class="icon_sprite ico_copy floatleft"></span>&nbsp;<a href="index.php?do=docs&rubric_id={$rubric_id}&cp={$sess}">{#DOC_CLOSE_WINDOW_RUBRIC#}</a></li>
	<li><span class="icon_sprite ico_copy floatleft"></span>&nbsp;<a href="index.php?do=docs&cp={$sess}">{#DOC_CLOSE_WINDOW#}</a></li>
</ul>

{if $innavi}
<div id="addInNav" style="margin-top:25px;margin-left:70px;width:700px;">
	<form method="post" action="index.php">
		<input type="hidden" name="do" value="docs">
		<input type="hidden" name="action" value="innavi">
		<input type="hidden" name="document_id" value="{$document_id}">
		<input type="hidden" name="rubric_id" value="{$rubric_id}">
		<input type="hidden" name="cp" value="{$sess}">
		<table width="100%" border="0" cellpadding="8" cellspacing="1" class="tableborder">
			<col width="200">
			<tr>
				<td colspan="2">{#DOC_TO_NAVI_TITLE#}</td>
			</tr>

			<tr>
				<td>{#DOC_ADD_IN_NAVIGATION#}</td>
				<td nowrap>
					{include file='navigation/tree_docform.tpl'} {#DOC_IN_MENU#}&nbsp;
					<select name="navi_id">
						{foreach from=$navis item=menu}
							<option value="{$menu->id}">{$menu->navi_titel|escape}</option>
						{/foreach}
					</select>
				</td>
			</tr>

			<tr>
				<td>{#DOC_NAVIGATION_POSITION#}</td>
				<td><input style="width:45px" name="navi_item_position" type="text" value="10" maxlength="4"></td>
			</tr>

			<tr>
				<td>{#DOC_NAVIGATION_TITLE#}</td>
				<td><input style="width:98%" name="navi_title" type="text" value="{$document_title|escape}"></td>
			</tr>

			<tr>
				<td>{#DOC_TARGET#}</td>
				<td>
					<select style="width:150px" name="navi_item_target">
						<option value="_self">{#DOC_TARGET_SELF#}</option>
						<option value="_blank">{#DOC_TARGET_BLANK#}</option>
					</select>
				</td>
			</tr>

			<tr>
				<td colspan="2"><input type="submit" class="button" value="{#DOC_BUTTON_ADD_MENU#}"></td>
			</tr>
		</table>
	</form>
</div>
{/if}