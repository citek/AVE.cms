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

<body>
<!-- Wrapper -->
<div class="wrapper">
	<!-- Content -->
    <div class="content" id="contentPage">

	<div class="first"></div>
	<div class="title"><h5>{#MAIN_FILE_MANAGER_TITLE#}</h5></div>
	<div class="widget" style="margin-top: 0px;">
	    <div class="body">
			Выберите нужный файл и нажмите по кнопке &quot;Вставить файл&quot;
	    </div>
	</div>



<div class="widget first">
<form style="display:inline;" name="bForm" onSubmit="return false;" class="mainForm">
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
		<tr>
			<td>
				<div class="pr12"><input type="text" name="bDirName" size="20" style="width:100%;" readonly="readonly" /></div>
			</td>
			<td width="5%" nowrap="nowrap">
				<input type="button" class="basicBtn" onClick="NewFolder();" value="{#MAIN_MP_CREATE_FOLDER#}" />&nbsp;
			</td>
			<td width="5%" nowrap="nowrap">
				<input type="button" class="basicBtn" onClick="updlg();" value="{#MAIN_MP_UPLOAD_FILE#}" />
			</td>
		</tr>

		<tr valign="top">
			<td colspan="3">
				{assign var=height value=420}
				<div style="border:1px solid #D4D4D4;overflow:hidden;height:{$height}px;width:100%">
					<iframe frameborder="0" name="zf" id="zf" width="100%" height="{$height}" scrolling="Yes" src="browser.php?typ={$smarty.request.typ|escape}&action=list&dir={$dir}"></iframe>
				</div>
			</td>
		</tr>

		{if $smarty.request.typ!=''}
			<tr>
				<td colspan="2">
					<div class="pr12"><input type="text" name="bFileName" size="20" style="width:100%;" readonly="readonly" /></div>
				</td>
				<td>
					<input type="button" class="basicBtn" onClick="submitTheForm();" value="{#MAIN_MP_FILE_INSERT#}" />
				</td>
			</tr>
		{/if}
	</table>
</form>
</div>

    </div>
    <div class="fix"></div>
</div>




<script type="text/javascript">
function submitTheForm() {ldelim}
	if (document.bForm.bFileName.value == '' && '{$target}' != 'dir') {ldelim}
		alert('{#MAIN_MP_PLEASE_SELECT#}');
	{rdelim}
	else {ldelim}
{if		$target=='link'}
		window.opener.document.getElementById('txtUrl').value = '{$mediapath}' + document.bForm.bDirName.value + document.bForm.bFileName.value;

{elseif $target=='link_image'}
		window.opener.document.getElementById('txtLnkUrl').value = '{$cppath}/{$mediapath}' + document.bForm.bDirName.value + document.bForm.bFileName.value;
		window.opener.UpdatePreview();

{elseif $target=='txtUrl'}
		window.opener.document.getElementById('txtUrl').value = '{$cppath}/{$mediapath}' + document.bForm.bDirName.value + document.bForm.bFileName.value;
		window.opener.UpdatePreview();

{elseif $target=='navi'}
		/*window.opener.document.getElementById('Link_{$smarty.request.id|escape}').value = '{$cppath}/{$mediapath}' + document.bForm.bDirName.value + document.bForm.bFileName.value;*/
		window.opener.document.getElementById('{$smarty.request.id|escape}').value = '{$cppath}/{$mediapath}' + document.bForm.bDirName.value + document.bForm.bFileName.value;
		/*window.opener.document.getElementById('Titel_{$smarty.request.id|escape}').value = document.bForm.bFileName.value;*/

{elseif $target!='' && $target_id!='' && $target_id!=null}
{if $target=='image'}
		window.opener.document.getElementById('preview__{$target_id}').src = '../{$mediapath}' + document.bForm.bDirName.value + document.bForm.bFileName.value;
{/if}
{if $target=='dir'}
		var bdn = document.bForm.bDirName.value.split('/').reverse();
		window.opener.document.getElementById('{$target}__{$target_id}').value = bdn[1];
{else}
		window.opener.document.getElementById('{$target}__{$target_id}').value = '{$mediapath}' + document.bForm.bDirName.value + document.bForm.bFileName.value;
{/if}

{elseif $target!='all'}
{if $smarty.request.fillout=='dl'}
		window.opener.document.getElementById('{$smarty.request.target|escape}').value = '{$mediapath}' + document.bForm.bDirName.value + document.bForm.bFileName.value;
{else}
		window.opener.updatePreview();
{/if}
{/if}
		setTimeout("self.close();", 100);
    {rdelim}
{rdelim}

function NewFolder() {ldelim}
	var title = '{#MAIN_MP_CREATE_FOLDER#}';
	var text = '{#MAIN_ADD_FOLDER#}';
	jPrompt(text, '', title, function(b){ldelim}
				if (b){ldelim}
                       $.alerts._overlay('hide');
                       $.alerts._overlay('show');
					   parent.frames['zf'].location.href='browser.php?typ={$smarty.request.typ|escape}&action=list&dir=' + document.bForm.bDirName.value + '&newdir=' + b;
					   $.alerts._overlay('hide');
				{rdelim}
				else
				{ldelim}
					$.alerts._overlay('hide');
					$.jGrowl('{#MAIN_NO_ADD_FOLDER#}');
				{rdelim}
			{rdelim}
		);
{rdelim}


function updlg() {ldelim}
	var url = 'browser.php?typ={$smarty.request.typ|escape}&action=upload&pfad=' + document.bForm.bDirName.value;
	var winWidth = 950;
	var winHeight = 510;
	var w = (screen.width - winWidth)/2;
	var h = (screen.height - winHeight)/2 - 60;
	var name = 'upload2mp';
	var features = 'scrollbars=no,width='+winWidth+',height='+winHeight+',top='+h+',left='+w;
	window.open(url,name,features);
{rdelim}
</script>

<!-- Footer -->
<div id="footer">
	<div class="wrapper">
    	<span>{$smarty.const.APP_INFO} | {$smarty.const.APP_NAME} {$smarty.const.APP_VERSION} rev. {$smarty.const.BILD_VERSION}</span>
    </div>
</div>

</body>
</html>