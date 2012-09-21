<?php

/**
 * AVE.cms - Модуль Рассылки
 *
 * @package AVE.cms
 * @subpackage module_mailer
 * @author Arcanum, val005
 * @since 2.01
 * @filesource
 */

if (!defined('BASE_DIR')) exit;

if (defined('ACP'))
{
    $modul['ModulName'] = 'Рассылка';
    $modul['ModulPfad'] = 'mailer';
    $modul['ModulVersion'] = '2.0.1';
    $modul['description'] = 'Данный модуль позволяет создавать внутренние (по группам пользователей сайта), внешние (по спискам) и комбинированные рассылки. ';
    $modul['Autor'] = 'Arcanum, доработал val005';
    $modul['MCopyright'] = '&copy; 2007-2012 Overdoze.Ru';
    $modul['Status'] = 1;
    $modul['IstFunktion'] = 0;
    $modul['ModulTemplate'] = 0;
    $modul['AdminEdit'] = 1;
    $modul['ModulFunktion'] = null;
    $modul['CpEngineTagTpl'] = '';
    $modul['CpEngineTag'] = null;
    $modul['CpPHPTag'] = null;
}

if (!defined('ACP') && $_REQUEST['module'] == 'mailer' && $_REQUEST['action']=="refuse")
{
	include_once(BASE_DIR . '/modules/mailer/class.mailer.php');
	$mailer = new mailer;
	$lang_file = BASE_DIR . '/modules/mailer/lang/' . $_SESSION['admin_language'] . '.txt';
	$AVE_Template->config_load($lang_file, 'admin');

	$rec = $mailer->mailerRefuseReceiver($_REQUEST["id"]);
	if ($rec -> status != "2")
	{
		echo str_replace("%email%",$rec -> email,$AVE_Template->get_config_vars('MAILER_PUBLIC_DELREC')); 
	}
	else
	{
		echo str_replace("%email%",$rec -> email,$AVE_Template->get_config_vars('MAILER_PUBLIC_DELREC_NO'));
	}
	exit;
}

if (defined('ACP')
	&& isset($_REQUEST['moduleaction'])
	&& ! (isset($_REQUEST['action']) && $_REQUEST['action'] == 'delete')
	&& (isset($_REQUEST['mod']) && $_REQUEST['mod'] == 'mailer') )
{
	include_once(BASE_DIR . '/modules/mailer/class.mailer.php');
	$mailer = new mailer;

	if (defined('THEME_FOLDER')) $AVE_Template->assign('theme_folder', THEME_FOLDER);
	$_REQUEST['action'] = empty($_REQUEST['action']) ? 'overview' : $_REQUEST['action'];

	$tpl_dir   = BASE_DIR . '/modules/mailer/templates/';
	$lang_file = BASE_DIR . '/modules/mailer/lang/' . $_SESSION['admin_language'] . '.txt';

	$AVE_Template->config_load($lang_file, 'admin');
	$AVE_Template->assign('source', rtrim($tpl_dir, '/'));

	switch ($_REQUEST['moduleaction'])
	{
		case '':
		case '1':
			$mailer->mailerShowMails($tpl_dir);
			break;

		case 'editmail':
			include_once(BASE_DIR . '/class/class.user.php');
			$AVE_User = new AVE_User;
			$mailer->mailerEditMail($tpl_dir);
			break;
			
		case 'savemail':
			include_once(BASE_DIR . '/class/class.user.php');
			$AVE_User = new AVE_User;
			$mailer->mailerSaveMail($tpl_dir);
			break;
		
		case 'sendmail':
			$mailer->mailerSendMail();
			break;

		case 'showlists':
			$mailer->mailerShowLists($tpl_dir);
			break;

		case 'editlist':
			$mailer->mailerEditList($tpl_dir);
			break;

		case 'savelist':
			$mailer->mailerSaveList();
			break;
			
		case 'delreceiver':
			$mailer->mailerDelReceiver($_REQUEST["rec_id"]);
			break;

		case 'getfile':
			$mailer->_mailerGetFile();
			break;
		
		case 'checkemail':
			echo $mailer->_mailerCheckEmail($_REQUEST["email"],$_REQUEST["list_id"]);
			exit;
	}
}

?>