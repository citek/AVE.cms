<?
$mailer = $AVE_DB->Real_Query("
	SELECT ModulPfad
	FROM " . PREFIX . "_module
	WHERE ModulPfad = 'mailer'
") -> FetchRow();

if ($mailer -> ModulPfad == "mailer")
{
	$check = $AVE_DB->Real_Query("
		SELECT status
		FROM " . PREFIX . "_modul_mailer_receivers
	",false) -> _result;
	if($check === false)
	{
	  $AVE_DB->Real_Query("
		  ALTER TABLE `" . PREFIX . "_modul_mailer_receivers`
		  ADD
			  `status` enum('0','1','2') default '1'
		  AFTER
			  `id`
	  ");
	}
	$AVE_DB->Real_Query("
		UPDATE " . PREFIX . "_module
		SET
			Version = '2.0.1'
		WHERE ModulPfad = 'mailer'
	");
}
?>