<script language="Javascript" type="text/javascript">
$(document).ready(function(){ldelim}

	$(".AddDocs").click( function(e) {ldelim}
		e.preventDefault();
		var DocName = $('#add_docum #DocName').fieldValue();
		var title = '{#MAIN_ADD_IN_RUB#}';
		var text = '{#DOC_ENTER_NAME#}';
		if (DocName == ""){ldelim}
			jAlert(text,title);
		{rdelim}else{ldelim}
			$.alerts._overlay('show');
			$("#add_docum").submit();
		{rdelim}
	{rdelim});

	$("#selall").click(function(){ldelim}
		if ($("#selall").is(":checked")){ldelim}
			$(".checkbox").removeAttr("checked");
			$("#Fields a.jqTransformCheckbox").removeClass("jqTransformChecked");
		{rdelim}else{ldelim}
	   		$(".checkbox").attr("checked","checked");
			$("#Fields a.jqTransformCheckbox").addClass("jqTransformChecked");
		{rdelim}
	{rdelim});

    $(".ConfirmRecycle").click(function(e){ldelim}
		e.preventDefault();
		var href = $(this).attr('href');
		var title = '{#DOC_TEMPORARY_DELETE#}';
		var confirm = '{#DOC_TEMPORARY_CONFIRM#}';
		jConfirm(
				confirm,
				title,
				function(b){ldelim}
					if (b){ldelim}
						$.alerts._overlay('show');
						window.location = href;
					{rdelim}
				{rdelim}
			);
	{rdelim});

	$(".CopyDocs").click( function(e) {ldelim}
		e.preventDefault();
		var href = $(this).attr('href');
		var title = '{#DOC_COPY#}';
		var text = '{#DOC_COPY_TIP#}';
		jPrompt(text, '', title, function(b){ldelim}
					if (b){ldelim}
						$.alerts._overlay('show');
        				window.location = href + '&document_title=' + b;
						{rdelim}else{ldelim}
							$.jGrowl("{#MAIN_NO_ADD_DOCS#}", {ldelim}theme: 'error'{rdelim});
						{rdelim}
				{rdelim}
			);
	{rdelim});



{literal}

	function action(href,actions){
		$.ajax({
				beforeSend: function(){
					$.alerts._overlay('show');
					},
				url: href,
				data: ({
					action: actions,
					ajax: '1',
					pop: '1'
					}),
				timeout:3000,
				dataType: "json",
				success: function(data){
					$.alerts._overlay('hide');
				    $.jGrowl(data[0],{theme: data[1]});
				},
				error: function (xhr, ajaxOptions, thrownError) {
					$.alerts._overlay('hide');
					$.jGrowl(xhr.status + thrownError, {theme: 'error'});
				}
			});
		};


	$('.lock').on('click', function(e){
		e.preventDefault();
        if($(this).hasClass('ico_unlock')){
			action($(this).attr('ajax'),'close');
			$(this).removeClass("ico_unlock").addClass("ico_lock");
        } else if ($(this).hasClass('ico_lock')){
			action($(this).attr('ajax'),'open');
			$(this).removeClass("ico_lock").addClass("ico_unlock")
        }
	});

{/literal}




{rdelim});
</script>

<div class="title"><h5>{#DOC_SUB_TITLE#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#DOC_TIPS#}
    </div>
</div>

<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li>{#DOC_SUB_TITLE#}</li>
	    </ul>
	</div>
</div>

{if check_permission('documents')}

<div class="widget first">
<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
	<col width="50%">
	<col width="50%">
	<thead>
	<tr>
		<td>{#MAIN_ADD_IN_RUB#}</td>
		<td>{#MAIN_SORT_DOCUMENTS#}</td>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td class="second" style="padding:8px;">
			<form action="index.php" method="get" id="add_docum" class="mainForm">
				<input type="hidden" name="cp" value="{$sess}" />
				<input type="hidden" name="do" value="docs" />
				<input type="hidden" name="action" value="new" />
				<select style="width: 200px;" name="rubric_id" id="DocName">
					<option value="">Выберите рубрику</option>
					{foreach from=$rubrics item=rubric}
						{if $rubric->Show==1}
							<option value="{$rubric->Id}">{$rubric->rubric_title|escape}</option>
						{/if}
					{/foreach}
				</select>
				&nbsp;
				<input style="width:85px" type="submit" class="basicBtn AddDocs" value="{#MAIN_BUTTON_ADD#}" />
			</form>
		</td>

		<td class="second" style="padding:8px;">
			<form action="index.php" method="get" class="mainForm">
				<input type="hidden" name="cp" value="{$sess}" />
				<input type="hidden" name="do" value="docs" />
				<select style="width: 200px;" name="rubric_id" id="RubrikSort">
					<option value="all">{#MAIN_ALL_RUBRUKS#}</option>
					{foreach from=$rubrics item=rubric}
						{if $rubric->Show==1}
							<option value="{$rubric->Id}"{if $smarty.request.rubric_id==$rubric->Id} selected{/if}>{$rubric->rubric_title|escape}</option>
						{/if}
					{/foreach}
				</select>
				&nbsp;
				<input style="width:85px" type="submit" class="basicBtn" value="{#MAIN_BUTTON_SORT#}" />
			</form>
		</td>
	</tr>
	</tbody>
</table>
</div>
{/if}


{include file='documents/doc_search.tpl'}

<div class="widget first">
<div class="head"><h5 class="iFrames">{#MAIN_DOCUMENTS_ALL#}</h5></div>
<form class="mainForm" method="post" action="index.php?do=docs&action=editstatus&cp={$sess}">
<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic" id="Fields">
	<col width="10">
	<col width="10">
	<col>
	<col width="150">
	<col width="180">
	<col width="80">
	{*<col width="100">*}
	<col width="100">
	<col width="20">
	<col width="20">
	<col width="20">
	<col width="20">
	<col width="20">
	<col width="20">
	<thead>
	<tr>
		<td><div align="center"><input type="checkbox" id="selall" value="1" /></div></td>
		<td><a href="{$link}&sort=id{if $smarty.request.sort=='id'}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_ID#}</a></td>
		<td nowrap="nowrap">
			<a href="{$link}&sort=title{if $smarty.request.sort=='title'}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_TITLE#}</a>
			&nbsp;|&nbsp;
			<a href="{$link}&sort=alias{if $smarty.request.sort=='alias'}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_URL_RUB#}</a>
		</td>
		<td><a href="{$link}&sort=rubric{if $smarty.request.sort=='rubric'}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_IN_RUBRIK#}</a></td>
		<td><a href="{$link}&sort=published{if $smarty.request.sort=='published'}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_CREATED#}</a> | <a href="{$link}&sort=changed{if $smarty.request.sort=='changed' || !$smarty.request.sort}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_EDIT#}</a></td>
		<td><a href="{$link}&sort=view{if $smarty.request.sort=='view'}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_CLICKS#}</a></td>
		{*<td><a href="{$link}&sort=print{if $smarty.request.sort=='print'}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_PRINTED#}</a></td>*}
		<td><a href="{$link}&sort=author{if $smarty.request.sort=='author'}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_AUTHOR#}</a></td>
		<td colspan="6" align="center">{#DOC_ACTIONS#}</td>
	</tr>
	</thead>
	<tbody>
	{foreach from=$docs item=item}
		<tr>
			<td nowrap="nowrap"><input class="checkbox" name="document[{$item->Id}]" type="checkbox" value="1" {if ($item->cantEdit!=1 || $item->canOpenClose!=1 || $item->canEndDel!=1) && ($item->Id == 1 || $item->Id == $PAGE_NOT_FOUND_ID)}disabled{/if} /></td>
			<td nowrap="nowrap"><strong><a class="toprightDir" title="{#DOC_SHOW_TITLE#}" href="/{if $item->Id!=1}index.php?id={$item->Id}&amp;cp={$sess}{/if}" target="_blank">{$item->Id}</a></strong></td>

			<td>
				<strong>
					{if $item->cantEdit==1}
						<a class="toprightDir docname" title="{#DOC_EDIT_TITLE#}" href="index.php?do=docs&action=edit&rubric_id={$item->rubric_id}&Id={$item->Id}&cp={$sess}">{if $item->document_breadcrum_title != ""}{$item->document_breadcrum_title}{else}{$item->document_title}{/if}</a>
					{else}
						{$item->document_title}
					{/if}
				</strong><br />
				<a class="toprightDir" title="{#DOC_SHOW2_TITLE#}" href="/{if $item->Id!=1}{$item->document_alias}{/if}" target="_blank"><span class="dgrey doclink">{$item->document_alias}</span></a>
			</td>

			<td nowrap="nowrap">
				{if $item->cantEdit==1}
					<select style="width: 200px;" {if $item->cantEdit==1}onchange="cp_pop('index.php?do=docs&action=change&Id={$item->Id}&rubric_id={$item->rubric_id}&NewRubr='+this.value+'&pop=1&cp={$sess}','550','550','1','docs');"{else}disabled="disabled"{/if}>
						{foreach from=$rubrics item=rubric}
							<option value="{$rubric->Id}"{if $item->rubric_id == $rubric->Id} selected="selected"{/if}>{$rubric->rubric_title|escape}</option>
						{/foreach}
					</select>
				{else}
					{foreach from=$rubrics item=rubric}
						{if $item->rubric_id == $rubric->Id}{$rubric->rubric_title|escape}{/if}
					{/foreach}
				{/if}
			</td>

			<td align="center"><span class="date_text dgrey">{$item->document_published|date_format:$TIME_FORMAT|pretty_date}<br />{$item->document_changed|date_format:$TIME_FORMAT|pretty_date}</span></td>

			<td align="center"><strong>{$item->document_count_view}</strong></td>

			{*<td align="center">{$item->document_count_print}</td>*}

			<td align="center">{$item->document_author|escape}</td>

			<td align="center" nowrap="nowrap">
				{if check_permission("remarks")}
					{if $item->ist_remark=='0'}
						<a class="topleftDir icon_sprite ico_comment" title="{#DOC_CREATE_NOTICE_TITLE#}" href="javascript:void(0);" onclick="cp_pop('index.php?do=docs&action=remark&Id={$item->Id}&pop=1&cp={$sess}','800','700','1','docs');"></a>
					{else}
						<a class="topleftDir icon_sprite ico_comment" title="{#DOC_REPLY_NOTICE_TITLE#}" href="javascript:void(0);" onclick="cp_pop('index.php?do=docs&action=remark_reply&Id={$item->Id}&pop=1&cp={$sess}','800','700','1','docs');"></a>
					{/if}
				{else}
					<span title="" class="topleftDir icon_sprite ico_comment_no"></span>
				{/if}
			</td>

			<td align="center" nowrap="nowrap">
				{if $item->cantEdit==1 && $item->Id != 1 && $item->Id != $PAGE_NOT_FOUND_ID}
					<a class="topleftDir icon_sprite ico_copy CopyDocs" title="{#DOC_COPY#}" href="index.php?do=docs&action=copy&rubric_id={$item->rubric_id}&Id={$item->Id}&cp={$sess}"></a>
	 				{else}
					<span title="" class="topleftDir icon_sprite ico_copy_no"></span>
				{/if}
			</td>

			<td align="center" nowrap="nowrap">
				{if $item->cantEdit==1}
					<a class="topleftDir icon_sprite ico_edit" title="{#DOC_EDIT_TITLE#}" href="index.php?do=docs&action=edit&rubric_id={$item->rubric_id}&Id={$item->Id}&cp={$sess}"></a>
				{else}
					<span title="" class="topleftDir icon_sprite ico_edit_no"></span>
				{/if}
			</td>

			<td align="center" nowrap="nowrap">
				{if $item->document_deleted==1}
					<span title="" class="topleftDir icon_sprite ico_blank"></span>
				{else}
					{if $item->document_status==1}
						{if $item->canOpenClose==1 && $item->Id != 1 && $item->Id != $PAGE_NOT_FOUND_ID}
							<a ajax="index.php?do=docs&rubric_id={$item->rubric_id}&Id={$item->Id}&cp={$sess}" class="topleftDir lock icon_sprite ico_unlock" title="{#DOC_DISABLE_TITLE#}" href="index.php?do=docs&action=close&rubric_id={$item->rubric_id}&Id={$item->Id}&cp={$sess}"></a>
						{else}
							{if $item->cantEdit==1 && $item->Id != 1 && $item->Id != $PAGE_NOT_FOUND_ID}
				   			<span title="" class="topleftDir icon_sprite ico_unlock_no"></span>
							{else}
							<span title="" class="topleftDir icon_sprite ico_unlock_no"></span>
							{/if}
						{/if}
					{else}
						{if $item->canOpenClose==1}
							<a ajax="index.php?do=docs&rubric_id={$item->rubric_id}&Id={$item->Id}&cp={$sess}" class="topleftDir lock icon_sprite ico_lock" title="{#DOC_ENABLE_TITLE#}" href="index.php?do=docs&action=open&rubric_id={$item->rubric_id}&Id={$item->Id}&cp={$sess}"></a>
						{else}
							{if $item->cantEdit==1 && $item->Id != 1 && $item->Id != $PAGE_NOT_FOUND_ID}
							<span title="" class="topleftDir icon_sprite ico_lock_no"></span>
							{else}
							<span title="" class="topleftDir icon_sprite ico_lock_no"></span>
							{/if}
						{/if}
					{/if}
				{/if}
			</td>

			<td align="center" nowrap="nowrap">
				{if $item->document_deleted==1}
					<a class="topleftDir icon_sprite ico_recylce_on" title="{#DOC_RESTORE_DELETE#}" href="index.php?do=docs&action=redelete&rubric_id={$item->rubric_id}&Id={$item->Id}&cp={$sess}"></a>
				{else}
					{if $item->canDelete==1}
						<a class="ConfirmRecycle topleftDir icon_sprite ico_recylce" title="{#DOC_TEMPORARY_DELETE#}"  href="index.php?do=docs&action=delete&rubric_id={$item->rubric_id}&Id={$item->Id}&cp={$sess}"></a>
					{else}
						<span title="" class="topleftDir icon_sprite ico_recylce_no"></span>
					{/if}
				{/if}
			</td>

			<td align="center" nowrap="nowrap">
				{if $item->canEndDel==1 && $item->Id != 1 && $item->Id != $PAGE_NOT_FOUND_ID}
					<a class="ConfirmDelete topleftDir icon_sprite ico_delete" title="{#DOC_FINAL_DELETE#}" dir="{#DOC_FINAL_DELETE#}" name="{#DOC_FINAL_CONFIRM#}" href="index.php?do=docs&action=enddelete&rubric_id={$item->rubric_id}&Id={$item->Id}&cp={$sess}"></a>
				{else}
					<span title="" class="topleftDir icon_sprite ico_delete_no"></span>
				{/if}
			</td>
		</tr>
	{/foreach}
	<thead>
	<tr>
		<td></td>
		<td><a href="{$link}&sort=id{if $smarty.request.sort=='id'}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_ID#}</a></td>
		<td nowrap="nowrap">
			<a href="{$link}&sort=title{if $smarty.request.sort=='title'}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_TITLE#}</a>
			&nbsp;|&nbsp;
			<a href="{$link}&sort=alias{if $smarty.request.sort=='alias'}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_URL_RUB#}</a>
		</td>
		<td><a href="{$link}&sort=rubric{if $smarty.request.sort=='rubric'}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_IN_RUBRIK#}</a></td>
		<td><a href="{$link}&sort=published{if $smarty.request.sort=='published'}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_CREATED#}</a> | <a href="{$link}&sort=changed{if $smarty.request.sort=='changed' || !$smarty.request.sort}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_EDIT#}</a></td>
		<td><a href="{$link}&sort=view{if $smarty.request.sort=='view'}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_CLICKS#}</a></td>
		{*<td><a href="{$link}&sort=print{if $smarty.request.sort=='print'}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_PRINTED#}</a></td>*}
		<td><a href="{$link}&sort=author{if $smarty.request.sort=='author'}_desc{/if}&page={$smarty.request.page|escape|default:'1'}&cp={$sess}">{#DOC_AUTHOR#}</a></td>
		<td colspan="6" align="center">{#DOC_ACTIONS#}</td>
	</tr>
	</thead>
		<tr>
			<td colspan="14">
			<select name="moderation" class="action-in-moderation">
				<option value="none" selected="selected">Действие с выбранными</option>
				<option value="1">Активный</option>
				<option value="0">Не активный</option>
				<option value="intrash">Временно удалить</option>
				<option value="outtrash">Восстановить</option>
				<option value="trash">Удалить</option>
			</select>
			&nbsp;&nbsp;<input type="submit" class="basicBtn" value="Сохранить изменения" onclick="document.getElementById('nf_save_next').value='save'" />
			</td>
		</tr>
</tbody>
</table>

</form>
</div>

{if $page_nav}
	<div class="pagination">
	<ul class="pages">
		{$page_nav}
	</ul>
	</div>
{/if}

<br /><br /><br /><br />
