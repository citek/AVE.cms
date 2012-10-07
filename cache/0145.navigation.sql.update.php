<?
$AVE_DB->Real_Query("
	DELETE
	FROM " . PREFIX . "_module
	WHERE ModulPfad = 'navigation' AND ModulFunktion = 'mod_navigation'
",false);
?>