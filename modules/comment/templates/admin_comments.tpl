<script type="text/javascript" language="JavaScript">
$(document).ready(function(){ldelim}



{rdelim});
</script>

<div class="title"><h5>{#COMMENT_MODULE_NAME#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#COMMENT_MODULE_COMENTS#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li>{#COMMENT_MODULE_NAME#}</li>
	        <li><strong class="code">{#COMMENT_MODULE_COMENTS#}</strong></li>
	    </ul>
	</div>
</div>


<div class="widget first">
<div class="head">
<h5 class="iFrames">{#COMMENT_MODULE_COMENTS#}</h5>
<div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=comment&moduleaction=settings&cp={$sess}">{#COMMENT_MODULE_SETTINGS#}</a></div>
</div>

<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
  <col width="20">
  <col>
  <col width="120">
  <col width="120">
  <col width="20">
  <col width="20">
	<thead>
		<tr>
			<td></td>
			<td><a href="index.php?do=modules&action=modedit&mod=comment&moduleaction=1&cp={$sess}&page={$smarty.request.page|escape|default:1}&sort=comment{if $smarty.request.sort=='comment'}_desc{/if}">{#COMMENT_TEXT_COMMENT#}</a> </td>
			<td><a href="index.php?do=modules&action=modedit&mod=comment&moduleaction=1&cp={$sess}&page={$smarty.request.page|escape|default:1}&sort=created{if $smarty.request.sort=='created'}_desc{/if}">{#COMMENT_DATE_CREATE#}</a> </td>
			<td><a href="index.php?do=modules&action=modedit&mod=comment&moduleaction=1&cp={$sess}&page={$smarty.request.page|escape|default:1}&sort=document{if $smarty.request.sort=='document'}_desc{/if}">{#COMMENT_DOC_TITLE#}</a> </td>
			<td colspan="2">Действия</td>
		</tr>
	</thead>
	<tbody>
	{if $docs}
	{foreach from=$docs item=doc}
		<tr>
			<td>{if $doc.comment_status != "0"}<span class="icon_sprite ico_ok"></span>{else}<span class="icon_sprite ico_blanc"></span>{/if}</td>
			<td><a class="topDir" title="{$doc.comment_text|escape|truncate:'1000'}" target="_blank" href="../index.php?id={$doc.document_id}&doc=impressum&subaction=showonly&comment_id={$doc.CId}#{$doc.CId}">{$doc.comment_text|escape|truncate:'100'}</a></td>
			<td class="date_text dgrey">{$doc.comment_published|date_format:$TIME_FORMAT|pretty_date}</td>
			<td><a target="_blank" href="../index.php?id={$doc.document_id}">{$doc.document_title|escape}</a>&nbsp;<span class="date_text dgrey">({$doc.Comments})</span></td>
			<td width="20"><a class="topleftDir icon_sprite ico_edit" title="{#COMMENT_EDIT#}" href="javascript:void(0);" onClick="windowOpen('index.php?do=modules&action=modedit&mod=comment&moduleaction=admin_edit&pop=1&docid={$doc.document_id}&Id={$doc.CId}','700','700','1');"></a></td>
			<td width="20"><a class="topleftDir icon_sprite ico_delete ConfirmDelete" title="{#COMMENT_DELETE_LINK#}" dir="{#COMMENT_DELETE_LINK#}" name="{#COMMENT_DELETE_LINK#}" href="index.php?do=modules&action=modedit&mod=comment&moduleaction=admin_del&Id={$doc.CId}"></a></td>
		</tr>
	{/foreach}
	{else}
		<tr>
			<td colspan="6">
		        <ul class="messages">
		            <li class="highlight yellow"><strong>Сообщение:</strong><br />Нет комментариев.</li>
		        </ul>
			</td>
		</tr>
	{/if}
	</tbody>
</table>
</div>

{if $page_nav}
	<div class="pagination">
	<ul class="pages">
		{$page_nav}
	</ul>
	</div>
{/if}
