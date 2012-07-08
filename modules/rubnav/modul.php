<?php

/**
 * AVE.cms - Модуль Навигация по документам рубрики
 *
 * @package AVE.cms
 * @subpackage rubnav
 * @since 1.0a
 * @filesource
 */

if (!defined('BASE_DIR')) exit;

if (defined('ACP'))
{
	$modul['ModulName'] = 'Навигация по рубрике';
	$modul['ModulPfad'] = 'rubnav';
	$modul['ModulVersion'] = '1.0a';
	$modul['description'] = 'Навигация по документам в пределах рубрики (следущая-предыдущая)<br />Инструкция:<br />[mod_rubnav:next] - следущая<br />[mod_rubnav:prev] - предыдущая';
	$modul['Autor'] = 'M@d Den';
	$modul['MCopyright'] = '&copy; 2012 Overdoze Team';
    $modul['Status'] = 1;
    $modul['IstFunktion'] = 1;
    $modul['ModulTemplate'] = 0;
    $modul['AdminEdit'] = 1;
	$modul['ModulFunktion'] = 'mod_rubnav';
	$modul['CpEngineTagTpl'] = '[mod_rubnav:XXX]';
	$modul['CpEngineTag'] = '#\\\[mod_rubnav:([a-zA-Z0-9]+)]#';
	$modul['CpPHPTag'] = "<?php mod_rubnav(''$1''); ?>";
}

if (defined('ACP') && !(isset($_REQUEST['action']) && $_REQUEST['action'] == 'delete'))
{
	$modul_sql_update = array();
	$modul_sql_update[] = "UPDATE CPPREFIX_module SET CpEngineTag = '" . $modul['CpEngineTag'] . "', CpPHPTag = '" . $modul['CpPHPTag'] . "', Version = '" . $modul['ModulVersion'] . "' WHERE ModulPfad = '" . $modul['ModulPfad'] . "' LIMIT 1;";
}

/**
 * Обработка тэга модуля
 *
 */
function mod_rubnav($data)
{
	global $AVE_DB, $AVE_Core;

	$row_templ = $AVE_DB->Query("
		SELECT *
		FROM " . PREFIX . "_modul_rubnav
		WHERE Id = 1
	")->FetchRow();

	if ($data == "next")
	{
		$next_link = '';
		$row = $AVE_DB->Query("
			SELECT
				Id,
				document_alias,
				document_title
			FROM " . PREFIX . "_documents
		   		WHERE Id > '2'
				AND Id != '" . $AVE_Core->curentdoc->Id . "'
				AND rubric_id = '" . $AVE_Core->curentdoc->rubric_id . "'
				AND document_published >= '" . $AVE_Core->curentdoc->document_published . "'
				AND (document_expire = 0 || document_expire > UNIX_TIMESTAMP())
				AND (document_published = 0 || document_published < UNIX_TIMESTAMP())
				AND document_deleted = '0'
				AND document_status = '1'
			ORDER BY document_published ASC
			LIMIT 0,1
			 ")
			 ->fetchRow();
		 if ($row)
		 {

			$search = array('[tag:link]','[tag:linkname]');
			$replace = array(
			rewrite_link('index.php?id=' . $row->Id . '&amp;doc=' . (empty($row->document_alias) ? prepare_url($row->document_title) : $row->document_alias)),
			$row->document_title
			);

			$next_link = str_replace($search, $replace, $row_templ->rubnav_tmpl_next);
		 }
		 echo $next_link;
	}
	else if ($data == "prev")
	{
		//Функция перехода на предыдущую страницу в данной рубрике
		$prev_link = '';
		$row = $AVE_DB->Query("
			SELECT
				Id,
				document_alias,
				document_title
			FROM " . PREFIX . "_documents
		   		WHERE Id > '2'
				AND Id != '" . $AVE_Core->curentdoc->Id . "'
				AND rubric_id = '" . $AVE_Core->curentdoc->rubric_id . "'
				AND document_published <= '" . $AVE_Core->curentdoc->document_published . "'
				AND (document_expire = 0 || document_expire > UNIX_TIMESTAMP())
				AND (document_published = 0 || document_published < UNIX_TIMESTAMP())
				AND document_deleted = '0'
				AND document_status = '1'
			ORDER BY document_published DESC
			LIMIT 0,1
			 ")
			 ->fetchRow();
		if ($row)
		{
			$search = array('[tag:link]','[tag:linkname]');
			$replace = array(
			rewrite_link('index.php?id=' . $row->Id . '&amp;doc=' . (empty($row->document_alias) ? prepare_url($row->document_title) : $row->document_alias)),
			$row->document_title
			);

			$prev_link = str_replace($search, $replace, $row_templ->rubnav_tmpl_next);
		}
		echo $prev_link;
	}
}

/**
 * Администрирование
 */
if (defined('ACP') && !empty($_REQUEST['moduleaction']))
{
	global $rubric_list;

	$tpl_dir   = BASE_DIR . '/modules/rubnav/templates/';
	$lang_file = BASE_DIR . '/modules/rubnav/lang/' . $_SESSION['admin_language'] . '.txt';

	if (! @require(BASE_DIR . '/modules/rubnav/class.rubnav.php')) module_error();

	$rubric_list = new RubNav($tpl_dir, $lang_file);

	switch($_REQUEST['moduleaction'])
	{
		case '1':
			$rubric_list->rubnavSettingsEdit();
			break;
	}
}
?>