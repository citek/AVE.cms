<?
$mailer = $AVE_DB->Real_Query("
	SELECT ModulPfad
	FROM " . PREFIX . "_module
	WHERE ModulPfad = 'mailer'
") -> FetchRow();

if ($mailer -> ModulPfad == "mailer")
{
	$check = $AVE_DB->Real_Query("
		SELECT timing
		FROM " . PREFIX . "_modul_mailer_mails
	",false) -> _result;
	if($check === false)
	{
		$AVE_DB->Real_Query("
			ALTER TABLE `" . PREFIX . "_modul_mailer_mails`
			ADD
				`timing` varchar(255) NOT NULL default ''
			AFTER
				`saveattach`
		");
	}
	$AVE_DB->Real_Query("
		UPDATE " . PREFIX . "_module
		SET
			Version = '2.2',
			ModulName = 'Рассылка / Подписка'
		WHERE ModulPfad = 'mailer'
	");
}
?>