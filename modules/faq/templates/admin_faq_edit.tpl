<div class="title"><h5>{#FAQ_EDIT_RUB#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#FAQ_EDIT_TIP#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><a href="index.php?do=modules&action=modedit&mod=faq&moduleaction=1&cp={$sess}">{#FAQ_LIST#}</a></li>
	        <li>{$RubricName|escape}</li>
	    </ul>
	</div>
</div>

<div class="widget first">
<div class="head">
<h5 class="iFrames">{if $smarty.request.id != ''}{#FAQ_EDIT_RUB#}{else}{#FAQ_EDIT_RUB#}{/if}</h5>
<div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=faq&moduleaction=questedit&fid={$smarty.get.fid}&cp={$sess}">{#FAQ_ADD_QUEST#}</a></div>
<div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=faq&moduleaction=1&cp={$sess}">{#FAQ_BACK#}</a></div>
</div>

{if !$questions}
	<h4 class="error" style="color:#800">{#FAQ_NO_ITEMS#}</h4>
{else}
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
		<col width="40%" />
		<col width="50%" />
		<col width="1%" />
		<col width="1%" />
		<thead>
		<tr>
			<td>{#FAQ_QUEST#}</td>
			<td>{#FAQ_ANSWER#}</td>
			<td colspan="2">{#FAQ_ACTIONS#}</td>
		</tr>
		</thead>
		{foreach from=$questions item=question}
			<tr>
				<td>
					<strong><a href="index.php?do=modules&action=modedit&mod=faq&moduleaction=questedit&fid={$smarty.get.fid}&id={$question->id}&cp={$sess}">{$question->faq_quest|strip_tags|escape|truncate:100}</a></strong>
				</td>

				<td>
					{$question->faq_answer|strip_tags|escape|truncate:80}
				</td>

				<td align="center">
					<a class="topleftDir icon_sprite ico_edit" title="{#FAQ_QEDIT_HINT#}" href="index.php?do=modules&action=modedit&mod=faq&moduleaction=questedit&fid={$smarty.get.fid}&id={$question->id}&cp={$sess}"></a>
				</td>

				<td align="center">
					<a class="topleftDir ConfirmDelete icon_sprite ico_delete" title="{#FAQ_QDELETE_HINT#}" href="index.php?do=modules&action=modedit&mod=faq&moduleaction=questdel&fid={$smarty.get.fid}&id={$question->id}&cp={$sess}"></a>
				</td>
			</tr>
		{/foreach}
	</table>
{/if}
</div>