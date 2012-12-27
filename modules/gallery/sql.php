<?php

/**
 * AVE.cms - Модуль Галерея.
 *
 * @package AVE.cms
 * @subpackage module_Gallery
 * @since 1.4
 * @filesource
 */

/**
 * mySQL-запросы для установки, обновления и удаления модуля
 */

$modul_sql_install = array();
$modul_sql_deinstall = array();
$modul_sql_update = array();


$modul_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_modul_gallery;";
$modul_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_modul_gallery_images;";


$modul_sql_install[] = "CREATE TABLE `CPPREFIX_modul_gallery` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `gallery_title` varchar(255) NOT NULL,
  `gallery_description` text NOT NULL,
  `gallery_author_id` int(10) unsigned NOT NULL default '0',
  `gallery_created` int(10) unsigned NOT NULL default '0',
  `gallery_thumb_width` smallint(3) unsigned NOT NULL default '120',
  `gallery_thumb_height` smallint(3) unsigned NOT NULL default '120',
  `gallery_thumb_method` enum('c','r') NOT NULL default 'c',
  `gallery_image_on_line` tinyint(1) unsigned NOT NULL default '4',
  `gallery_image_on_page` tinyint(1) unsigned NOT NULL default '12',
  `gallery_watermark` varchar(255) NOT NULL,
  `gallery_folder` varchar(255) NOT NULL,
  `gallery_orderby` enum('datedesc','dateasc','titleasc','titledesc','position') NOT NULL default 'datedesc',
  `gallery_script` text NOT NULL,
  `gallery_image_template` text NOT NULL,
  `gallery_sepp_line` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0;";

$modul_sql_install[] = "CREATE TABLE `CPPREFIX_modul_gallery_images` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `gallery_id` int(10) unsigned NOT NULL default '0',
  `image_filename` varchar(255) NOT NULL,
  `image_author_id` int(10) unsigned NOT NULL default '0',
  `image_title` varchar(255) NOT NULL,
  `image_description` text NOT NULL,
  `image_file_ext` char(4) NOT NULL,
  `image_date` int(10) unsigned NOT NULL default '0',
  `image_position` smallint(3) unsigned NOT NULL default '1',
  `image_link` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `image_position` (`image_position`),
  KEY `image_date` (`image_date`),
  KEY `gallery_id` (`gallery_id`),
  KEY `image_title` (`image_title`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0;";

// демоданные
$modul_sql_update[] = "UPDATE CPPREFIX_module SET CpEngineTag = '" . $modul['CpEngineTag'] . "', CpPHPTag = '" . $modul['CpPHPTag'] . "', Version = '" . $modul['ModulVersion'] . "' WHERE ModulPfad = '" . $modul['ModulPfad'] . "' LIMIT 1;";

?>