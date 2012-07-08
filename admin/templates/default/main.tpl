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

	<script type="text/javascript" language="JavaScript">
	$(document).ready(function(){ldelim}

		{if check_permission('group_new')}
		$(".ulAddGroup").click( function(e) {ldelim}
			e.preventDefault();
			var title = '{#MAIN_ADD_NEW_GROUP#}';
			var text = '{#MAIN_ADD_NEW_GROUP_NAME#}';
			jPrompt(text, '', title, function(b){ldelim}
						if (b){ldelim}
	                        $.alerts._overlay('hide');
	                        $.alerts._overlay('show');
							window.location = ave_path+'admin/index.php?do=groups&action=new&cp={$sess}'+ '&user_group_name=' + b;
						{rdelim}else{ldelim}
							$.jGrowl('{#MAIN_NO_ADD_GROUP#}');
						{rdelim}
					{rdelim}
				);
		{rdelim});
		{/if}

		{if check_permission('user_new')}
		$(".ulAddUser").click( function(e) {ldelim}
			e.preventDefault();
			var title = '{#MAIN_ADD_NEW_USER#}';
			var text = '{#MAIN_ADD_NEW_USER_NAME#}';
			jPrompt(text, '', title, function(b){ldelim}
						if (b){ldelim}
	                        $.alerts._overlay('hide');
	                        $.alerts._overlay('show');
							window.location = ave_path+'admin/index.php?do=user&action=new&cp={$sess}'+ '&user_name=' + b;
						{rdelim}else{ldelim}
							$.jGrowl('{#MAIN_NO_ADD_USER#}');
						{rdelim}
					{rdelim}
				);
		{rdelim});
		{/if}

		{if check_permission('navigation_new')}
		$(".ulAddNav").click( function(e) {ldelim}
			e.preventDefault();
			var title = '{#MAIN_ADD_NEW_NAV#}';
			var text = '{#MAIN_ADD_NEW_NAV_NAME#}';
			jPrompt(text, '', title, function(b){ldelim}
						if (b){ldelim}
	                        $.alerts._overlay('hide');
	                        $.alerts._overlay('show');
							window.location = ave_path+'admin/index.php?do=navigation&action=new&cp={$sess}'+ '&NaviName=' + b;
						{rdelim}else{ldelim}
							$.jGrowl('{#MAIN_NO_ADD_NAV#}');
						{rdelim}
					{rdelim}
				);
		{rdelim});
		{/if}

		{if check_permission('template_new')}
		$(".ulAddTempl").click( function(e) {ldelim}
			e.preventDefault();
			var title = '{#MAIN_ADD_NEW_TEMPL#}';
			var text = '{#MAIN_ADD_NEW_TEMPL_NAME#}';
			jPrompt(text, '', title, function(b){ldelim}
						if (b){ldelim}
	                        $.alerts._overlay('hide');
	                        $.alerts._overlay('show');
							window.location = ave_path+'admin/index.php?do=templates&action=new&cp={$sess}'+ '&TempName=' + b;
						{rdelim}else{ldelim}
							$.jGrowl('{#MAIN_NO_ADD_TEMPL#}');
						{rdelim}
					{rdelim}
				);
		{rdelim});
		{/if}

		{if check_permission('request_new')}
		$(".ulAddRequest").click( function(e) {ldelim}
			e.preventDefault();
			var title = '{#MAIN_ADD_NEW_REQUEST#}';
			var text = '{#MAIN_ADD_NEW_REQUEST_NAME#}';
			jPrompt(text, '', title, function(b){ldelim}
						if (b){ldelim}
	                        $.alerts._overlay('hide');
	                        $.alerts._overlay('show');
							window.location = ave_path+'admin/index.php?do=request&action=new&cp={$sess}'+ '&request_title_new=' + b;
						{rdelim}else{ldelim}
							$.jGrowl('{#MAIN_NO_ADD_QUERY#}');
						{rdelim}
					{rdelim}
				);
		{rdelim});
		{/if}

		{if check_permission('rubric_new')}
		$(".ulAddRub").click( function(e) {ldelim}
			e.preventDefault();
			var title = '{#MAIN_ADD_NEW_RUB#}';
			var text = '{#MAIN_ADD_NEW_RUB_NAME#}';
			jPrompt(text, '', title, function(b){ldelim}
						if (b){ldelim}
	                        $.alerts._overlay('hide');
	                        $.alerts._overlay('show');
							window.location = ave_path+'admin/index.php?do=rubs&action=new&cp={$sess}'+ '&rubric_title=' + b;
						{rdelim}else{ldelim}
							$.jGrowl('{#MAIN_NO_ADD_RUB#}');
						{rdelim}
					{rdelim}
				);
		{rdelim});
		{/if}



    {literal}

var admin = {
	Toggle : function(){
		$.each(["LeftMenu"], function(key, value) {

			//Считываем cookie
			var toggle = $.cookie(value);

			//Проверяем cookie
			if (toggle == 'hidden') {
				$(".leftNav").addClass("hidden");
				$(".dd_page").css("display","");
			} else {
                $("#leftNav_show span").addClass("close");
				$(".dd_page").css("display","none");
			}

			$("[id='toggle-"+this+"']").click(function() {
				if ($(".leftNav").hasClass('hidden')) {
					$(".leftNav").removeClass('hidden').addClass('visible');
                    $(".dd_page").css("display","none");
                    $("#leftNav_show span").addClass("close");
					$.cookie(value, 'visible');
				} else {
					$(".leftNav").removeClass('visible').addClass('hidden');
                    $("#leftNav_show span").removeClass("close");
                    $(".dd_page").css("display","");
					$.cookie(value, 'hidden');
				}
			});
		});
  	}
}

	if($("[id^='toggle']").length){admin.Toggle();}

    {/literal}

	{rdelim});
	</script>

</head>

<body>

<div id="leftNav_show">
    <a href="javascript:void(0);" id="toggle-LeftMenu"><span class="rightDir" title="Показать/Скрыть меню"></span></a>
</div>


<!-- Top Menu -->
<div id="topNav">
    <div class="fixed">
        <div class="wrapper">
            <div class="welcome"><a href="index.php" title="{#MAIN_LINK_HOME#}"><img src="{$tpl_dir}/images/userPic.png" alt="" /></a><span>{#MAIN_USER_ONLINE#} <strong>{$smarty.session.user_name|escape}</strong></span></div>
            <div class="userNav">
                <ul>

                    <li class="dd_add"><img src="{$tpl_dir}/images/icons/add.png" alt="" /><span>Добавить</span>
                        <ul class="menu_add">
							 {if check_permission('documents')}<li><a onclick="cp_pop('index.php?do=docs&action=add_new&pop=1&cp={$sess}','750','600','1')" href="javascript:void(0);">Документ</a></li>{/if}
							 {if check_permission('rubric_new')}<li><a class="ulAddRub" href="index.php?do=rubs&action=new&cp={$sess}">Рубрику</a></li>{/if}
							 {if check_permission('request_new')}<li><a class="ulAddRequest" href="index.php?do=request&action=new&cp={$sess}">Запрос</a></li>{/if}
							 {if check_permission('template_new')}<li><a class="ulAddTempl" href="index.php?do=templates&action=new&cp={$sess}">Шаблон</a></li>{/if}
							 {if check_permission('navigation_new')}<li><a class="ulAddNav" href="index.php?do=navigation&action=new&cp={$sess}">Навигацию</a></li>{/if}
							 {if check_permission('user_new')}<li><a class="ulAddUser" href="index.php?do=user&action=new&cp={$sess}">Пользователя</a></li>{/if}
							 {if check_permission('group_new')}<li><a class="ulAddGroup" href="index.php?do=groups&amp;action=new&amp;cp={$sess}">Группу</a></li>{/if}
                        </ul>
					</li>

                    <li class="dd_page hidden"><img src="{$tpl_dir}/images/icons/tasks.png" alt="" /><span>Разделы</span>
                        <ul class="menu_page">
							 {$navi_top}
                        </ul>
					</li>

                    <!-- <li><img src="{$tpl_dir}/images/icons/messages.png" alt="" /><span>Messages</span><span class="numberTop">8</span></li> -->
                    {if check_permission('modules')}
					{if $modules}
					<li class="dd_modul"><img src="{$tpl_dir}/images/icons/subInbox.png" alt="" /><span>{#MAIN_LINK_MODULES_H#}</span>
                        <ul class="menu_modul">
						{if $modules && check_permission('modules')}
								{foreach from=$modules item=modul}
										<li><a href="index.php?do=modules&action=modedit&mod={$modul->ModulPfad}&moduleaction=1&cp={$sess}">{$modul->ModulName}</a></li>
								{/foreach}
						{/if}
                        </ul>
                    </li>
					{/if}
					{/if}
                    <li class="dd_settings"><img src="{$tpl_dir}/images/icons/settings.png" alt="" /><span>{#MAIN_LINK_SETTINGS_H#}</span>
                        <ul class="menu_settings">
							 {if check_permission('gen_settings')}<li><a href="index.php?do=settings&amp;cp={$sess}">{#MAIN_SETTINGS_EDIT_1#}</a></li>
							 <li><a href="index.php?do=settings&amp;sub=case&amp;cp={$sess}">{#MAIN_SETTINGS_EDIT_2#}</a></li>
							 <li><a href="index.php?do=settings&amp;sub=countries&amp;cp={$sess}">{#MAIN_SETTINGS_EDIT_3#}</a></li>{/if}
                             {if check_permission('dbactions')}<li><a href="index.php?do=dbsettings&action=dump_top&cp={$sess}">{#MAIN_SETTINGS_EDIT_4#}</a></li>{/if}
                        </ul>
					</li>
					{if check_permission('session_clear')}<li><a href="#" class="clearCache" title="{#MAIN_STAT_CLEAR_CACHE#}"><img src="{$tpl_dir}/images/icons/subTrash.png" alt="" /><span>{#MAIN_STAT_CLEAR_CACHE#}</span></a></li>{/if}
                    {*<li><a href="#" title="{#MAIN_LOGIN_HELP#}"><img src="{$tpl_dir}/images/icons/help.png" alt="" /><span>{#MAIN_LOGIN_HELP#}</span></a></li>*}
					{if $login_menu}
					<li class="dd_login"><img src="{$tpl_dir}/images/icons/preview.png" alt="" /><span>{#MAIN_LINK_SITE#}</span>
					{else}
					<li><a href="../" title="{#MAIN_LINK_SITE#}" target="_blank"><img src="{$tpl_dir}/images/icons/preview.png" alt="" /><span>{#MAIN_LINK_SITE#}</span></a>
					{/if}
						{if $login_menu}
						<ul class="menu_login">
							 <li><a href="../index.php?module=login&action=wys_adm&sub=on" target="_blank">{#MAIN_LINK_SITE_ON#}</a></li>
							 <li><a href="../index.php?module=login&action=wys_adm&sub=off" target="_blank">{#MAIN_LINK_SITE_OFF#}</a></li>
                        </ul>
						{/if}
					</li>
                    <li><a href="admin.php?do=logout" class="ConfirmLogOut" title="{#MAIN_BUTTON_LOGOUT#}"><img src="{$tpl_dir}/images/icons/logout.png" alt="" /><span>{#MAIN_BUTTON_LOGOUT#}</span></a></li>
                </ul>
            </div>
            <div class="fix"></div>
        </div>
    </div>
</div>

<!-- Header -->
<div id="header" class="wrapper">
    <div class="logo"><a href="index.php" class="box"></a></div>
    <div class="fix"></div>
</div>

<!-- Wrapper -->
<div class="wrapper">

	<!-- Left navigation -->
    <div class="leftNav">
    	<ul id="menu">
        	<li><a href="index.php" {if $smarty.request.do == ''}class="active collapse-close"{/if}><span>{#MAIN_LINK_HOME#}</span></a></li>
            {$navi}
			{*
            {if $smarty.request.do!=''}
            <ul class="sub_stat" style="display: block; ">
            	<li><div>{#MAIN_STAT_MYSQL#} - <strong>{$mysql_size}</strong></div></li>
            	<li><div>{#MAIN_STAT_CACHE#} - <strong class="cachesize code clearCache rightDir" title="{#MAIN_STAT_CLEAR_CACHE#}" style="cursor: pointer;">{$cache_size}</strong></div></li>
            </ul>
            {/if}
			*}
        </ul>
    </div>

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