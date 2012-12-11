<?php
/**
 * AVE.cms - Модуль настройки LiveEditor
 * @package AVE.cms
 * @subpackage module_LiveEditor
 * @author Repellent
 * @since 1.0
 * @filesource
 */
if (!defined('BASE_DIR')) exit;
if (defined('ACP'))
{
    $modul['ModulName'] = 'Настройки LiveEditor';
    $modul['ModulPfad'] = 'liveeditor';
    $modul['ModulVersion'] = '1.0';
    $modul['description'] = 'Настраивайте редактор, согласно своим предпочтениям!';
    $modul['Autor'] = 'Repellent';
    $modul['MCopyright'] = '&copy; 2012 Web Design Studio 3V & Overdoze Team';
    $modul['Status'] = 1;
    $modul['IstFunktion'] = 0;
    $modul['AdminEdit'] = 1;
    $modul['ModulTemplate'] = 0;
    $modul['ModulFunktion'] = null;
    $modul['CpEngineTagTpl'] = '';
    $modul['CpEngineTag'] = null;
    $modul['CpPHPTag'] = null;
}
/**
 * Администрирование
 */
if (defined('ACP') && !empty($_REQUEST['moduleaction']))
{
	if (! @require_once(BASE_DIR . '/modules/liveeditor/class.liveeditor.php')) module_error();

	$tpl_dir   = BASE_DIR . '/modules/liveeditor/templates/';
	$lang_file = BASE_DIR . '/modules/liveeditor/lang/' . $_SESSION['user_language'] . '.txt';

	$AVE_Template->config_load($lang_file);

	switch ($_REQUEST['moduleaction'])
	{
		case '1':
			liveeditor::liveeditorList($tpl_dir);
			break;

		case 'del':
			liveeditor::liveeditorDelete($_REQUEST['id']);
			break;

		case 'edit':
			liveeditor::liveeditorEdit(isset($_REQUEST['id']) ? $_REQUEST['id'] : null, $tpl_dir);
			break;

		case 'saveedit':
			liveeditor::liveeditorSave(isset($_REQUEST['id']) ? $_REQUEST['id'] : null);
			break;
			
		case 'reg':
			liveeditor::liveeditorReg($tpl_dir);
			break;	
	}
}
?>