<?php

/**
 * Класс работы с рейтингом документов
 *
 * @package AVE.cms
 * @subpackage mod_rating
 * @since 1.0a
 * @filesource
 */

class docRating
{
	/**
	 * Выводим рейтинг
	 *
	 */
	function ShowRating($tpl_dir, $lang_file)
	{
		global $AVE_DB, $AVE_Template;

		$AVE_Template->config_load($lang_file);

		$persent = 0;
		$rating_count = 0;

		$row_rating = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_rating
			WHERE Id = '" .(int)$_REQUEST['id'] . "'
		")->FetchRow();

		if ($row_rating)
		{
			if ( $row_rating->rating_count != 0) $persent = intval($row_rating->rating_sum)/intval($row_rating->rating_count)*20;
			$rating_count = $row_rating->rating_count;
		};

		$assign['rating_count'] = $rating_count;
		$assign['rating_persent'] = $persent;
		$assign['doc_id_rating'] = (int)$_REQUEST['id'];

		$AVE_Template->assign($assign);
		$AVE_Template->display($tpl_dir . 'rating.tpl');
	}

	function Rating_Vote($lang_file)
	{
		global $AVE_DB, $AVE_Template;

		$user_rating = (int)$_REQUEST['user_rating'];
		if ( !($user_rating >= 1  &&  $user_rating <= 5) ) exit;


		$AVE_Template->config_load($lang_file);

		$userIP =  $_SERVER['REMOTE_ADDR'];
		$row_rating = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_rating
			WHERE Id = ".$_REQUEST['id']
		)->FetchRow();

	if ($row_rating)
	{
		// Вие вече сте оценили този продукт
		if ($userIP != ($row_rating->lastip))
		{
			$AVE_DB->Query("UPDATE ". PREFIX . "_modul_rating
				SET
					rating_count = rating_count + 1,
					rating_sum   = rating_sum + ". $user_rating . ",
					lastip = '". $userIP ."'
				WHERE Id = ". $_REQUEST['id']
				);
			echo $AVE_Template->get_config_vars('RATING_THANKS');  //'Благодарим за оценку!';
			exit;
		} else {
			echo $AVE_Template->get_config_vars('RATING_ALREADY');   //'Вы уже выставили оценку!';
			exit;
		}
	} else {
		  // добавяне на нов ред във файла
		  $AVE_DB->Query("INSERT INTO " . PREFIX . "_modul_rating
									(
										Id,
										rating_count,
										rating_sum,
										lastip
									) VALUES (
										'" . $_REQUEST['id'] . "',
									    '1',
										'" . $_REQUEST['user_rating'] . "',
										'" . $_SERVER['REMOTE_ADDR'] . "')"
								   );
		 
          echo $AVE_Template->get_config_vars('RATING_THANKS'); //'Благодарим за оценку!'
          exit;
	}
	exit;
  }

  function getVotesNum($lang_file)
  {
	 global $AVE_DB, $AVE_Template;

	 $AVE_Template->config_load($lang_file);

	 $row_rating = $AVE_DB->Query("SELECT
									  * FROM " . PREFIX . "_modul_rating
									WHERE
									   Id = ".$_REQUEST['id'] )->FetchRow();

	 if ($row_rating) $rating_count = intval($row_rating->rating_count);
	 else $rating_count=0;
	  echo "(".$rating_count.$AVE_Template->get_config_vars('RATING_VOTES').")";
	  exit;
  }

  function getVotesPercent()
  {
	  global $AVE_DB;

	  $persent = 0;
	  $sql = $AVE_DB->Query("SELECT
									  * FROM " . PREFIX . "_modul_rating
									WHERE
									   Id = ".$_REQUEST['id'] );
	 $row_rating = $sql->fetchrow();
	 if (!is_null($row_rating) && $row_rating->rating_count != 0)
	 {
		  $persent = intval($row_rating->rating_sum)/intval($row_rating->rating_count)*20;
	 }
	 echo $persent;
	 exit;

  }
}

?>