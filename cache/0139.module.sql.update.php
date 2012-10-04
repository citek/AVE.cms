<?
$mailer = $AVE_DB->Real_Query("
	SELECT ModulPfad
	FROM " . PREFIX . "_module
	WHERE ModulPfad = 'mailer'
") -> FetchRow();

if ($mailer -> ModulPfad == "mailer")
{
	$check = $AVE_DB->Real_Query("
		SELECT date
		FROM " . PREFIX . "_modul_mailer_receivers
	",false) -> _result;
	if($check === false)
	{
		$AVE_DB->Real_Query("
			ALTER TABLE `" . PREFIX . "_modul_mailer_receivers`
			ADD
				`date` int(10) unsigned default NULL
			AFTER
				`comments`
		");
	}
	$AVE_DB->Real_Query("
		UPDATE " . PREFIX . "_module
		SET
			Version = '2.1',
			ModulName = 'Рассылка / Подписка'
		WHERE ModulPfad = 'mailer'
	");
}
?>