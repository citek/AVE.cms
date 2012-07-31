<?php

/**
 * AVE.cms
 *
 * @package AVE.cms
 * @filesource
 */
 
/**
 * Обработка условий запроса.
 * Возвращает строку условий в SQL-формате
 *
 * @param int $id	идентификатор запроса
 * @return string
 */
 function request_get_condition_sql_string($id)
{
	global $AVE_DB, $AVE_Core;

	$from = array();
	$where = array();
	$retval = '';
	$i = 0;

	if (!defined('ACP'))
	{
		$doc = 'doc_' . $AVE_Core->curentdoc->Id;

		if (isset($_POST['req_' . $id]))
		{
			$_SESSION[$doc]['req_' . $id] = $_POST['req_' . $id];
		}
		elseif (isset($_SESSION[$doc]['req_' . $id]))
		{
			$_POST['req_' . $id] = $_SESSION[$doc]['req_' . $id];
		}
	}

	$sql_ak = $AVE_DB->Query("
		SELECT *
		FROM " . PREFIX . "_request_conditions
		WHERE request_id = '" . $id . "'
	");

	//Насколько я понял это чтото было сделано для динамческого запроса ... тогда почему только на сравнение по '='?
	if (!empty($_POST['req_' . $id]) && is_array($_POST['req_' . $id]))
	{
		$i=1;
		foreach ($_POST['req_' . $id] as $fid => $val)
		{
			if (!($val != '' && isset($_SESSION['val_' . $fid]) && in_array($val, $_SESSION['val_' . $fid]))) continue;
			$from[] = "%%PREFIX%%_document_fields AS t$i, ";
			$where[] = "AND((t$i.document_id = a.Id)AND(t$i.rubric_field_id = $fid AND t$i.field_value = '$val'))";
			++$i;
		}
	}
	
	$i=1;
	$vvv='';
	while ($row_ak = $sql_ak->FetchRow())
	{
		$fid = $row_ak->condition_field_id;

		if (isset($_POST['req_' . $id]) && isset($_POST['req_' . $id][$fid])) continue;


		$val = $row_ak->condition_value;
		
		if($val>''){
			$val = addcslashes (str_ireplace("[field]","t$i.field_value",str_ireplace("[numeric_field]","t$i.field_number_value",$val)), "'");
			if ($i) $from[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \"%%PREFIX%%_document_fields AS t$i,  \" : ''; ?>";
			$vvv.="$val";
			switch ($row_ak->condition_compare)
			{
				case  'N<': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \"  AND((t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND t$i.field_number_value < '\$vv')) \" : ''; ?>"; break;
				case  'N>': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \"  AND((t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND t$i.field_number_value > '\$vv')) \" : ''; ?>"; break;
				case 'N<=': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \"  AND((t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND t$i.field_number_value <= '\$vv')) \" : ''; ?>"; break;
				case 'N>=': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \"  AND((t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND t$i.field_number_value >= '\$vv')) \" : ''; ?>"; break;
				case 'N==': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \" AND((t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND t$i.field_number_value = '\$vv')) \" : ''; ?>"; break;

				case  '<': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \" AND((t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND UPPER(t$i.field_value) < UPPER('\$vv'))) \" : ''; ?>"; break;
				case  '>': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \" AND((t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND UPPER(t$i.field_value) > UPPER('\$vv'))) \" : ''; ?>"; break;
				case '<=': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \" AND((t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND UPPER(t$i.field_value) <= UPPER('\$vv'))) \" : ''; ?>"; break;
				case '>=': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \" AND((t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND UPPER(t$i.field_value) >= UPPER('\$vv'))) \" : ''; ?>"; break;

				case '==': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \" AND((t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND UPPER(t$i.field_value) = UPPER('\$vv'))) \" : ''; ?>"; break;
				case '!=': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \" AND((t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND UPPER(t$i.field_value) != UPPER('\$vv'))) \" : ''; ?>"; break;
				case '%%': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \" AND((t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND UPPER(t$i.field_value) LIKE UPPER('%\$vv%'))) \" : ''; ?>"; break;
				case  '%': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \" (AND(t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND UPPER(t$i.field_value) LIKE UPPER('\$vv%'))) \" : ''; ?>"; break;
				case '--': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \" AND((t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND UPPER(t$i.field_value) NOT LIKE UPPER('%\$vv%'))) \" : ''; ?>"; break;
				case '!-': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \" AND((t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND UPPER(t$i.field_value) NOT LIKE UPPER('\$vv%'))) \" : ''; ?>"; break;

				case 'IN=': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \" AND((t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND t$i.field_value IN (\$vv))) \" : ''; ?>"; break;

				case 'ANY': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \" AND((t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND (t$i.field_value=ANY(\$vv)))) \" : ''; ?>"; break;
				case 'FRE': $where[] = "<?php \$vv=eval2var(' ?>$val<? '); echo \$vv>'' ? \" AND((t$i.document_id = a.id)AND(t$i.rubric_field_id = $fid AND (\$vv))) \" : ''; ?>"; break;
			}

			if ($i || $row_ak->condition_join == 'AND') ++$i;
		}
	}

	if (!empty($where))
	{
		$from = implode(' ', $from);
		//$where =  (($i) ? implode(' AND ', $where) : '(' . implode(') OR(', $where) . ')');
		$where =  implode($where);
		$retval = serialize(array('from'=>$from,'where'=>"<?php echo (trim(eval2var(' ?>$vvv<? '))>'' ? \" AND(1=1)  \" :\"\") ?>".$where));
	}

	if (defined('ACP'))
	{
		$AVE_DB->Query("
			UPDATE " . PREFIX . "_request
			SET	request_where_cond = '" . addslashes($retval) . "'
			WHERE Id = '" . $id . "'
		");
	}

	return $retval;
}

  /*
  * Функция принимает строку, и возвращает
  * адрес первого изображения, которую найдет
  */
 function getImgSrc ($data) {
    preg_match('@.*<img(.*?)>@i', $data, $matches);
    $host = @$matches[1];
    preg_match('@.*src\s*=\s*("|\')(.*?)("|\')@i', $host, $matches);
    $host = @$matches[2];

    preg_match('@/index\.php\?.*thumb=(.*?)\&@i', $host, $matches);
    //$host = $matches[1];
    if (@$matches[1]) {
        return $matches[1];
    } else {
        return $host;
    }
 }


/**
 * Функция обработки тэгов полей с использованием шаблонов
 * в соответствии с типом поля
 *
 * @param int $rubric_id	идентификатор рубрики
 * @param int $document_id	идентификатор документа
 * @param int $maxlength	максимальное количество символов обрабатываемого поля
 * @return string
 */
function request_get_document_field($rubric_id, $document_id, $maxlength = '')
{
	if (!is_numeric($rubric_id) || $rubric_id < 1 || !is_numeric($document_id) || $document_id < 1) return '';

	$document_fields = get_document_fields($document_id);

	if (empty($document_fields[$rubric_id])) return '';

	$field_value = trim($document_fields[$rubric_id]['field_value']);
	if ($field_value == '' && $document_fields[$rubric_id]['tpl_req_empty']) return '';

	$func='get_field_'.$document_fields[$rubric_id]['rubric_field_type'];
	if(is_callable($func))
	{
		$field_value=$func($field_value,'req',"","","",$maxlength,$document_fields,$rubric_id);
	}
	else
	{
		$field_value=get_field_default($field_value,'req',"","","",$maxlength,$document_fields,$rubric_id);
	}

	if ($maxlength != '')
	{
		if ($maxlength == 'more' || $maxlength == 'esc'|| $maxlength == 'img')
		{	
			if($maxlength == 'more')
			{
				//$teaser = explode('<a name="more"></a>', $field_value);
				$teaser = explode('<hr />', $field_value);
				$field_value = $teaser[0];
			}
			elseif($maxlength == 'esc')
			{
				$field_value = addslashes($field_value);
			}
			elseif($maxlength == 'img')
			{
				$field_value = getImgSrc($field_value);
			}
		}
		elseif (is_numeric($maxlength))
		{
			if ($maxlength < 0)
			{
				$field_value = str_replace(array("\r\n","\n","\r"), " ", $field_value);
				$field_value = strip_tags($field_value, "<a>");
				$field_value = preg_replace('/  +/', ' ', $field_value);
				$field_value = trim($field_value);
				$maxlength = abs($maxlength);
			}
			if ($maxlength != 0)
			{
				$field_value = mb_substr($field_value, 0, $maxlength) . ((strlen($field_value) > $maxlength) ? '... ' : '');
			}
		}
		else return false;
	}

	return $field_value;
}

/**
 * Обработка тега запроса.
 * Возвращает список документов удовлетворяющих параметрам запроса
 * оформленный с использованием шаблона
 *
 * @param int $id	идентификатор запроса
 * @return string
 */
function request_parse($id,$params=Array())
{
	global $AVE_Core, $AVE_DB, $request_documents;
//Доберусь - надо сделать фишку чтобы если афтар не активен или удален то документы его в реквесте не выводятся
//по идее это бы надстройкой к рекесту сделать чтобы новости не побить и т.д.
	$return = '';

	if (is_array($id)) $id = $id[1];

	$row_ab = $AVE_DB->Query("
		SELECT *
		FROM " . PREFIX . "_request
		WHERE Id = '" . $id . "'
	")->FetchRow();

	if (is_object($row_ab))
	{

		$ttl=(int)$row_ab->request_cache_lifetime;
		$limit = (intval($params['LIMIT'])>0 ? intval($params['LIMIT']) : (($row_ab->request_items_per_page > 0) ? $row_ab->request_items_per_page : 0));
		$main_template = $row_ab->request_template_main;
		$item_template = $row_ab->request_template_item;
		$request_order_by = $row_ab->request_order_by;
		$request_asc_desc = $row_ab->request_asc_desc;
		//строим списки подключаемых полей для сортировки
		$request_order = $request_order_by . " " . $request_asc_desc;

		$request_order_fields = '';
		$request_order_tables = '';
		$request_order1 = '';

		if ($row_ab->request_order_by_nat) {
		    $request_order_tables="LEFT JOIN ". PREFIX . "_document_fields AS s" .$row_ab->request_order_by_nat. "
			    ON (s" .$row_ab->request_order_by_nat. ".document_id = a.Id and s" .$row_ab->request_order_by_nat. ".rubric_field_id=".$row_ab->request_order_by_nat.")";
		    $request_order_fields="s".$row_ab->request_order_by_nat.".field_value, ";
		    $request_order = "s" .$row_ab->request_order_by_nat. ".field_value ".$row_ab->request_asc_desc;
		}

		$x=0;

		if (is_array($params['SORT']))
			foreach($params['SORT'] as $k=>$v)
				if(intval($k)>0){
					$x++;
					$request_order_tables.="LEFT JOIN ". PREFIX . "_document_fields AS s" .$k. "
						ON (s" .$k. ".document_id = a.Id and s" .$k. ".rubric_field_id=".$k.")";
					if(strpos($v,'INT')===false)
						$request_order_fields.="s".$k.".field_value, ";
					else
						{
						   $request_order_fields.="s".$k.".field_number_value, ";
						   $v=str_replace('INT','',$v);
						}

					$request_order1.=$x.' '.$v.', ';
				}
		//Этот кусок для того чтобы можно было параметрами попросить произвольный статус досумента 
		//- например в личном кабинете попросить архивные документы
		$docstatus="AND a.document_status != '0'";
		$docstatus="AND a.document_status = '1'";
		if(isset($params['STATUS']))$docstatus="AND a.document_status = '".intval($params['STATUS'])."'";
 		$doctime = get_settings('use_doctime') 
 		        	? ("AND a.document_published <= UNIX_TIMESTAMP() AND
 		         	(a.document_expire = 0 OR a.document_expire >=UNIX_TIMESTAMP())") : '';

		$where_cond = (empty($_POST['req_' . $id]) && empty($_SESSION['doc_' . $AVE_Core->curentdoc->Id]['req_' . $id]))
			? unserialize($row_ab->request_where_cond)
			: unserialize(request_get_condition_sql_string($row_ab->Id));
		$where_cond['from'] = str_replace('%%PREFIX%%', PREFIX, $where_cond['from']);
		$where_cond['where'] = str_replace('%%PREFIX%%', PREFIX, $where_cond['where']);
		$whFromUser=(intval($params['USER_ID'])>0 ? ' AND a.document_author_id='.intval($params['USER_ID']) : '')
					.(isset($params['USER_WHERE'])&& $params['USER_WHERE']>'' ? ' AND '.$params['USER_WHERE'] : '')
					.(intval($params['PARENT'])>0 ? ' AND a.document_parent='.intval($params['PARENT']) : '');

		$other_fields='';
		$other_tables='';
		
		$other_fields.=$request_order_fields;
		$other_tables.=$request_order_tables;

		if(isset($params['VIEWS'])){
				$other_fields.="(SELECT sum(v1.`count`) FROM ".PREFIX."_view_count AS v1 WHERE v1.document_id=a.Id AND v1.day_id>".(strtotime($params['VIEWS'] ? $params['VIEWS'] : '-30 years')).") AS dayviews,
				";
				
				if($params['VIEWS_ORDER']>'')$request_order1=(count(explode(',',$other_fields))-1).' '.$params['VIEWS_ORDER'].',';
		
		}

		if(isset($params['VOTE'])){
				$other_fields.="(SELECT ".$params['VOTE']."(v2.`vote`) FROM ".PREFIX."_modul_vote AS v2 WHERE type_of_doc='document' and v2.document_id=a.Id) AS votes,
				";
				
				if($params['VOTE_ORDER']>'')$request_order2=(count(explode(',',$other_fields))-1).' '.$params['VOTE_ORDER'];
		}


		if (!empty($AVE_Core->install_modules['comment']->Status)){
		
				$other_tables.="
					LEFT JOIN
						" . PREFIX . "_modul_comment_info AS b
							ON b.document_id = a.Id ". ($params['COMMENT'] ? " and b.comment_published>".(strtotime($params['COMMENT'])) : '')."
					";
				$other_fields.="COUNT(b.document_id) AS nums,
				";
				if($params['COMMENT_ORDER']>'')$request_order1=(count(explode(',',$other_fields))-1).' '.$params['COMMENT_ORDER'].',';
			}		

			$request_order = addslashes($request_order1 .($request_order2>'' ? ($request_order1 ? $request_order2.',' : $request_order2) : ''). $request_order);
		
		if ($row_ab->request_show_pagination == 1)
		{
			$num = $AVE_DB->Query( eval2var( " ?> 
				SELECT COUNT(*)
				FROM 
				".($where_cond['from'] ? $where_cond['from'] : '')."
				" . PREFIX . "_documents AS a
				WHERE
					a.Id != '1'
				AND a.Id != '" . PAGE_NOT_FOUND_ID . "'
				AND a.rubric_id = '" . $row_ab->rubric_id . "'
				AND a.document_deleted != '1'
				" . $docstatus . "
				" . $whFromUser . "
				" . $where_cond['where'] . "
				" . $doctime . "
			<?php " ),$ttl,'rub_'.$row_ab->rubric_id)->GetCell();

			$seiten = ceil($num / $limit);
			if (isset($_REQUEST['apage']) && is_numeric($_REQUEST['apage']) && $_REQUEST['apage'] > $seiten)
			{
				$redirect_link = rewrite_link('index.php?id=' . $AVE_Core->curentdoc->Id
					. '&amp;doc=' . (empty($AVE_Core->curentdoc->document_alias) ? prepare_url($AVE_Core->curentdoc->document_title) : $AVE_Core->curentdoc->document_alias)
					. ((isset($_REQUEST['artpage']) && is_numeric($_REQUEST['artpage'])) ? '&amp;artpage=' . $_REQUEST['artpage'] : '')
					. ((isset($_REQUEST['page']) && is_numeric($_REQUEST['page'])) ? '&amp;page=' . $_REQUEST['page'] : ''));

				header('Location:' . $redirect_link);
				exit;
			}
			$start  = get_current_page('apage') * $limit - $limit;
		}
		else
		{
			$start  = 0;
		}

		$q =  " ?>
			SELECT
				". $other_fields ." 
				a.Id,
				a.document_parent,
				a.document_title,
				a.document_alias,
				a.document_author_id,
				a.document_count_view,
				a.document_published,
				a.document_meta_keywords
			FROM
				".($where_cond['from'] ? $where_cond['from'] : '')."
				" . PREFIX . "_documents AS a
			". ($other_tables>'' ? $other_tables : '') . "	
			WHERE
				a.Id != '1'
			AND a.Id != '" . PAGE_NOT_FOUND_ID . "'
			AND a.rubric_id = '" . $row_ab->rubric_id . "'
			AND a.document_deleted != '1'
			" . $whFromUser . "
			" . $docstatus . "
			" . $where_cond['where'] . "
			" . $doctime . "
			GROUP BY a.Id
			ORDER BY " . $request_order . "
			".($limit>0 ? "LIMIT " . $start . "," . $limit : '').
		" <?php ";
		$q=eval2var($q);

		$q=$AVE_DB->Query($q,$ttl,'rub_'.$row_ab->rubric_id);
		if ($q->NumRows() > 0)
		{
			$main_template = preg_replace('/\[tag:if_empty](.*?)\[\/tag:if_empty]/si', '', $main_template);
			$main_template = str_replace (array('[tag:if_notempty]','[/tag:if_notempty]'), '', $main_template);
		}
		else
		{
			$main_template = preg_replace('/\[tag:if_notempty](.*?)\[\/tag:if_notempty]/si', '', $main_template);
			$main_template = str_replace (array('[tag:if_empty]','[/tag:if_empty]'), '', $main_template);
		}

		$page_nav   = '';
		if ($row_ab->request_show_pagination == 1 && $seiten > 1)
		{
			$page_nav = ' <a class="pnav" href="index.php?id=' . $AVE_Core->curentdoc->Id
				. '&amp;doc=' . (empty($AVE_Core->curentdoc->document_alias) ? prepare_url($AVE_Core->curentdoc->document_title) : $AVE_Core->curentdoc->document_alias)
				. ((isset($_REQUEST['artpage']) && is_numeric($_REQUEST['artpage'])) ? '&amp;artpage=' . $_REQUEST['artpage'] : '')
				. '&amp;apage={s}'
				. ((isset($_REQUEST['page']) && is_numeric($_REQUEST['page'])) ? '&amp;page=' . $_REQUEST['page'] : '')
				. '">{t}</a> ';
			$page_nav = get_pagination($seiten, 'apage', $page_nav, get_settings('navi_box'));
			$page_nav = rewrite_link($page_nav);
		}

		$rows = array();
		$request_documents = array();
		while ($row = $q->FetchRow())
		{
			array_push($request_documents, $row->Id);
			array_push($rows, $row);
		}
		$items = '';
		$md5template=md5($item_template);
		foreach ($rows as $row)
		{
			$cachefile_docid=BASE_DIR.'/cache/sql/doc_'.$row->Id.'/request-'.$id.'.cache';
			if(!file_exists($cachefile_docid))
				{
					$item = preg_replace('/\[tag:rfld:(\d+)]\[(more|esc|img|[0-9-]+)]/e', "request_get_document_field(\"$1\", $row->Id, \"$2\")", $item_template);
					//if(!file_exists(dirname($cachefile_docid)))mkdir(dirname($cachefile_docid),0777,true);
					//file_put_contents($cachefile_docid,$item);
				}
				else
				{
					$item=file_get_contents($cachefile_docid);
				}
			$link = rewrite_link('index.php?id=' . $row->Id . '&amp;doc=' . (empty($row->document_alias) ? prepare_url($row->document_title) : $row->document_alias));
			$item = str_replace('[tag:link]', $link, $item);
			$item = str_replace('[tag:docid]', $row->Id, $item);
			$item = str_replace('[tag:doctitle]', $row->document_title, $item);
			$item = str_replace('[tag:dockeywords]', $row->document_meta_keywords, $item);
			$item = str_replace('[tag:docparent]', $row->document_parent, $item);
			$item = str_replace('[tag:docdate]', pretty_date(strftime(DATE_FORMAT, $row->document_published)), $item);
			$item = str_replace('[tag:doctime]', pretty_date(strftime(TIME_FORMAT, $row->document_published)), $item);
			$item = str_replace('[tag:docauthor]', get_username_by_id($row->document_author_id), $item);
			$item = str_replace('[tag:docauthorid]', $row->document_author_id, $item);
			$item = str_replace('[tag:docviews]', $row->document_count_view, $item);
			$item = str_replace('[tag:doccomments]', isset($row->nums) ? $row->nums : '', $item);
			$item = str_replace('[tag:docvotes]', isset($row->votes) ? $row->votes : '', $item);
			$item = str_replace('[tag:docdayviews]', isset($row->dayviews) ? $row->dayviews : '', $item);
			$items .= $item;
		}

		$main_template = str_replace('[tag:pages]', $page_nav, $main_template);
		$main_template = str_replace('[tag:docid]', $AVE_Core->curentdoc->Id, $main_template);
		$main_template = str_replace('[tag:docdate]', pretty_date(strftime(DATE_FORMAT, $AVE_Core->curentdoc->document_published)), $main_template);
		$main_template = str_replace('[tag:doctime]', pretty_date(strftime(TIME_FORMAT, $AVE_Core->curentdoc->document_published)), $main_template);
		$main_template = str_replace('[tag:docauthor]', get_username_by_id($AVE_Core->curentdoc->document_author_id), $main_template);
		$main_template = str_replace('[tag:doctotal]', $num, $main_template);
		$main_template = str_replace('[tag:pagetitle]', $AVE_Core->curentdoc->document_title, $main_template);
		$main_template = preg_replace('/\[tag:dropdown:([,0-9]+)\]/e', "request_get_dropdown(\"$1\", " . $row_ab->rubric_id . ", " . $row_ab->Id . ");", $main_template);

		$return = str_replace('[tag:content]', $items, $main_template);
		$return = str_replace('[tag:path]', ABS_PATH, $return);
		$return = str_replace('[tag:mediapath]', ABS_PATH . 'templates/' . THEME_FOLDER . '/', $return);

		$return = $AVE_Core->coreModuleTagParse($return);
	}
	return $return;
}

/**
 * Функция получения содержимого поля для обработки в шаблоне запроса
 * <pre>
 * Пример использования в шаблоне:
 *   <li>
 *     <?php
 *      $r = request_get_document_field_value(12, [tag:docid]);
 *      echo $r . ' (' . strlen($r) . ')';
 *     ?>
 *   </li>
 * </pre>
 *
 * @param int $rubric_id	идентификатор поля, для [tag:rfld:12][150] $rubric_id = 12
 * @param int $document_id	идентификатор документа к которому принадлежит поле.
 * @param int $maxlength	необязательный параметр, количество возвращаемых символов.
 * 							Если данный параметр указать со знаком минус
 * 							содержимое поля будет очищено от HTML-тегов.
 * @return string
 */
function request_get_document_field_value($rubric_id, $document_id, $maxlength = 0)
{

	if (!is_numeric($rubric_id) || $rubric_id < 1 || !is_numeric($document_id) || $document_id < 1) return '';

	$document_fields = get_document_fields($document_id);

	$field_value = isset($document_fields[$rubric_id]) ? $document_fields[$rubric_id]['field_value'] : '';

	if (!empty($field_value))
	{
		$field_value = strip_tags($field_value, '<br /><strong><em><p><i>');
		$field_value = str_replace('[tag:mediapath]', ABS_PATH . 'templates/' . THEME_FOLDER . '/', $field_value);
	}

	if (is_numeric($maxlength) && $maxlength != 0)
	{
		if ($maxlength < 0)
		{
			$field_value = str_replace(array("\r\n", "\n", "\r"), ' ', $field_value);
			$field_value = strip_tags($field_value, "<a>");
			$field_value = preg_replace('/  +/', ' ', $field_value);
			$maxlength = abs($maxlength);
		}
		$field_value = mb_substr($field_value, 0, $maxlength) . (strlen($field_value) > $maxlength ? '... ' : '');
	}

	return $field_value;
}

/**
 * Функция формирования выпадающих списков
 * для управления условиями запроса в публичной части
 *
 * @param string $dropdown_ids	идентификаторы полей
 * 								типа выпадающий список указанные через запятую
 * @param int $rubric_id		идентификатор рубрики
 * @param int $request_id		идентификатор запроса
 * @return string
 */
function request_get_dropdown($dropdown_ids, $rubric_id, $request_id)
{
	global $AVE_Core, $AVE_DB, $AVE_Template;

	$dropdown_ids = explode(',', preg_replace('/[^,\d]/', '', $dropdown_ids));
	$dropdown_ids[] = 0;
	$dropdown_ids = implode(',', $dropdown_ids);
	$doc = 'doc_' . $AVE_Core->curentdoc->Id;
	$control = array();

	$sql = $AVE_DB->Query("
		SELECT
			Id,
			rubric_field_title,
			rubric_field_default
		FROM " . PREFIX . "_rubric_fields
		WHERE Id IN(" . $dropdown_ids . ")
		AND rubric_id = '" . $rubric_id . "'
		AND rubric_field_type = 'dropdown'
	",-1,'rub_'.$rubric_id);
	while ($row = $sql->FetchRow())
	{
		$dropdown['titel'] = $row->rubric_field_title;
		$dropdown['selected'] = isset($_SESSION[$doc]['req_' . $request_id][$row->Id]) ? $_SESSION[$doc]['req_' . $request_id][$row->Id] : '';
		$dropdown['options'] = $_SESSION['val_' . $row->Id] = explode(',', $row->rubric_field_default);
		$control[$row->Id] = $dropdown;
	}

	$AVE_Template->assign('request_id', $request_id);
	$AVE_Template->assign('ctrlrequest', $control);
	return $AVE_Template->fetch(BASE_DIR . '/templates/' . THEME_FOLDER . '/modules/request/remote.tpl');
}
?>