<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="ru-RU">

<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />

	<title>{$version_setup}</title>

		<meta name="robots" content="noindex, nofollow" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta name="generator" content="" />
		<meta name="Expires" content="Mon, 06 Jan 1990 00:00:01 GMT" />

	<!-- CSS files -->
	<link type="text/css" href="data/tpl/css/reset.css" rel="stylesheet" media="screen" />
	<link type="text/css" href="data/tpl/css/gs.css" rel="stylesheet" media="screen" />
    <link type="text/css" href="data/tpl/css/styles.css" rel="stylesheet" media="screen" />

	<!-- IE "fixes" -->
	<!--[if gte IE 7]>
		<link type="text/css" href="data/tpl/css/styles_ie.css" rel="stylesheet" media="screen" />
	<![endif]-->

	<!--[if IE 7]>
		<link type="text/css" href="data/tpl/css/styles_ie7.css" rel="stylesheet" media="screen" />
	<![endif]-->

	<!-- JS files are loaded at the top of the page -->
	<script src="data/tpl/js/jquery.js" type="text/javascript"></script>
	<script src="data/tpl/js/jquery.tipsy.js" type="text/javascript"></script>
	
	<script type="text/javascript">
	{literal}
    $(document).ready(function(){
		//
        $("input:checkbox[name=agree_cbox]").change(function(){
            if($(this).is(":checked")){  
              $(':button[name=Submit]').attr('disabled', false).removeClass("disabled").addClass("blue");
            } else {
              $(':button[name=Submit]').attr('disabled', true).removeClass("blue").addClass("disabled");
            }
        });
		//
		$('#ask-cancel').click(function(e) {
			e.preventDefault();
			thisHref = 'data/exit.html';
			if(confirm('{/literal}{$la.confirm_exit}{literal}')) {
				window.location = thisHref;
			}
		});
    });
	{/literal}
    </script>

	<style type="text/css">
	{literal}
		div p {padding:10px;}
	{/literal}
	</style>

</head>

<body>
<div class="container container_14">

<div class="grid_14">
	<p></p>
</div>

<div class="grid_14">
    <div class="logo_header fleft" ><img src="data/tpl/images/logo.png" alt="AVE.cms" /></div>
    <div class="text_header fleft"><h1>{$la.install} {$version_setup}</h1></div>
    <div class="text_header_step fright"><h1>{$la.install_step} 1</h1></div>
</div>

<div class="grid_14">
	<p></p>
</div>

<div class="grid_14">
    <div id="bread">
    	<div class="br_blue_1"><span class="first">{$la.bread_lictexttitle}</span></div>
        <div class="br_blue_grey_1"></div>
        <div class="br_grey_2"><span class="second_a">{$la.bread_database_setting}</span></div>
        <div class="br_grey_grey_2"></div>
        <div class="br_grey_3"><span class="second_a2">{$la.bread_install_type}</span></div>
        <div class="br_grey_grey_3"></div>
        <div class="br_grey_4"><span class="second_a">{$la.bread_stepstatus}</span></div>
        <div class="br_grey_grey_4"></div>
        <div class="br_grey_5"><span class="second_a">{$la.bread_install_finish}</span></div>
    </div>
</div>

<div class="grid_14">
	<p></p>
</div>

<div class="grid_14">
	<div class="eula">
		{include file="../eula/ru.tpl"}
	</div>
</div>

    <form action="install.php" method="post" enctype="multipart/form-data" name="s" id="s">
<div class="grid_14">

		<div class="form_checkbox">
			<input name="agree_cbox" type="checkbox" id="agree_cbox" />&nbsp;&nbsp;<label for="agree_cbox"><span>{$la.lizagree}</span></label>
		</div>

			<input name="force" type="hidden" id="force" value="" />
			<input name="step" type="hidden" id="step" value="2" />

		<div class="form_buttons" id="confirmBox">
			<button type="submit" name="Submit" class="buttons disabled" disabled="disabled">{$la.eulaok}<span></span></button>
			<button id="ask-cancel" type="button" class="buttons gray">{$la.exit}<span></span></button>
		</div>
</div>

    </form>

</div>
</body>
</html>