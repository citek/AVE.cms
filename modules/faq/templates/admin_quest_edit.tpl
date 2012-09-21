<div class="title"><h5>{#FAQ_INSERT_H#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#FAQ_INSERT#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><a href="index.php?do=modules&action=modedit&mod=faq&moduleaction=1&cp={$sess}">{#FAQ_LIST#}</a></li>
	        <li>{#FAQ_INSERT_H#}</li>
	    </ul>
	</div>
</div>

<div class="widget first">
<div class="head">
<h5 class="iFrames">{if $smarty.request.id != ''}{#FAQ_EDIT_RUB#}{else}{#FAQ_EDIT_RUB#}{/if}</h5>
<div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=faq&moduleaction=questedit&fid={$smarty.get.fid}&cp={$sess}">{#FAQ_ADD_QUEST#}</a></div>
<div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=faq&moduleaction=1&cp={$sess}">{#FAQ_BACK#}</a></div>
</div>

<form action="index.php?do=modules&action=modedit&mod=faq&moduleaction=questsave&cp={$sess}" method="post">
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
		<tr class="tableheader">
			<td>{#FAQ_INNAME#}</td>
		</tr>

		<tr>
			<td class="second">
				<div>
					<input type="hidden" id="faq_quest" name="faq_quest" value="{$faq_quest|escape}" style="display:none" />
					<input type="hidden" id="quest___Config" value="" style="display:none" />
					<div id="quest_data">
						<iframe id="quest___Frame" src="editor/editor/fckeditor.html?InstanceName=faq_quest&amp;Toolbar=cpengine_small" width="100%" height="150px" frameborder="0" scrolling="no"></iframe>
					</div>
				</div>
			</td>
		</tr>

		<tr class="tableheader">
			<td>{#FAQ_INDESC#}</td>
		</tr>

		<tr>
			<td class="second">
				<div>
					<input type="hidden" id="faq_answer" name="faq_answer" value="{$faq_answer|escape}" style="display:none" />
					<input type="hidden" id="answer___Config" value="" style="display:none" />
					<div id="answer_data">
						<iframe id="answer___Frame" src="editor/editor/fckeditor.html?InstanceName=faq_answer&amp;Toolbar=cpengine" width="100%" height="400px" frameborder="0" scrolling="no"></iframe>
					</div>
				</div>
			</td>
		</tr>

		<tr>
			<td class="first">
				<input type="hidden" name="id" value="{$id}">
				<input type="hidden" name="fid" value="{$faq_id}">
				<input name="submit" type="submit" class="basicBtn" value="{#FAQ_SAVE#}" />
			</td>
		</tr>
	</table>
</form>
</div>