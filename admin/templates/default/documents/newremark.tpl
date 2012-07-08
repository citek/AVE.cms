{if check_permission("remarks")}
<div class="first"></div>

<div class="title"><h5>{#DOC_NOTICE#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#DOC_NOTICE_NEW_LINK#}
    </div>
</div>

<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
			<li class="firstB"><a href="index.php?pop=1" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li>{#DOC_NOTICE#}</li>
	    </ul>
	</div>
</div>

{if $answers}
<div class="widget first">
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
		{foreach from=$answers item=answer}
			<tr>
				<td>{#DOC_NOTICE_AUTHOR#}{$answer.remark_author} ({$answer.remark_published|date_format:$TIME_FORMAT|pretty_date})</td>
			</tr>
			<tr>
				<td style="line-height:1.3em">
					{if $answer.remark_title}<strong>{$answer.remark_title}</strong><br />{/if}
					<br />
					{$answer.remark_text}<br />
					{if check_permission("remark_del")}
						<div align="right">&raquo;&nbsp;<strong><a href="index.php?do=docs&action=remark_del&Id={$smarty.request.Id|escape}&CId={$answer.Id}&remark_first={$answer.remark_first}&pop=1&cp={$sess}">{#DOC_NOTICE_DELETE_LINK#}</a></strong></div>
					{/if}
				</td>
			</tr>
		{/foreach}
	</table>
</div>
{/if}
<div class="widget first">
	{if check_permission("comments_openlose")}
		<form method="post" action="index.php?do=docs&action=remark_status&Id={$smarty.request.Id|escape}&pop=1&cp={$sess}" class="mainForm">
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
			<tr>
				<td>
					<input class="float" name="remark_status" type="checkbox" id="remark_status" value="1" {if $remark_status==1}checked="checked" {/if}/>&nbsp;<label>{#DOC_ALLOW_NOTICE#}</label>
				</td>
			</tr>
			<tr>
				<td>
				<input type="submit" class="basicBtn" value="{#DOC_BUTTON_NOTICE#}" />
				</td>
			</tr>
	</table>
		</form>
	{/if}

{if $page_nav}
	<div class="pagination">
	<ul class="pages">
		{$page_nav}
	</ul>
	</div>
{/if}

</div>

{/if}

{if $reply==1}
	{if $remark_status==1 || $new ==1}
		{include file='documents/replyform.tpl'}
	{/if}
{/if}