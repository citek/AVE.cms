<div class="title"><h5>{#COMMENT_MODULE_NAME#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#COMMENT_MODULE_SETTINGS#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><a href="index.php?do=modules&action=modedit&mod=comment&moduleaction=1&cp={$sess}">{#COMMENT_MODULE_NAME#}</a></li>
	        <li><strong class="code">{#COMMENT_MODULE_SETTINGS#}</strong></li>
	    </ul>
	</div>
</div>

<div class="widget first">
<div class="head">
<h5 class="iFrames">{#COMMENT_MODULE_SETTINGS#}</h5>
<div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=comment&moduleaction=1&cp={$sess}">{#COMMENT_MODULE_COMENTS#}</a></div>
</div>

<form action="index.php?do=modules&action=modedit&mod=comment&moduleaction=settings&cp={$sess}&sub=save" method="post" class="mainForm">
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
		<tr class="noborder">
			<td width="240">{#COMMENT_ENABLE_COMMENT#}</td>
			<td><input name="comment_active" type="checkbox" value="1" {if $comment_active=='1'}checked{/if} /></td>
		</tr>

		<tr>
			<td width="240">{#COMMENT_CHECK_ADMIN#}</td>
			<td>
				<input name="comment_need_approve" type="checkbox" value="1" {if $comment_need_approve=='1'}checked{/if} />
			</td>
		</tr>

		<tr>
			<td width="240">{#COMMENT_SPAMPROTECT#}</td>
			<td>
				<input name="comment_use_antispam" type="checkbox" value="1" {if $comment_use_antispam=='1'}checked{/if} />
			</td>
		</tr>

		<tr>
			<td width="240">{#COMMENT_FOR_GROUPS#}</td>
			<td>
				<select  name="comment_user_groups[]"  multiple="multiple" size="5" style="width:300px">
					{foreach from=$groups item=g}
						{assign var='sel' value=''}
						{if $g->user_group}
							{if (in_array($g->user_group,$comment_user_groups)) }
								{assign var='sel' value='selected'}
							{/if}
						{/if}
						<option value="{$g->user_group}" {$sel}>{$g->user_group_name|escape}</option>
					{/foreach}
				</select>
			</td>
		</tr>
		<tr>
			<td width="240">{#COMMENT_MAX_CHARS#}</td>
			<td><input name="comment_max_chars" type="text" id="comment_max_chars" value="{$comment_max_chars}" size="5" maxlength="5" maxlength="4" style="width: 35px;" /></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="{#COMMENT_BUTTON_SAVE#}" class="basicBtn" /></td>
		</tr>
	</table>

</form>
</div>