<?
$mailer = $AVE_DB->Real_Query("
	SELECT ModulPfad
	FROM " . PREFIX . "_module
	WHERE ModulPfad = 'mailer'
") -> FetchRow();

if ($mailer -> ModulPfad == "mailer")
{
	$check = $AVE_DB->Real_Query("
		SELECT from_copy
		FROM " . PREFIX . "_modul_mailer_mails
	") -> _result;
	if($check === false)
	{
		$AVE_DB->Real_Query("
			ALTER TABLE `" . PREFIX . "_modul_mailer_mails`
			ADD
				`from_copy` enum('1','0') default '0'
			AFTER
				`from_email`
		");
	}

	$check = $AVE_DB->Real_Query("
		SELECT to_add
		FROM " . PREFIX . "_modul_mailer_mails
	") -> _result;
	if($check === false)
	{
		$AVE_DB->Real_Query("
			ALTER TABLE `" . PREFIX . "_modul_mailer_mails`
			ADD
				`to_add` text NOT NULL default ''
			AFTER
				`to_lists`
		");
	}
	$AVE_DB->Real_Query("
		UPDATE " . PREFIX . "_module
		SET
			Version = '2.0b'
		WHERE ModulPfad = 'mailer'
	");
}
?>