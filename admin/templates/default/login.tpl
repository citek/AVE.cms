<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />

	<title>{#MAIN_LOGIN_TEXT#}</title>

	<meta name="robots" content="noindex, nofollow">
	<meta http-equiv="pragma" content="no-cache">
	<meta name="generator" content="Notepad" >
	<meta name="Expires" content="Mon, 06 Jan 1990 00:00:01 GMT">

	<!-- CSS Files -->
	<link href="{$tpl_dir}/css/combine.php?css=reset.css,login.css" rel="stylesheet" type="text/css" media="screen" />
	<link href="{$tpl_dir}/css/color_{$smarty.const.DEFAULT_THEME_FOLDER_COLOR}.css" rel="stylesheet" type="text/css" media="screen" />

	<!-- JS files -->
	<script src="{$tpl_dir}/js/combine.php?js=jquery-1.7.1.js,jquery.transform.js" type="text/javascript"></script>
	<script src="{$tpl_dir}/js/login.js" type="text/javascript"></script>
</head>

<body>

<div id="topNav">
    <div class="fixed">
        <div class="wrapper">
            <div class="backTo"><a href="../" title=""><img src="{$tpl_dir}/images/icons/mainWebsite.png" alt="" /><span>{#MAIN_LOGIN_BACK_SITE#}</span></a></div>
            <div class="userNav">
                <ul>
                    <li><a href="#" title=""><img src="{$tpl_dir}/images/icons/register.png" alt="" /><span>{#MAIN_LOGIN_REGISTER#}</span></a></li>
                    <li><a href="#" title=""><img src="{$tpl_dir}/images/icons/contact.png" alt="" /><span>{#MAIN_LOGIN_LOST#}</span></a></li>
                    <li><a href="#" title=""><img src="{$tpl_dir}/images/icons/help.png" alt="" /><span>{#MAIN_LOGIN_HELP#}</span></a></li>
                </ul>
            </div>
            <div class="fix"></div>
        </div>
    </div>
</div>

<div class="loginWrapper">
	<div class="loginLogo"><img src="{$tpl_dir}/images/loginLogo.png" alt="" /></div>
    <div class="loginPanel">
        <div class="head"><h5>{#MAIN_LOGIN_INTRO#}</h5></div>
        <form method="post" action="admin.php" class="mainForm">
        	<input type="hidden" name="action" value="login">
            <fieldset>

                <div class="loginRow">
                    <label for="user_login">{#MAIN_LOGIN_NAME#}</label>
                    <div class="loginInput"><input type="text" name="user_login" value="{$smarty.request.user_login|escape}"></div>
                    <div class="fix"></div>
                </div>

                <div class="loginRow">
                    <label for="user_pass">{#MAIN_LOGIN_PASSWORD#}</label>
                    <div class="loginInput"><input type="password" name="user_pass"></div>
                    <div class="fix"></div>
                </div>

               <div class="loginRow">
               		<label for="req2">Код:</label>
                	<div class="loginInput"><span id="captcha"><img src="/inc/captcha.php" alt="" width="120" height="60" border="0" /></span></div>
                	<div class="fix"></div>
                </div>

                <div class="loginRow">
                	<label for="securecode">Введите код:</label>
                	<div class="loginInput"><input name="securecode" type="text" id="securecode"  class="field"/></div>
                	<div class="fix"></div>
                </div>

                <div class="loginRow">
					<div class="rememberMe"><input type="checkbox" id="check2" name="chbox"><label style="cursor: pointer; ">{#MAIN_LOGIN_REMEMBER#}</label></div>
                    <input type="submit" value="{#MAIN_LOGIN_BUTTON#}" class="basicBtn submitForm">
                    <div class="fix"></div>
                </div>

				{if $error}
                <div class="loginRowError">
				<ul class="messages">
					<li class="highlight red">{$error}</li>
				</ul>
                    <div class="fix"></div>
                </div>
				{/if}
            </fieldset>
        </form>
    </div>
</div>

<div id="footer">
	<div class="wrapper">
    	<span>&copy; Copyright 2012. All rights reserved.</span>
    </div>
</div>

</body>
</html>