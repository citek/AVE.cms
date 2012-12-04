<?php
/**
 * Класс модуля импорта
 *
 * @package AVE.cms
 * @subpackage module_import
 * @author Realter
 * @since 3.00
 * @filesource
 */
class import
{

/**
 *	Свойства класса
 */

	/**
	* Парсеры
	*/
	var $parsers = array('CSV2Array','XML2Array');

	/**
	* Основные поля документа, предлагаемые для импорта
	*/
	var $header_fields = array(
		'Id',
		'document_title',
		'document_alias',
		'document_meta_keywords',
		'document_meta_description',
		'document_meta_robots',
		'document_published',
		'document_in_search',
		'document_status',
		'document_linked_navi_id',
		'document_breadcrum_title',
		'document_parent',
		'document_count_view',
	);

/**
 *	Внутренние методы класса
 */

	/**
	* Удаление документа
	* 
	* @param int $id идентификатор документа
	*/
	function GetDoc($id)
	{
		global $AVE_DB;
		$AVE_DB->Query("
			UPDATE " . PREFIX . "_documents 
			SET
				document_status = '0',
				document_deleted = '1'
			WHERE Id=". $id
		);
	}

	/**
	* Удаление документа
	* 
	* @param int $id идентификатор документа
	*/
	function DeleteDoc($id)
	{
		global $AVE_DB;
		$AVE_DB->Query("
			UPDATE " . PREFIX . "_documents 
			SET
				document_status = '0',
				document_deleted = '1'
			WHERE Id=". $id
		);
	}

	/**
	* Изменение документа
	* @param int $id идентификатор документа
	* @param array $array набор данных документа
	*/
	function UpdateDoc($rub,$id,$array)
	{
		require_once(BASE_DIR . '/class/class.docs.php');
		$AVE_Document = new AVE_Document();
		$d = $array['header'];
		$d['doc_title'] = $d['document_title'];
		$d['document_expire'] = date("d.m.Y H:i",strtotime('+20 year'));
		$d['document_status'] = 1;
		$d['feld'] = $array['body'];
		return $AVE_Document->documentSave($rub,$id,$d);
	}

	/**
	* Добавление документа
	*
	* @param int $rub идентификатор рубрики
	* @param array $array набор данных документа
	*/
	function InsertDoc($rub,$array)
	{
		require_once(BASE_DIR.'/class/class.docs.php');
		$AVE_Document=new AVE_Document();
		$d=$array['header'];
		$d['document_expire']=date("d.m.Y H:i",strtotime('+20 year'));
		$d['document_status']=1;
		$d['doc_title']=$d['document_title'];
		$d['feld']=$array['body'];		
		return $AVE_Document->documentSave((int)$rub,null,$d);
	}

	/**
	 * Проверка наличия документа по ключевым полям
	 *
	 * @param array $array - массив ID_поля_в_рублике=>Ключевое_значение 
	 * @param int $rub - id рубрики
	 *
	 * @return int/false - возвращает Id документа или false
	 */
	function Doc_Exists($key_fields,$rub)
	{
		global $AVE_DB;

		$header = array();
		foreach($key_fields['header'] as $k => $v)
		{
			$header[] = 'a.' . $k . " = '" . $v . "'";
		}
		if ($header) $sql_header = ' AND ' . implode(' AND ', $header);

		$tables = array();
		$body = array();
		$x = 0;
		foreach($key_fields['body'] as $k => $v)
		{
			$tables[] = PREFIX . "_document_fields AS t" . $x;
			$where[] = "(a.Id=t" . $x . ".document_id AND(t" . $x . ".rubric_field_id=" . $k . " AND t" . $x . ".field_value='" . addslashes($v) . "'))";
			$x++;
		}
		if ($tables) $sql_tables = ', ' . implode(', ', $tables);
		if ($body) $sql_body = ' AND ' . implode(' AND ', $body);

		$sql = "
		SELECT a.Id FROM " . PREFIX . "_documents
			AS a " . $sql_tables . "
		WHERE a.rubric_id=" . $rub . $sql_header . $sql_body;

		$doc_id = $AVE_DB->Query($sql)->GetCell();
		return $doc_id;
	}

	function object_to_array($Class)
	{
		# Typecast to (array) automatically converts stdClass -> array.
		$Class = (array)$Class;
		$emptyarr=array();
		if($emptyarr===$Class) return '';
		# Iterate through the former properties looking for any stdClass properties.
		# Recursively apply (array).
		foreach($Class as $key => &$value)
		{
			if((is_object($value)||is_array($value)))
			{
				$Class[$key] = $this->object_to_array($value);
			}
			//$value=addslashes($value);
		}
		return $Class;
	}

	/**
	* read a csv file and return an indexed array.
	* @param string $cvsfile path to csv file
	* @param array $fldnames array of fields names. Leave this to null to use the first row values as fields names.
	* @param string $sep string used as a field separator (default ';')
	* @param string $protect char used to protect field (generally single or double quote)
	* @param array  $filters array of regular expression that row must match to be in the returned result.
	*                        ie: array('fldname'=>'/pcre_regexp/')
	* @return array
	*/
	function CSV2Array($csvfile,$fldnames=null,$sep=',',$protect='"',$filters=null)
	{
		if(! $csv = file($csvfile) )
			return FALSE;
	
		# use the first line as fields names
		if( is_null($fldnames) ){
				$fldnames = array_shift($csv);
				$fldnames = explode($sep,$fldnames);
				$fldnames = array_map('trim',$fldnames);
				if($protect){
					foreach($fldnames as $k=>$v)
						$fldnames[$k] = preg_replace(array("/(?<!\\\\)$protect/","!\\\\($protect)!"),'\\1',$v);
				}            
		}elseif( is_string($fldnames) ){
				$fldnames = explode($sep,$fldnames);
				$fldnames = array_map('trim',$fldnames);
		}
		
		$i=0;
		foreach($csv as $row){
				if($protect){
					$row = preg_replace(array("/(?<!\\\\)$protect/","!\\\\($protect)!"),'\\1',$row);
				}
				$row = explode($sep,trim($row));
				
				foreach($row as $fldnb=>$fldval)
					$res[$i][(isset($fldnames[$fldnb])?$fldnames[$fldnb]:$fldnb)] = $fldval;
				
				if( is_array($filters) ){
					foreach($filters as $k=>$exp){
						if(! preg_match($exp,$res[$i][$k]) )
							unset($res[$i]);
					}
				}
				$i++;
		}
		
		return $res;
	}

	function XML2Array($fname)
	{
		$xml = (simplexml_load_file($fname));
		$xml = $this->object_to_array($xml);
		// Убираем роот элемент из Массива чтобы добраться до самих записей - может есть варианты полегче...
		$a = array_values($xml);
		return ($a[0]);
	}

	function VolgainfoImport($fname)
	{
		$data = file_get_contents(str_replace(BASE_DIR,'',$fname));
		$data = json_decode($data);
		$data = $this->object_to_array($data);
		return $data['RESULT'];
	}

	// рекурсивно создаёт массив с заменами
	function _replace_array($mixed,$key='',$new=true)
	{
		static $arr = array();
		if($new) $arr = array();

		if (!is_array($mixed)) return $arr['[row'.$key.']'] = $mixed;
		$res = $key;
		foreach ($mixed as $k=>$v)
		{
			if(is_array($v))
			{
				$arr['[row:'.$k.']'] = serialize($v);
			}
			$this->_replace_array($v,$res.':'.$k,false);
		}
		return $arr;
	}
	// Заменяет в массиве доков, используя массив замен, выполняя код php
	function _replace(&$item, &$key, $repl_array)
	{
		$code = stripslashes(strtr($item,$repl_array));
		$item = eval2var('?>' . $code . '<?');
	}

/**
 *	Внешние методы класса
 */

	/**
	 * Вывод списка импортов
	 *
	 * @param string $tpl_dir - путь к папке с шаблонами модуля
	 */
	function importList($tpl_dir)
	{
		global $AVE_DB, $AVE_Template;

		$imports = array();
		$sql = $AVE_DB->Query("SELECT * FROM " . PREFIX . "_modul_import");
		while ($result = $sql->FetchRow())
		{
			array_push($imports, $result);
		}
		$rubs = array();
		$sql = $AVE_DB->Query("SELECT * FROM " . PREFIX . "_rubrics");
		while ($result = $sql->FetchRow())
		{
			array_push($rubs, $result);
		}

		$AVE_Template->assign('imports', $imports);
		$AVE_Template->assign('rubs', $rubs);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_list.tpl'));
	}

	/**
	 * Редактирование импорта
	 *
	 * @param int $import_id идентификатор системного блока
	 * @param string $tpl_dir - путь к папке с шаблонами модуля
	 *
	 * @todo сделать отдельно методы добавления и редактирования
	 */
	function importEdit($import_id, $tpl_dir)
	{
		global $AVE_DB, $AVE_Template;

		if (is_numeric($import_id))
		{
			$row = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_import
				WHERE id = '" . $import_id . "'
			")->FetchAssocArray();
			$row['import_text'] = unserialize($row['import_text']);
		}
		else
		{
			$row['import_name'] = '';
			$row['import_text'] = array();
			$row['import_delete_docs'] = 0;
		}

		// рубрики
		$sql = $AVE_DB->Query("SELECT * FROM " . PREFIX . "_rubrics");
		while ($result = $sql->FetchRow())
		{
			$rubs[] = $result;
		}
		
		// основные поля
		$fields = array();
		foreach ($this->header_fields as $field)
		{
			$val = $row['import_text']['fields']['header'][$field];
			$fields['header'][$field] = array(0 => $val, 1 => $AVE_Template->get_config_vars('IMPORT_' . $field));
		}

		// поля
		$s = $AVE_DB->Query("
			SELECT * FROM " . PREFIX . "_rubric_fields
			WHERE rubric_id = " . $row['import_rub']
		);
		while ($r = $s->FetchAssocArray())
		{
			$val = $row['import_text']['fields']['body'][$r['Id']];
			$fields['body'][$r['Id']] = array(0 => $val, 1 => $r['rubric_field_title']);
		}
		$row['import_text']['fields'] = $fields;

		// передаём данные в смарти
		$AVE_Template->assign('rubs',$rubs);
		$AVE_Template->assign('parses', $this->parsers);
		$AVE_Template->assign('data', $row['import_text']);
		unset($row['import_text']);
		$AVE_Template->assign($row);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_edit.tpl'));
	}

	/**
	 * Сохранение импорта
	 *
	 * @param int $import_id идентификатор импорта
	 */
	function importSave($import_id = null)
	{
		global $AVE_DB;

		if (is_numeric($import_id))
		{
			$AVE_DB->Query("
				UPDATE " . PREFIX . "_modul_import
				SET
					`import_name` = '" . addslashes($_POST['import_name']) . "',
					".($_POST['import_rub']> '' ? "`import_rub` = '" . addslashes($_POST['import_rub']) . "'," : "" 	)."
					`import_parser` = '" . addslashes($_POST['import_parser']) . "',
					`import_delete_docs` = '" . ($_POST['import_delete_docs'] ? 1 : 0) . "',
					`import_default_file` = '" . addslashes($_POST['import_default_file']) . "',
					`import_monitor_file` = '" . addslashes($_POST['import_monitor_file'] ? '1' : '0') . "',
					`import_last_update` = '" . addslashes($_POST['import_last_update']) . "',
					`import_text` = '" . addslashes(serialize($_POST['document'])) . "'
				WHERE
					id = '" . $import_id . "'
			");
			header('Location:index.php?do=modules&action=modedit&mod=import&moduleaction=1&cp=' . SESSION);
		}
		else
		{
			$AVE_DB->Query("
				INSERT
				INTO " . PREFIX . "_modul_import
				SET
					`import_name` = '" . addslashes($_POST['import_name']) . "',
					`import_rub` = '" . addslashes($_POST['import_rub']) . "',
					`import_parser` = '" . addslashes($_POST['import_parser']) . "',
					`import_delete_docs` = '" . ($_POST['import_delete_docs'] ? 1 : 0) . "',
					`import_default_file` = '" . addslashes($_POST['import_default_file']) . "',
					`import_monitor_file` = '" . addslashes($_POST['import_monitor_file'] ? '1' : '0') . "',
					`import_last_update` = '" . addslashes($_POST['import_last_update']) . "',
					`import_text` = '" . addslashes(serialize($_POST['document'])) . "'
			");
			$import_id = $AVE_DB->Query("SELECT LAST_INSERT_ID(id) FROM " . PREFIX . "_modul_import ORDER BY id DESC LIMIT 1")->GetCell();
			header('Location:index.php?do=modules&action=modedit&mod=import&moduleaction=edit&id=' . $import_id . '&cp=' . SESSION);
		}
	}

	/**
	 * Удаление импорта
	 *
	 * @param int $import_id идентификатор системного блока
	 */
	function importDelete($import_id)
	{
		global $AVE_DB;

		if (is_numeric($import_id))
		{
			$AVE_DB->Query("
				DELETE
				FROM " . PREFIX . "_modul_import
				WHERE id = '" . $import_id . "'
			");
		}
		header('Location:index.php?do=modules&action=modedit&mod=import&moduleaction=1&cp=' . SESSION);
	}

	/**
	 * Импорт
	 *
	 * @param int $import_id идентификатор системного блока
	 */
	function DoImport($import_id, $tags_only=false, $location=true)
	{
		global $AVE_DB;

		$import = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_import
			WHERE id = '" . $import_id . "'
		")->FetchAssocArray();
		$import['import_text'] = @unserialize($import['import_text']);
		if($tags_only) $import['import_text']['tags'] = array();

		//Создаем массив ключевых полей
		foreach($import['import_text']['key']['header'] as $k=>$v)
		{
			$import_key_fields['header'][$k] = $import['import_text']['fields']['header'][$k];
		}
		foreach($import['import_text']['key']['body'] as $k=>$v)
		{
			$import_key_fields['body'][$k] = $import['import_text']['fields']['body'][$k];
		}

		// Получаем массив из файла импорта
		$func = $import['import_parser'];
		$rows = $this->$func(BASE_DIR . $import['import_default_file']);
		
		// Помечаем документы как удалённые, если нужно
		if($import['import_delete_docs'] && !$tags_only)
		{
			$AVE_DB->Query("
				UPDATE " . PREFIX . "_documents
				SET
					document_status = '0'
				WHERE rubric_id=" . $import['import_rub']
			);
		}
		
		// Обрабатываем по очереди каждый объект
		foreach($rows as $row)
		{
			// создаем массив замен
			$replace_array = array();
			$replace_array = $this->_replace_array($row);
			$replace_array['[Y-m-d]'] = date('Y-m-d');

			// если нужно только обновить теги
			if($tags_only)
			{
				$import['import_text']['tags'] = array_unique(array_merge($import['import_text']['tags'],array_keys($replace_array)));
			}
			else
			{
				// дополняем массив замен отсутствующими тегами
				foreach($import['import_text']['tags'] as $v)
				{
					if(!$replace_array[$v]) $replace_array[$v] = '';
				}

				$key_fields = $import_key_fields;
				$doc_fields = array();
				$doc_fields['header'] = $import['import_text']['fields']['header'];
				$doc_fields['body'] = $import['import_text']['fields']['body'];

				// гуляем по шаблонам - заменяем теги на значения
				array_walk_recursive($key_fields,array($this, '_replace'), $replace_array);
				array_walk_recursive($doc_fields,array($this, '_replace'), $replace_array);

				// проверяем наличие документа по ключевому полю
				$id = $this->Doc_Exists($key_fields,$import['import_rub']);
				if ($id)
				{
					// удаляем из массива поля, которые не надо импортировать
					foreach($import['import_text']['active']['header'] as $k=>$v)
					{
						if(!$v)
						{
							$doc_fields['header'][$k] = $AVE_DB->Query("
								SELECT " . $k . " FROM " . PREFIX . "_documents
								WHERE Id = " . $id
							)->GetCell();
						}
					}
					foreach($import['import_text']['active']['body'] as $k=>$v)
					{
						if(!$v) unset($doc_fields['body'][$k]);
					}
					unset ($doc_fields['header']['Id']);
					$this->UpdateDoc($import['import_rub'],$id,$doc_fields);
				}
				else
				{
					$id = $this->InsertDoc($import['import_rub'],$doc_fields);
				}
			}
		}
		if (!$tags_only)
		{
			$AVE_DB->Query("
				UPDATE " . PREFIX . "_modul_import
				SET
					import_last_update	= '" . time() . "',
					import_text			= '" . addslashes(serialize($import['import_text'])) . "'
				WHERE id=" . $import_id
			);
			header('Location:index.php?do=modules&action=modedit&mod=import&moduleaction=1&cp=' . SESSION);
		}
		else
		{
			$AVE_DB->Query("
				UPDATE " . PREFIX . "_modul_import
				SET
					import_text = '" . addslashes(serialize($import['import_text'])) . "'
				WHERE id = " . $import_id
			);
			if ($location)
			{
				header('Location:index.php?do=modules&action=modedit&mod=import&moduleaction=edit&id=' . $import_id . '&cp=' . SESSION);
			}
		}
	}
}
?>