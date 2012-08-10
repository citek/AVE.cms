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

$modul_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_modul_import;";

$modul_sql_install[] = "CREATE TABLE CPPREFIX_modul_import (
  `id` mediumint(5) unsigned NOT NULL auto_increment,
  `import_name` varchar(255) NOT NULL,
  `import_rub` int(10) unsigned default NULL,
  `import_parser` varchar(255) NOT NULL,
  `import_default_file` varchar(255) NOT NULL,
  `import_monitor_file` enum('0','1') NOT NULL,
  `import_last_update` int(10) unsigned default NULL,
  `import_text` longtext NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";

$modul_sql_update[] = "UPDATE CPPREFIX_module SET CpEngineTag = '" . $modul['CpEngineTag'] . "', CpPHPTag = '" . $modul['CpPHPTag'] . "', Version = '" . $modul['ModulVersion'] . "' WHERE ModulPfad = '" . $modul['ModulPfad'] . "' LIMIT 1;";
//var_dump($modul_sql_update);
?>