<?
$import = $AVE_DB->Real_Query("
	SELECT ModulPfad
	FROM " . PREFIX . "_module
	WHERE ModulPfad = 'import'
") -> FetchRow();

if ($import -> ModulPfad == "import")
{
	$check = $AVE_DB->Real_Query("
		SELECT import_delete_docs
		FROM " . PREFIX . "_modul_import
	",false) -> _result;
	if($check === false)
	{
		$AVE_DB->Real_Query("
			ALTER TABLE `" . PREFIX . "_modul_import`
			ADD
				`import_delete_docs` enum('0', '1') NOT NULL default '0'
			AFTER
				`import_parser`
		");
	}
	$AVE_DB->Real_Query("
		UPDATE " . PREFIX . "_module
		SET
			Version = '1.2'
		WHERE ModulPfad = 'import'
	");
}
?>