<?php
if(!defined('BASE_DIR')) exit;

if (defined('ACP'))
{
    $modul['ModulName'] = "Публикатор документов";
    $modul['ModulPfad'] = "editdoc";
    $modul['ModulVersion'] = "1.0";
    $modul['description'] = "Данный модуль предназначен для создания форм ввода и редактирования документов на сайте";
    $modul['Autor'] = "Ave.cms Team";
    $modul['MCopyright'] = "&copy; 2012 Ave-cms.ru";
    $modul['Status'] = 1;
    $modul['IstFunktion'] = 1;
    $modul['ModulTemplate'] = 0;
    $modul['AdminEdit'] = 1;
    $modul['ModulFunktion'] = "mod_editdoc";
    $modul['CpEngineTagTpl'] = '[mod_editdoc:XXX]';
    $modul['CpEngineTag'] = '#\\\[mod_editdoc:(\\\d+)]#';
    $modul['CpPHPTag'] = "<?php mod_editdoc(''$1''); ?>";
}

 
function mod_editdoc($id)
{
	global $AVE_DB, $AVE_Core, $AVE_Template;
	if (! (is_file(BASE_DIR . '/modules/editdoc/class.editdoc.php') &&
		@require_once(BASE_DIR . '/modules/editdoc/class.editdoc.php')))  module_error();
		echo editdoc::EditDocDo($id);
		
}
/**
 * Администрирование
 */
 
if (defined('ACP') && !empty($_REQUEST['moduleaction']))
{
	if (! (is_file(BASE_DIR . '/modules/editdoc/class.editdoc.php') &&
		@require_once(BASE_DIR . '/modules/editdoc/class.editdoc.php')))  module_error();

	$tpl_dir   = BASE_DIR . '/modules/editdoc/templates/';
	$lang_file = BASE_DIR . '/modules/editdoc/lang/' . $_SESSION['user_language'] . '.txt';

	$AVE_Template->config_load($lang_file);
	switch ($_REQUEST['moduleaction'])
	{
		case '1':
			editdoc::EditDocList($tpl_dir);
			break;

		case 'del':
			editdoc::EditDocDelete($_REQUEST['id']);
			break;

		case 'new':
			editdoc::EditDocNew($tpl_dir);
			break;

		case 'edit':
			editdoc::EditDocEdit(isset($_REQUEST['id']) ? $_REQUEST['id'] : null, $tpl_dir);
			break;

		case 'saveedit':
			editdoc::EditDocSave(isset($_REQUEST['id']) ? $_REQUEST['id'] : null);
			break;
	}
}

?>