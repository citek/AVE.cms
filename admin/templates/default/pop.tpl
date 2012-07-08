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
		{$content}
    </div>

    <div class="fix"></div>
</div>



<!-- Footer -->
<div id="footer">
	<div class="wrapper">
    	<span>{$smarty.const.APP_INFO} | {$smarty.const.APP_NAME} {$smarty.const.APP_VERSION} rev. {$smarty.const.BILD_VERSION}</span>
    </div>
</div>

</body>
</html>