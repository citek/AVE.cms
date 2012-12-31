<?
//Update module Contacts
$contact = $AVE_DB->Real_Query("
	SELECT ModulPfad
	FROM " . PREFIX . "_module
	WHERE ModulPfad = 'contact'
") -> FetchRow();

if ($contact -> ModulPfad == "contact")
{
	$check = $AVE_DB->Real_Query("
		SELECT contact_form_message_scripts
		FROM " . PREFIX . "_modul_contacts
	",false) -> _result;
	if($check === false)
	{
		$AVE_DB->Real_Query("
			ALTER TABLE `".PREFIX."_modul_contacts`
			ADD
				`contact_form_message_scripts`
			 text NOT NULL default '' AFTER
				`contact_form_message_noaccess`
			";
	}
}
?>