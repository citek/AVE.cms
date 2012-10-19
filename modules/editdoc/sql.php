<?php
/**
 * AVE.cms - Модуль Системные блоки
 *
 * @package AVE.cms
 * @subpackage module_SysBlock
 * @author Mad Den
 * @since 2.07
 * @filesource
 */

/**
 * mySQL-запросы для установки, обновления и удаления модуля
 */

$modul_sql_install = array();
$modul_sql_deinstall = array();
$modul_sql_update = array();

$modul_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_modul_editdoc;";

$modul_sql_install[] = "CREATE TABLE CPPREFIX_modul_editdoc (
  `id` mediumint(5) unsigned NOT NULL auto_increment,
  `editdoc_lastchange` int(10) unsigned default NULL,
  `editdoc_name` varchar(255) NOT NULL,
  `editdoc_rub` int(10) unsigned default NULL,
  `editdoc_template` longtext NOT NULL,
  `editdoc_fill_filters` longtext NOT NULL,
  `editdoc_afteredit` longtext NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";

$modul_sql_update[] = "UPDATE CPPREFIX_module SET CpEngineTag = '" . $modul['CpEngineTag'] . "', CpPHPTag = '" . $modul['CpPHPTag'] . "', Version = '" . $modul['ModulVersion'] . "' WHERE ModulPfad = '" . $modul['ModulPfad'] . "' LIMIT 1;";
?>