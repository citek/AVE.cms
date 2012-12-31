<?
//Update module Gallery
$gallery = $AVE_DB->Real_Query("
	SELECT ModulPfad
	FROM " . PREFIX . "_module
	WHERE ModulPfad = 'gallery'
") -> FetchRow();

if ($gallery -> ModulPfad == "gallery")
{
	$check = $AVE_DB->Real_Query("
		SELECT image_link
		FROM " . PREFIX . "_modul_gallery_images
	",false) -> _result;
	if($check === false)
	{
		$AVE_DB->Real_Query("
			ALTER TABLE `".PREFIX."_modul_gallery_images`
			ADD
				`image_link`
			varchar(255) NOT NULL default '' AFTER
				`image_position`
			";
	}
}
?>