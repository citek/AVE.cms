<?php

/**
 * AVE.cms - Модуль Рейтинг документов
 *
 * @package AVE.cms
 * @subpackage mod_rating
 * @since 1.0
 * @filesource
 */

if(!defined('BASE_DIR')) exit;

if (defined('ACP'))
{
    $modul['ModulName'] = "Рейтинг документов";
    $modul['ModulPfad'] = "rating";
    $modul['ModulVersion'] = "1.0";
    $modul['description'] = "Звездный рейтинг документов";
    $modul['Autor'] = "Overdoze Team";
    $modul['MCopyright'] = "&copy; 2012 Overdoze Team";
    $modul['Status'] = 1;
    $modul['IstFunktion'] = 1;
    $modul['AdminEdit'] = 0;
    $modul['ModulFunktion'] = "mod_rating";
    $modul['CpEngineTagTpl'] = "[mod_rating]";
    $modul['CpEngineTag'] = "#\\\[mod_rating]#";
    $modul['CpPHPTag'] = "<?php mod_rating(); ?>";
}

function mod_rating()
{
	global $AVE_DB, $AVE_Template;

	require_once(BASE_DIR . '/modules/rating/class.rating.php');

	$rating = new docRating;

	$tpl_dir = BASE_DIR . '/modules/rating/templates/';
	$lang_file = BASE_DIR . '/modules/rating/lang/' . $_SESSION['user_language'] . '.txt';

	$rating->ShowRating($tpl_dir, $lang_file);

}

if (!defined('ACP') && !empty($_REQUEST['action']) && isset($_REQUEST['module']) && $_REQUEST['module'] == 'rating')
{
	global $rating;

	require_once(BASE_DIR . '/modules/rating/class.rating.php');

	$rating = new docRating;

	$lang_file = BASE_DIR . '/modules/rating/lang/' . $_SESSION['user_language'] . '.txt';

    switch($_REQUEST['action'])
	{
		case 'vote': // Учет голоса
			$rating->Rating_Vote($lang_file);
			break;

		case 'getVotesNum': // Сумма голосов
			$rating->getVotesNum($lang_file);
			break;

		case 'getVotesPercent': // Процент голосов
			$rating->getVotesPercent();
			break;
	}
}

?>