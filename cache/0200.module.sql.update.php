<?
//Update module Gallery
$CheckSQL="SELECT image_link FROM ".PREFIX."_modul_gallery_images";
$UpdateSQL=Array();

$UpdateSQL[]="ALTER TABLE `".PREFIX."_modul_gallery_images`
	ADD
		`image_link`
	 varchar(255) NOT NULL default '' AFTER
		`image_position`
	";
$res=$AVE_DB->Real_Query($CheckSQL,false);
if($res->_result===false)
{
	foreach($UpdateSQL as $v)
		$AVE_DB->Real_Query($v,false);
}

//Update module Contacts
$CheckSQL="SELECT contact_form_message_scripts FROM ".PREFIX."_modul_contacts";
$UpdateSQL=Array();

$UpdateSQL[]="ALTER TABLE `".PREFIX."_modul_contacts`
	ADD
		`contact_form_message_scripts`
	 text NOT NULL default '' AFTER
		`contact_form_message_noaccess`
	";
$res=$AVE_DB->Real_Query($CheckSQL,false);
if($res->_result===false)
{
	foreach($UpdateSQL as $v)
		$AVE_DB->Real_Query($v,false);
}
?>