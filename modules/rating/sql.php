<?php

/**
 * AVE.cms - Модуль Рейтинг документов.
 *
 * @package AVE.cms
 * @subpackage mod_rating
 * @since 1.0
 * @filesource
 */

/**
 * mySQL-запросы для установки, обновления и удаления модуля
 */

$modul_sql_install = array();
$modul_sql_deinstall = array();
$modul_sql_update = array();

$modul_sql_deinstall[] = "DROP TABLE IF EXISTS `CPPREFIX_modul_rating`;";

$modul_sql_install[] = "CREATE TABLE `CPPREFIX_modul_rating` (
  `Id` int(10) unsigned NOT NULL,
  `rating_count` int(10) NOT NULL,
  `rating_sum` int(10) NOT NULL,
  `lastip` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0;";

// демоданные
$modul_sql_update[] = "UPDATE CPPREFIX_module SET CpEngineTag = '" . $modul['CpEngineTag'] . "', CpPHPTag = '" . $modul['CpPHPTag'] . "', Version = '" . $modul['ModulVersion'] . "' WHERE ModulPfad = '" . $modul['ModulPfad'] . "' LIMIT 1;";

?>