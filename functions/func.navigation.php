<?php
/**
 * AVE.cms - Навигация
 *
 * @package AVE.cms
 * @filesource
 */

/**
 * Функция обработки навигации
 *
 * @param int $navi_id - идентификатор меню навигации
 */
function parse_navigation($navi_id)
{
	global $AVE_DB, $AVE_Core;
	// извлекаем настоящий id из аргумента
	$navi_id  = (int)preg_replace('/\D/', '', $navi_id[1]);

	// получаем меню навигации по id,
	// и если такой не существует, выводим сообщение
	$navi_menu = get_navigations($navi_id);
	if (!$navi_menu)
	{
		echo 'Menu ', $navi_id, ' not found!';
		return;
	}

	// выставляем гостевую группу по дефолту 
	if (!defined('UGROUP')) define('UGROUP', 2);
	// выходим, если навиг. не предназначена для текущей группы
	if (!in_array(UGROUP, $navi_menu->navi_user_group)) return;

	// Находим активный пункт (связь текущего открытого документа и навигации). Нас интересуют:
	//		1) документы, которые сами связаны с пунктом меню
	//		2) пункты навигации, у которых ссылка совпадает с алиасом дока
	// возвращаем в $navi_active_way через запятую id пунктов:
	//		1) активный пункт
	//		2) родители активного пункта

	// если текущая страница не модуль, а документ
//	if (!$_REQUEST['module'])
//	{
		// id текущего документа. Если не задан, то главная страница
		$doc_active_id = (int)(($_GET['id']) ? $_GET['id'] : 1);
		// запрос для выборки по текущему алиасу
		$sql_doc_active_alias = (($AVE_Core->curentdoc->document_alias && $AVE_Core->curentdoc->Id == $doc_active_id)
			? " OR nav.document_alias = '" . $AVE_Core->curentdoc->document_alias . "'"
			: '');

		$navi_active_way = $AVE_DB->Query("
			SELECT CONCAT_WS(',', nav.Id, nav.parent_id, nav2.parent_id)
			FROM
				" . PREFIX . "_navigation_items AS nav
			JOIN
				" . PREFIX . "_documents AS doc
			LEFT JOIN
				" . PREFIX . "_navigation_items AS nav2 ON nav2.Id = nav.parent_id
			WHERE nav.navi_item_status = '1'
			AND nav.navi_id = '" . $navi_id . "'
			AND doc.Id = '" . $doc_active_id . "'
			AND (
				nav.navi_item_link = 'index.php?id=" . $curent_doc_id . "'" . 
				$sql_doc_active_alias . "
				OR nav.Id = doc.document_linked_navi_id
				)
		")->GetCell();
//	}
/*	// если текущая страница - модуль (логин, магазин и т.д.)
	else
	{
		@$extended_by_module = "(nav.navi_item_link LIKE '%%" . $refurl2 . "%%')";
		@$extended_by_module2 = "(nav.document_alias LIKE '%%" . $refurl2 . "%%')";

		$navi_active_way = $AVE_DB->Query("
			SELECT CONCAT_WS(',',nav.Id, nav.parent_id, nav2.parent_id)
			FROM
				" . PREFIX . "_navigation_items AS nav
			LEFT JOIN
				" . PREFIX . "_navigation_items AS nav2 ON nav2.Id = nav.parent_id
			WHERE nav.navi_item_status = '1'
			AND nav.navi_id = '" . $navi_id . "'
		")->GetCell();

		if(empty($navi_active_way))
		{
			$navi_active_way = $AVE_DB->Query("
				SELECT CONCAT_WS(',',nav.parent_id, nav2.parent_id)
				FROM
					" . PREFIX . "_navigation_items AS nav
				LEFT JOIN
					" . PREFIX . "_navigation_items AS nav2 ON nav2.Id = nav.parent_id
				WHERE nav.navi_item_status = '1'
				AND nav.navi_id = '" . $navi_id . "'
				AND $extended_by_module2
			")->GetCell();
		}
	}*/

	// если мы нашли активный пункт
	if ($navi_active_way)
	{
		// если не "раскрывать все уровни", то ищем 
		// пункты меню для нави только среди активного и его родителей
		if ($navi_menu->navi_expand!=1) $sql_navi_active_way = "AND parent_id IN(0," . $navi_active_way . ")";
		// задаём путь до активного пункта в виде массива
		$navi_active_way = explode(',', $navi_active_way);
	}
	// если не нашли активный пункт
	else
	{
		// если не "раскрывать все уровни", то выводим только первый уровень нави
		if ($navi_menu->navi_expand!=1) $sql_navi_active_way = "AND parent_id = 0";
		// задаём путь до активного пункта в виде массива 
		$navi_active_way = array();
	}

	// запрос пунктов меню
	$sql_navi_items = $AVE_DB->Query("
		SELECT *
		FROM " . PREFIX . "_navigation_items
		WHERE navi_item_status = '1'
		AND navi_id = '" . $navi_id . "'
		" . $sql_navi_active_way . "
		ORDER BY navi_item_position ASC
	");

	while ($row_navi_items = $sql_navi_items->FetchAssocArray())
	{
		$navi_items[$row_navi_items['parent_id']][] = $row_navi_items;
	}

	// Парсим теги в шаблонах пунктов
	$navi_item_tpl = array(
		1 =>  array(
			'inactive'	=> $navi_menu->navi_level1,
			'active'	=> $navi_menu->navi_level1active
		),
		2 =>  array(
			'inactive'	=> $navi_menu->navi_level2,
			'active'	=> $navi_menu->navi_level2active
		),
		3 =>  array(
			'inactive'	=> $navi_menu->navi_level3,
			'active'	=> $navi_menu->navi_level3active
		)
	);

	// запускаем рекурсивную сборку навигации
	$navi = printNavi($navi_menu,$navi_items,$navi_active_way,$navi_item_tpl);

	// преобразуем все ссылке в коде
	$navi = rewrite_link($navi);
	// удаляем переводы строк и табуляции
	$navi = preg_replace("/(^[\r\n]*|[\r\n]+)[\s\t]*[\r\n]+/", "\n", $navi);
	$navi = str_replace(array("\n","\r"),'',$navi);

	return $navi;
}

/**
 * Рекурсивная функция для формирования меню навигации
 *
 * @param object	$navi_menu меню (шаблоны, параметры)
 * @param array		$navi_items (пункты по родителям)
 * @param array		$navi_active_way ("активный путь")
 * @param array		$navi_item_tpl (шаблоны пунктов)
 * @param int		$parent (исследуемый родитель, изначально 0 - верхний уровень)
 * @return string	$navi - готовый код навигации
 */
function printNavi($navi_menu,$navi_items,$navi_active_way,$navi_item_tpl,$parent=0)
{
	// берём
	$navi_item_level = $navi_items[$parent][0]['navi_item_level'];

	// собираем каждый пункт в данном родителе -> в переменной $item
	foreach ($navi_items[$parent] as $row)
	{
		// Проверяем пункт меню на принадлежность к "активному пути" и выбираем шаблон
		$item = (in_array($row['Id'], $navi_active_way)) ? $navi_item_tpl[$navi_item_level]['active'] : $navi_item_tpl[$navi_item_level]['inactive'];

		################### ПАРСИМ ТЕГИ ###################
		// id
		@$item = str_replace('[tag:linkid]', $row['Id'], $item);
		// название
		@$item = str_replace('[tag:linkname]', $row['title'], $item);
		// ссылка
		if (strpos($row['navi_item_link'], 'module=') === false && start_with('index.php?', $row['navi_item_link']))
		{
			$item = str_replace('[tag:link]', $row['navi_item_link'] . "&amp;doc=" . ((!$row['document_alias']) ? prepare_url($row['title']) : $row['document_alias']), $item);
		}
		else
		{
			$item = str_replace('[tag:link]', $row['navi_item_link'], $item);
			if (start_with('www.', $row['navi_item_link'])) $item = str_replace('www.', 'http://www.', $item);
		}
		// target
		$item = str_replace('[tag:target]', (empty($row['navi_item_target']) ? '_self' : $row['navi_item_target']), $item);
		// описание
		@$item = str_replace('[tag:desc]', stripslashes($row['navi_item_desc']), $item);
		// изображение
		@$item = str_replace('[tag:img]', stripslashes($row['navi_item_Img']), $item);
		@$img = explode(".", $row['navi_item_Img']);
		@$row['Img_act'] = $img[0]."_act.".$img[1];
		@$item = str_replace('[tag:img_act]', stripslashes($row['Img_act']), $item);
		@$item = str_replace('[tag:img_id]', stripslashes($row['navi_item_Img_id']), $item);
		################### /ПАРСИМ ТЕГИ ##################

		// Определяем тег для вставки следующего уровня
		switch ($navi_item_level)
		{
			case 1 :
				$tag = '[tag:level:2]';
				break;
			case 2 :
				$tag = '[tag:level:3]';
		}

		// Если есть подуровень, то заново запускаем для него функцию и вставляем вместо тега
		if ($navi_items[$row['Id']])
		{
			$item_sublevel = printNavi($navi_menu,$navi_items,$navi_active_way,$navi_item_tpl,$row['Id']);
			$item = @str_replace($tag,$item_sublevel,$item);
		}
		// Если нет подуровня, то удаляем тег
		else $item = @str_replace($tag,'',$item);

		// Подставляем в переменную навигации готовый пункт
		$navi .= $item;
	}

	// Вставляем все пункты уровня в шаблон уровня
	switch ($navi_item_level)
	{
		case 1 :
			$navi = str_replace("[tag:content]",$navi,$navi_menu->navi_level1begin);
			break;
		case 2 :
			$navi = str_replace("[tag:content]",$navi,$navi_menu->navi_level2begin);
			break;
		case 3 :
			$navi = str_replace("[tag:content]",$navi,$navi_menu->navi_level3begin);
			break;
	}

	// Возвращаем сформированный уровень
	return $navi;
}
?>