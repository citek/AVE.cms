<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />

	<title>{#MAIN_PAGE_TITLE#} - {*#SUB_TITLE#*} ({$smarty.session.user_name|escape})</title>

	<meta name="robots" content="noindex, nofollow">
	<meta http-equiv="pragma" content="no-cache">
	<meta name="generator" content="Notepad" >
	<meta name="Expires" content="Mon, 06 Jan 1990 00:00:01 GMT">

	<!-- CSS Files -->
	<link href="{$tpl_dir}/css/combine.php?css=reset.css,main.css,data_table.css,jquery-ui_custom.css" rel="stylesheet" type="text/css" media="screen" />
	<link href="{$tpl_dir}/css/color_{$smarty.const.DEFAULT_THEME_FOLDER_COLOR}.css" rel="stylesheet" type="text/css" media="screen" />
	<link href="{$tpl_dir}/css/browser.css" rel="stylesheet" type="text/css" media="screen" />
	<!-- JS files -->
	<script src="{$tpl_dir}/js/combine.php?js=jquery-1.7.1.js,jquery-ui.min.js,jquery.form.js,jquery.transform.js,jquery.jgrowl.js,jquery.alerts.js,jquery.tipsy.js,jquery.totop.js,jquery.filestyle.js,jquery.collapsible.min.js,jquery.dataTables.js,jquery-ui-time.js,jquery.placeholder.min.js,jquery.cookie.js" type="text/javascript"></script>
	<script src="{$tpl_dir}/js/main.js" type="text/javascript"></script>

	<!-- JS Scripts -->
    <script>
      var ave_path = "{$ABS_PATH}";
      var ave_theme = "{$smarty.const.DEFAULT_THEME_FOLDER}";
      var ave_admintpl = "{$tpl_dir}";
    </script>

</head>

<body topmargin="0" leftmargin="0">
<script type="text/javascript">
{if $new_dir_rezult}
	alert('{#MAIN_CREATE_DIR_ERROR#}');
{/if}
function fileAction(fName, fAction) {ldelim}
	if (fAction == 'select') {ldelim}
		parent.document.bForm.bFileName.value = fName;
	{rdelim}
{rdelim}
parent.document.bForm.bDirName.value='{$dir}';
</script>

<div id="files">

{if $dir != '/'}
<div class="imageBlock0">
	<div class="imageBlock1">
		<div class="imageBlock"><a href="browser.php?typ={$smarty.request.typ|escape}&action=list&dir={$dirup}"><img class="topDir" title="{#MAIN_MP_UP_LEVEL#}" src="{$tpl_dir}/images/folder_up.gif" alt="" border="0" width="{$max_size}" height="{$max_size}" /></a></div>
		<div class="imageName" align="center"><a title="{#MAIN_MP_UP_LEVEL#}" href="browser.php?typ={$smarty.request.typ|escape}&action=list&dir={$dirup}">..</a></div>
	</div>
</div>
{/if}

{foreach from=$dirs item=dir_link key=dir_name}
<div class="imageBlock0">
	<div class="imageBlock1">
		<div class="imageBlock"><a href="{$dir_link}"><img src="{$tpl_dir}/images/folder.gif" alt="" border="0" width="{$max_size}" height="{$max_size}" /></a></div>
		<div class="imageName" align="center">{$dir_name}</div>
	</div>
</div>
{/foreach}


{foreach from=$files item=file key=file_name}
<div class="imageBlock0">
	<div class="imageBlock1">
		<div class="mb_icon_file"><img src="{$tpl_dir}/images/mediapool/{$file.icon}.gif" alt="" border="0" /></div>
		{if !$recycled}
			{if check_permission('mediapool_del')}
				<div class="mb_icon_delete">
					<a title="{#MAIN_MP_FILE_DELETE#}" href="javascript:;" onClick="javascript:ConfirmDelete('{$file_name}');" class="leftDir icon_sprite ico_delete"></a>
				</div>
			{/if}
		{/if}

		<div class="mb_name">{$file_name|truncate:20}</div>

		<div class="imageBlock" align="center">
			{if $recycled}
				<img src="{$file.bild}" alt="" border="0" width="{$max_size}" height="{$max_size}" />
			{else}
				<a href="javascript:;" onClick="javascript:fileAction('{$file_name}', 'select');">
					<img class="topDir" title="Выбрать файл" src="{$file.bild}" alt="" border="0" width="{$max_size}" height="{$max_size}" />
				</a>
			{/if}
		</div>

		<div class="imageName" align="center">{$file.filesize}&nbsp;Кб</div>

		<div class="mb_time">{$file.moddate}</div>

	</div>
</div>
{/foreach}
</div>

{literal}
<!-- Load jQuery and JS files -->
<script type="text/javascript">
<!--
$(document).ready(function(){

	var ctrlState = false;

	$('.imageBlock0').live('mouseover', function(){
		if(!$(this).hasClass('imageBlockAct')) {
			$(this).addClass('imageBlockHover');
		} else {
			$(this).addClass('imageBlockActHover');
		}
	});
	$('.imageBlock0').live('mouseout', function(){
		if(!$(this).hasClass('imageBlockAct')) {
			$(this).removeClass('imageBlockHover');
		} else {
			$(this).removeClass('imageBlockActHover');
		}
	});

	$('#insertImage').click(function(){
		$('.imageBlockAct').trigger('dblclick');
		Window.close();
	});


	$('.imageBlock0').live('click', function(){
		if(ctrlState) {
			if($(this).hasClass('imageBlockActHover') || $(this).hasClass('imageBlockAct')) {
				$(this).removeClass('imageBlockAct');
				$(this).removeClass('imageBlockActHover');
			} else {
				$(this).removeClass('imageBlockHover');
				$(this).addClass('imageBlockAct');
			}
		} else {
			$('.imageBlockAct').removeClass('imageBlockAct');
			$(this).removeClass('imageBlockHover');
			$(this).addClass('imageBlockAct');
		}
	});


	$(this).blur(function(event){
		ctrlState = false;
	});
});
{/literal}

	function ConfirmDelete(fName) {ldelim}
		var title = "{#MAIN_MP_FILE_DELETE#}";
		var confirm = "{#MAIN_MP_DELETE_CONFIRM#}";
		jConfirm(
		confirm,
		title,
		function(b){ldelim}
			if (b){ldelim}
				$.alerts._overlay('show');
				parent.frames['zf'].location.href = 'browser.php?typ={$smarty.request.typ|escape}&action=delfile&dir={$dir}&file=' + fName;
				$.alerts._overlay('hide');
			{rdelim}
		{rdelim}
		);
	{rdelim}

//-->
</script>


</body>
</html>