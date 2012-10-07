<?php

/**
 * AVE.cms - Навигация
 *
 * @package AVE.cms
 * @filesource
 */


/**
 * Функция обработки
 *
 * @param int $navigation_id - идентификатор меню навигации
 */

function parse_navigation($navigation_id)
{
	global $AVE_DB, $AVE_Core;

	if (is_array($navigation_id)) $navigation_id = $navigation_id[1];

	static $navigations = array();

	// убираем не цифры
	$navigation_id  = preg_replace('/\D/', '', $navigation_id);

	if (isset($navigations[$navigation_id]))
	{
		echo $navigations[$navigation_id];
		return;
	}

	$nav = get_navigations($navigation_id);

	if (!$nav)
	{
		echo 'Menu ', $navigation_id, ' not found';
		return;
	}

	if (!defined('UGROUP')) define('UGROUP', 2);
	if (!in_array(UGROUP, $nav->navi_user_group)) return;

	if (empty($_REQUEST['module']))
	{

		$curent_doc_id = (isset($_GET['id']) && is_numeric($_GET['id'])) ? $_GET['id'] : 1;

		$row_navi = $AVE_DB->Query("
			SELECT CONCAT_WS(',', nav.Id, nav.parent_id, nav2.parent_id)
			FROM
				" . PREFIX . "_navigation_items AS nav
			JOIN
				" . PREFIX . "_documents AS doc
			LEFT JOIN
				" . PREFIX . "_navigation_items AS nav2 ON nav2.Id = nav.parent_id
			WHERE nav.navi_item_status = 1
			AND nav.navi_id = '" . $navigation_id . "'
			AND doc.Id = '" . $curent_doc_id . "'
			AND (nav.navi_item_link = 'index.php?id=" . $curent_doc_id . "'"
				. ((!empty($AVE_Core->curentdoc->document_alias) && $AVE_Core->curentdoc->Id == $curent_doc_id) ? " OR nav.document_alias = '" . $AVE_Core->curentdoc->document_alias . "'" : '')
				. " OR nav.Id = doc.document_linked_navi_id)
		")->GetCell();
	}
	else
	{

		@$extended_by_module = "(nav.navi_item_link LIKE '%%" . $refurl2 . "%%')";
		@$extended_by_module2 = "(nav.document_alias LIKE '%%" . $refurl2 . "%%')";

		
		$row_navi = $AVE_DB->Query("
			SELECT CONCAT_WS(',',nav.Id, nav.parent_id, nav2.parent_id)
			FROM
				" . PREFIX . "_navigation_items AS nav
			".$conect."
			LEFT JOIN
				" . PREFIX . "_navigation_items AS nav2 ON nav2.Id = nav.parent_id
			WHERE nav.navi_item_status = '1'
			AND nav.navi_id = '" . $navigation_id . "'
			$reqest
		")->GetCell();

		if(empty($row_navi))
		{
			$row_navi = $AVE_DB->Query("
				SELECT CONCAT_WS(',',nav.parent_id, nav2.parent_id)
				FROM
					" . PREFIX . "_navigation_items AS nav
				LEFT JOIN
					" . PREFIX . "_navigation_items AS nav2 ON nav2.Id = nav.parent_id
				WHERE nav.navi_item_status = '1'
				AND nav.navi_id = '" . $navigation_id . "'
				AND $extended_by_module2
			")->GetCell();
		}	

		
	}
	$where_elter = '';
#########################################
#########################################

	if ($row_navi !== false)
	{
		$way = explode(',', $row_navi);
		if ($nav->navi_expand!=1) $where_elter = "AND parent_id IN(0," . $row_navi . ")";
	}
	else
	{
		$way = array('');
		if ($nav->navi_expand!=1) $where_elter = "AND parent_id = 0";
	}

	$nav_items = array();
	$sql = $AVE_DB->Query("
		SELECT *
		FROM " . PREFIX . "_navigation_items
		WHERE navi_item_status = '1'
		AND navi_id = '" . $navigation_id . "'
		" . $where_elter . "
		ORDER BY navi_item_position ASC
	");

	while ($row_nav_item = $sql->FetchAssocArray())
	{
		$nav_items[$row_nav_item['parent_id']][] = $row_nav_item;
	}

	$ebenen = array(
		1 =>  array(
			'aktiv' => str_replace('[tag:mediapath]', ABS_PATH . 'templates/' . THEME_FOLDER . '/', $nav->navi_level1active),
			'inaktiv' => str_replace('[tag:mediapath]', ABS_PATH . 'templates/' . THEME_FOLDER . '/', $nav->navi_level1),
		),
		2 =>  array(
			'aktiv' => str_replace('[tag:mediapath]', ABS_PATH . 'templates/' . THEME_FOLDER . '/', $nav->navi_level2active),
			'inaktiv' => str_replace('[tag:mediapath]', ABS_PATH . 'templates/' . THEME_FOLDER . '/', $nav->navi_level2),
		),
		3 =>  array(
			'aktiv' => str_replace('[tag:mediapath]', ABS_PATH . 'templates/' . THEME_FOLDER . '/', $nav->navi_level3active),
			'inaktiv' => str_replace('[tag:mediapath]', ABS_PATH . 'templates/' . THEME_FOLDER . '/', $nav->navi_level3),
		)
	);

	$END = printNavi($ebenen, $way, $navigation_id, $nav_items, $nav);

	$END = rewrite_link($END);
	$END = preg_replace("/(^[\r\n]*|[\r\n]+)[\s\t]*[\r\n]+/", "\n", $END);
	$END = str_replace(array("\n","\r"),'',$END);

	$navigations[$navigation_id] = $END;

	echo $END;
}

/**
 * Рекурсивная функция для формирования меню навигации
 *
 * @param string $navi
 * @param int $ebenen
 * @param string $way
 * @param int $rub
 * @param array $nav_items
 * @param string $row_ul
 * @param int $parent
 */
function printNavi($ebenen, $way, $rub, $nav_items, $row_ul, $parent = 0)
{
	// определяем уровень
	$ebene = $nav_items[$parent][0]['navi_item_level'];

	// собираем каждый пункт в переменной $act
	foreach ((array)$nav_items[$parent] as $row)
	{
		@$aktiv = (in_array($row['Id'], $way)) ? 'aktiv' : 'inaktiv';
		@$akt = str_replace('[tag:linkname]', $row['title'], $ebenen[$ebene][$aktiv]);
		@$akt = str_replace('[tag:linkid]', $row['Id'], $akt);
		
		@$img = explode(".", $row['navi_item_Img']);
		@$row['Img_act'] = $img[0]."_act.".$img[1];
	
		@$akt = str_replace('[tag:desc]', stripslashes($row['navi_item_desc']), $akt);
		@$akt = str_replace('[tag:img]', stripslashes($row['navi_item_Img']), $akt);
		@$akt = str_replace('[tag:img_act]', stripslashes($row['Img_act']), $akt);
		@$akt = str_replace('[tag:img_id]', stripslashes($row['navi_item_Img_id']), $akt);

		if (strpos($row['navi_item_link'], 'module=') === false && start_with('index.php?', $row['navi_item_link']))
		{
				$akt = str_replace('[tag:link]', $row['navi_item_link'] . "&amp;doc=" . 
				(empty($row['document_alias']) ? prepare_url($row['title']) : $row['document_alias']), $akt);
		}
		else
		{
				$akt = str_replace('[tag:link]', $row['navi_item_link'], $akt);
				if (start_with('www.', $row['navi_item_link'])) $akt = str_replace('www.', 'http://www.', $akt);
		}

		$akt = str_replace('[tag:target]', (empty($row['navi_item_target']) ? '_self' : $row['navi_item_target']), $akt);

		// Определяем тег для вставки следующего уровня
		switch ($ebene)
		{
			case 1 :
				$tag = "[tag:level:2]";
				break;
			case 2 :
				$tag = "[tag:level:3]";
				break;
		}
		
		// Если есть подуровень, то заново запускаем для него функцию и вставляем вместо тега
		if (isset($nav_items[$row['Id']]))
		{
			$sub_level = printNavi($ebenen, $way, $rub, $nav_items, $row_ul, $row['Id']);
			$akt = str_replace($tag,$sub_level,$akt);
		}
		// Если нет подуровня, то удаляем тег
		else $akt = str_replace($tag,"",$akt);

		// Подставляем в переменную навигации готовый пункт
		$navi .= $akt;
	}

	// Вставляем все пункты уровня в шаблон уровня
	switch ($ebene)
	{
		case 1 :
			$navi = str_replace("[tag:content]",$navi,$row_ul->navi_level1begin);
			break;
		case 2 :
			$navi = str_replace("[tag:content]",$navi,$row_ul->navi_level2begin);
			break;
		case 3 :
			$navi = str_replace("[tag:content]",$navi,$row_ul->navi_level3begin);
			break;
	}

	// Возвращаем сформированный уровень
	return $navi;
}

?>