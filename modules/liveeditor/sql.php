<?php
/**
 * AVE.cms - Модуль настройки LiveEditor
 * @package AVE.cms
 * @subpackage module_LiveEditor
 * @author Repellent
 * @since 1.0
 * @filesource
 */

/**
 * mySQL-запросы для установки, обновления и удаления модуля
 */
$modul_sql_install = array();
$modul_sql_deinstall = array();
$modul_sql_update = array();
$modul_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_modul_liveeditor;";
$modul_sql_install[] = "CREATE TABLE CPPREFIX_modul_liveeditor (
  `id` mediumint(5) unsigned NOT NULL auto_increment,
  `liveeditor_name` varchar(255) NOT NULL,
  `liveeditor_fields` mediumint(2) unsigned NOT NULL,
  `liveeditor_status` mediumint(1) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";
$modul_sql_install[] = "INSERT INTO CPPREFIX_modul_liveeditor VALUES (1, 'Настройка редактора по умолчанию № 1', '1', '1');";
$modul_sql_install[] = "INSERT INTO CPPREFIX_modul_liveeditor VALUES (2, 'Настройка редактора по умолчанию № 2', '2', '1');";
$modul_sql_update[] = "UPDATE CPPREFIX_module SET CpEngineTag = '" . $modul['CpEngineTag'] . "', CpPHPTag = '" . $modul['CpPHPTag'] . "', Version = '" . $modul['ModulVersion'] . "' WHERE ModulPfad = '" . $modul['ModulPfad'] . "' LIMIT 1;";
?>