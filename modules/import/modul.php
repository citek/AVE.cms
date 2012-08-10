<?php
if(!defined('BASE_DIR')) exit;

if (defined('ACP'))
{
    $modul['ModulName'] = "Модуль импорта";
    $modul['ModulPfad'] = "import";
    $modul['ModulVersion'] = "1.1";
    $modul['description'] = "Данный модуль предназначен для импотра документов в определенную рубрику";
    $modul['Autor'] = "censored!";
    $modul['MCopyright'] = "&copy; 2011 Volga-Info Team";
    $modul['Status'] = 1;
    $modul['IstFunktion'] = 0;
    $modul['ModulTemplate'] = 0;
    $modul['AdminEdit'] = 1;
    $modul['ModulFunktion'] = null;
    $modul['CpEngineTagTpl'] = '';
    $modul['CpEngineTag'] = null;
    $modul['CpPHPTag'] = null;
}

/**
 * Администрирование
 */
 
 function module_import_autoupdate(){
	global $AVE_DB;
	$sql="SELECT 
			Id,
			import_default_file,
			import_last_update 
		FROM ". PREFIX ."_modul_import 
		WHERE import_monitor_file != 0
		";
	$res=$AVE_DB->Query($sql);
	$rows=array();
	while ($row = $res->FetchAssocArray()){
		$rows[]=$row;
		if(file_exists(BASE_DIR.$row["import_default_file"]))
			if(filemtime(BASE_DIR.$row["import_default_file"])>$row['import_last_update'])
				{
					if (! (is_file(BASE_DIR . '/modules/import/class.import.php') &&
						@require_once(BASE_DIR . '/modules/import/class.import.php'))) module_error();
					Import::DoImport($row['Id']);
				}
	}
 }
 
if (defined('ACP') && !empty($_REQUEST['moduleaction']))
{
	if (! (is_file(BASE_DIR . '/modules/import/class.import.php') &&
		@require_once(BASE_DIR . '/modules/import/class.import.php'))) module_error();

	$tpl_dir   = BASE_DIR . '/modules/import/templates/';
	$lang_file = BASE_DIR . '/modules/import/lang/' . $_SESSION['user_language'] . '.txt';

	$AVE_Template->config_load($lang_file);

	switch ($_REQUEST['moduleaction'])
	{
		case '1':
			Import::importList($tpl_dir);
			break;

		case 'del':
			Import::importDelete($_REQUEST['id']);
			break;

		case 'edit':
			Import::importEdit(isset($_REQUEST['id']) ? $_REQUEST['id'] : null, $tpl_dir);
			break;

		case 'saveedit':
			Import::importSave(isset($_REQUEST['id']) ? $_REQUEST['id'] : null);
			break;
		case 'do':
			Import::DoImport(isset($_REQUEST['id']) ? $_REQUEST['id'] : null);
			break;
	}
}

	//module_import_autoupdate();

?>