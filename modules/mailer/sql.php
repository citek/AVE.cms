<?php

/**
 * AVE.cms - Модуль Внутренней Рассылки
 *
 * @package AVE.cms
 * @subpackage module_mailer
 * @author Arcanum, val005
 * @since 2.01
 * @filesource
 */

/**
 * mySQL-запросы для установки, обновления и удаления модуля
 */

$modul_sql_install = array();
$modul_sql_deinstall = array();

$modul_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_modul_mailer_mails";
$modul_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_modul_mailer_lists";
$modul_sql_deinstall[] = "DROP TABLE IF EXISTS CPPREFIX_modul_mailer_receivers";

$modul_sql_install[] = "CREATE TABLE CPPREFIX_modul_mailer_mails (
  id int(10) unsigned NOT NULL auto_increment,
  author_id int(10) unsigned NOT NULL,
  date int(10) unsigned default NULL,
  from_name varchar(255) NOT NULL default '',
  from_email varchar(255) NOT NULL default '',
  from_copy enum('0','1') default '0',
  to_groups text NOT NULL default '',
  to_lists text NOT NULL default '',
  to_add text NOT NULL default '',
  subject varchar(255) NOT NULL default '',
  type varchar(255) NOT NULL default '',
  appeal varchar(255) NOT NULL default '',
  body longtext NULL default '',
  attach text NOT NULL default '',
  saveattach enum('0','1') default '1',
  sent enum('0','1') default '0',
  done longtext NOT NULL default '',
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";

$modul_sql_install[] = "CREATE TABLE CPPREFIX_modul_mailer_lists (
  id int(10) unsigned NOT NULL auto_increment,
  title varchar(255) NOT NULL default '',
  descr longtext NOT NULL default '',
  author_id int(10) unsigned NOT NULL,
  date int(10) unsigned default NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";

$modul_sql_install[] = "CREATE TABLE CPPREFIX_modul_mailer_receivers (
  id int(10) unsigned NOT NULL auto_increment,
  status enum('0','1','2') default '1',
  email varchar(255) NOT NULL default '',
  lastname varchar(255) NULL default '',
  firstname varchar(255) NULL default '',
  middlename varchar(255) NULL default '',
  list_id int(10) unsigned NOT NULL,
  comments text NULL default '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";

$modul_sql_update[] = "UPDATE CPPREFIX_module SET CpEngineTag = '" . $modul['CpEngineTag'] . "', CpPHPTag = '" . $modul['CpPHPTag'] . "', Version = '" . $modul['ModulVersion'] . "' WHERE ModulPfad = '" . $modul['ModulPfad'] . "' LIMIT 1;";

?>