<?
//Update module Gallery
$CheckSQL="SELECT image_status FROM ".PREFIX."_modul_gallery_images";
$UpdateSQL=Array();

$UpdateSQL[]="ALTER TABLE `".PREFIX."_modul_gallery_images`
	ADD
		`image_status`
	enum('1','0') NOT NULL DEFAULT '1' AFTER
		`image_link`
	";
$res=$AVE_DB->Real_Query($CheckSQL,false);
if($res->_result===false)
{
	foreach($UpdateSQL as $v)
		$AVE_DB->Real_Query($v,false);
}
?>