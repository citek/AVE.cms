<?
$AVE_DB->Real_Query("
	DELETE
	FROM " . PREFIX . "_module
	WHERE ModulPfad = 'sysblock' AND ModulFunktion = 'mod_sysblock'
",false);
?>