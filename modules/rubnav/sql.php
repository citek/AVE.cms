<?php

/**
 * AVE.cms - Навигация по рубрике
 *
 * @package AVE.cms
 * @subpackage module_RubNav
 * @author Mad Den
 * @since 2.09
 * @filesource
 */

/**
 * mySQL-запросы для установки, обновления и удаления модуля
 */

$modul_sql_install = array();
$modul_sql_deinstall = array();
$modul_sql_update = array();

$modul_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_modul_rubnav;";

$modul_sql_install[] = "CREATE TABLE CPPREFIX_modul_rubnav (
  `id` mediumint(5) unsigned NOT NULL auto_increment,
  `rubnav_tmpl_next` longtext NOT NULL,
  `rubnav_tmpl_prev` longtext NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";

$modul_sql_install[] = "INSERT INTO `CPPREFIX_modul_rubnav` VALUES (1, '<a href=\"[tag:link]\">[tag:linkname]</a>', '<a href=\"[tag:link]\">[tag:linkname]</a>');";

$modul_sql_update[] = "UPDATE CPPREFIX_module SET CpEngineTag = '" . $modul['CpEngineTag'] . "', CpPHPTag = '" . $modul['CpPHPTag'] . "', Version = '" . $modul['ModulVersion'] . "' WHERE ModulPfad = '" . $modul['ModulPfad'] . "' LIMIT 1;";

?>