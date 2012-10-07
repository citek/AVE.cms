<?
$CheckSQL="SELECT * FROM ".PREFIX."_sysblocks";
$UpdateSQL=Array();
$UpdateSQL[]="CREATE TABLE ".PREFIX."_sysblocks (
  `id` mediumint(5) unsigned NOT NULL auto_increment,
  `sysblock_name` varchar(255) NOT NULL,
  `sysblock_text` longtext NOT NULL,
  `sysblock_active` enum('0','1') NOT NULL default '1',
  `sysblock_author_id` int(10) unsigned NOT NULL default '1',
  `sysblock_created` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";
$res=$AVE_DB->Real_Query($CheckSQL,false);
if($res->_result===false)
{
 foreach($UpdateSQL as $v)
  $AVE_DB->Real_Query($v);
}
?>