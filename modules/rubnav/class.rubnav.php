<?php

/**
 * AVE.cms - Навигация по рубрике
 *
 * @filesource
 */

/**
 * Класс работы с Навигация по рубрике
 *
 * @package AVE.cms
 * @subpackage module_RubNav
 */

class rubnav
{
	/**
	 * Путь к директории с шаблонами модуля
	 *
	 * @var string
	 */
	var $_tpl_dir;

	/**
	 * Путь к языковому файлу
	 *
	 * @var string
	 */
	var $_lang_file;


	/**
	 * Конструктор
	 *
	 * @param string $tpl_dir путь к директории с шаблонами модуля
	 * @param string $lang_file путь к языковому файлу
	 * @return Login
	 */
	function RubNav($tpl_dir, $lang_file)
	{
		$this->_tpl_dir   = $tpl_dir;
		$this->_lang_file = $lang_file;
	}

	/**
	 * Управление модулем Навигация по рубрике
	 *
	 */
	function _rubnavSettingsGet($field = '')
	{
		global $AVE_DB;

		static $settings = null;

		if ($settings === null)
		{
			$settings = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_rubnav
				WHERE Id = 1
			")->FetchAssocArray();
		}
		if ($field == '') return $settings;
		return (isset($settings[$field]) ? $settings[$field] : null);
	}

	function _rubnavRubricsGet()
	{
		global $AVE_DB, $AVE_Template;

		$rubrics = array();
		$sql = $AVE_DB->Query("SELECT * FROM " . PREFIX . "_rubrics");
		while ($result = $sql->FetchRow())
		{
			array_push($rubrics, $result);
		}
		$AVE_Template->assign('rubrics', $rubrics);
	}

	function rubnavSettingsEdit()
	{
		global $AVE_DB, $AVE_Template;

		if (isset($_REQUEST['sub']) && $_REQUEST['sub'] == 'save')
		{
			$AVE_DB->Query("
				UPDATE " . PREFIX . "_modul_rubnav
				SET
					rubnav_tmpl_next    = '" . $_REQUEST['rubnav_tmpl_next'] . "',
					rubnav_tmpl_prev    = '" . $_REQUEST['rubnav_tmpl_prev'] . "'
				WHERE
					id = 1
			");

			header('Location:index.php?do=modules&action=modedit&mod=rubnav&moduleaction=1&cp=' . SESSION);
			exit;
		}

		$row = $this->_rubnavSettingsGet();

		$AVE_Template->assign($row);

		$AVE_Template->config_load($this->_lang_file, 'showconfig');
		$AVE_Template->assign('content', $AVE_Template->fetch($this->_tpl_dir . 'admin_config.tpl'));
	}
}
?>