<?php
/**
 * Класс работы с системными блоками
 *
 * @package AVE.cms
 * @subpackage module_SysBlock
 * @author Mad Den
 * @since 2.07
 * @filesource
 */
class Import
{
	public static function getParsers()
	{
		return array(
				'CSV2Array',
				'XML2Array',
			);
	}
	
	/**
	 * Получение полей Документа
	 *
	 * @param inc $id - идентификатор рубрики
	 * @param array $array - массив со значениями 
	 */
	public static function getRubricFields($id,$array)
	{
		global $AVE_DB, $AVE_Template;
		$res=array();

		$res['header']['document_title']=$array['header']['document_title'];
		$res['header']['document_alias']=$array['header']['document_alias'];
		$res['header']['document_meta_keywords']=$array['header']['document_meta_keywords'];
		$res['header']['document_meta_description']=$array['header']['document_meta_description'];
		$res['header']['document_meta_robots']=$array['header']['document_meta_robots'];
		$res['header']['document_published']=$array['header']['document_published'];
		$res['header']['document_in_search']=$array['header']['document_in_search'];
		$res['header']['document_status']=$array['header']['document_status'];
		$res['header']['document_deleted']=$array['header']['document_deleted'];
		$res['header']['document_linked_navi_id']=$array['header']['document_linked_navi_id'];
		$res['header']['document_breadcrum_title']=$array['header']['document_breadcrum_title'];
		$res['header']['document_parent']=$array['header']['document_parent'];
		$res['header']['document_count_view']=$array['header']['document_count_view'];

		$res['name']['document_title']=$AVE_Template->get_config_vars('IMPORT_FLD_TITLE');
		$res['name']['document_alias']=$AVE_Template->get_config_vars('IMPORT_FLD_ALIAS');
		$res['name']['document_meta_keywords']=$AVE_Template->get_config_vars('IMPORT_FLD_META_KEYWORDS');
		$res['name']['document_meta_description']=$AVE_Template->get_config_vars('IMPORT_FLD_META_DESCRIPTION');
		$res['name']['document_meta_robots']=$AVE_Template->get_config_vars('IMPORT_FLD_META_ROBOTS');
		$res['name']['document_published']=$AVE_Template->get_config_vars('IMPORT_FLD_PUBLISHED');
		$res['name']['document_in_search']=$AVE_Template->get_config_vars('IMPORT_FLD_IN_SEARCH');
		$res['name']['document_status']=$AVE_Template->get_config_vars('IMPORT_FLD_STATUS');
		$res['name']['document_deleted']=$AVE_Template->get_config_vars('IMPORT_FLD_DELETED');
		$res['name']['document_linked_navi_id']=$AVE_Template->get_config_vars('IMPORT_FLD_LINKED_NAVI_ID');
		$res['name']['document_breadcrum_title']=$AVE_Template->get_config_vars('IMPORT_FLD_BREADCRUM_TITLE');
		$res['name']['document_parent']=$AVE_Template->get_config_vars('IMPORT_FLD_PARENT');
		$res['name']['document_count_view']=$AVE_Template->get_config_vars('IMPORT_FLD_COUNT_VIEW');
		
		//$sql = $AVE_DB->Query("select * from ".PREFIX."_rubric_fields where rubric_id=".$id);
		$sql = $AVE_DB->Query("select * from ".PREFIX."_rubric_fields where rubric_id=".(int)$id);
		while ($result = $sql->FetchAssocArray())
		{
			$a=array('0'=>$array['body'][$result['Id']],'1'=>$result['rubric_field_title']);
			$res['body'][$result['Id']]=($a);
		}
		$res['key']=$array['key'];
		$res['tags']=$array['tags'];
		return $res;
	}
	/**
	 * Вывод списка импортов
	 *
	 * @param string $tpl_dir - путь к папке с шаблонами модуля
	 */
	public static function importList($tpl_dir)
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
	* Удаление документа
	* 
	* @param int $id идентификатор документа
	*/
	
	public static function DeleteDoc($id)
	{
		global $AVE_DB;
		$res=$AVE_DB->Query("
				UPDATE " . PREFIX . "_documents 
				SET
					document_status = 0,
					document_deleted = 1
				WHERE Id=". $id ."
			");
	}
	/**
	* Изменение документа
	* @param int $id идентификатор документа
	* @param array $array набор данных документа
	*/
	
	public static function UpdateDoc($rub,$id,$array)
	{
		require_once(BASE_DIR.'/class/class.docs.php');
		$AVE_Document=new AVE_Document();
		$d=$array['header'];
		$d['doc_title']=$d['document_title'];
		$d['document_expire']=date("d.m.Y H:i",strtotime('+20 year'));
	//	$d['document_status']=1;
		$d['feld']=$array['body'];
		return $AVE_Document->documentSave((int)$rub,$id,$d);
	}

	/**
	* Добавление документа
	*
	* @param int $rub идентификатор рубрики
	* @param array $array набор данных документа
	*/
	
	public static function InsertDoc($rub,$array)
	{
		require_once(BASE_DIR.'/class/class.docs.php');
		$AVE_Document=new AVE_Document();
		$d=$array['header'];
		$d['document_expire']=date("d.m.Y H:i",strtotime('+20 year'));
	//	$d['document_status']=1;
		$d['doc_title']=$d['document_title'];
		$d['feld']=$array['body'];		
		return $AVE_Document->documentSave((int)$rub,null,$d);
	}

	/**
	 * Проверка наличия документа по ключевым полям
	 *
	 * @param array $array массив ID_поля_в_рублике=>Ключевое_значение возвращает Id документа или false
	 */
	

	public static function Doc_Exists($array,$rub)
	{
		global $AVE_DB;
		$tables=array();
		$where=array();
		$x=0;
		foreach($array as $k=>$v){
			$tables[]=PREFIX ."_document_fields AS t".$x;
			$where[]="(a.Id=t".$x.".document_id AND(t".$x.".rubric_field_id=".$k." AND t".$x.".field_value='".addslashes($v)."'))";
			$x++;
		}
		$sql="SELECT a.Id from ". PREFIX ."_documents AS a,".implode(','.chr(10),$tables)." WHERE a.rubric_id=".$rub." AND ".implode(chr(10).' AND ',$where);
		$res=$AVE_DB->Query($sql);
		$res=$res->GetCell();
		return ($res>'' ? $res : false);
	}
	
	/**
	 * Сохранение импорта
	 *
	 * @param int $import_id идентификатор импорта
	 */
	public static function importSave($import_id = null)
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
					`import_default_file` = '" . addslashes($_POST['import_default_file']) . "',
					`import_monitor_file` = '" . addslashes($_POST['import_monitor_file'] ? '1' : '0') . "',
					`import_last_update` = '" . addslashes($_POST['import_last_update']) . "',
					`import_text` = '" . addslashes(serialize($_POST['document'])) . "'
				WHERE
					id = '" . $import_id . "'
			");
		}
		else
		{
			$AVE_DB->Query("
				INSERT
				INTO " . PREFIX . "_modul_import
				SET
					id = '',
					`import_name` = '" . addslashes($_POST['import_name']) . "',
					`import_rub` = '" . addslashes($_POST['import_rub']) . "',
					`import_parser` = '" . addslashes($_POST['import_parser']) . "',
					`import_default_file` = '" . addslashes($_POST['import_default_file']) . "',
					`import_monitor_file` = '" . addslashes($_POST['import_monitor_file'] ? '1' : '0') . "',
					`import_last_update` = '" . addslashes($_POST['import_last_update']) . "',
					`import_text` = '" . addslashes(serialize($_POST['document'])) . "'
			");
		}

		header('Location:index.php?do=modules&action=modedit&mod=import&moduleaction=1&cp=' . SESSION);
	}

	/**
	 * Редактирование системного блока
	 *
	 * @param int $import_id идентификатор системного блока
	 * @param string $tpl_dir - путь к папке с шаблонами модуля
	 *
	 * @todo сделать отдельно методы добавления и редактирования
	 */
	public static function importEdit($import_id, $tpl_dir)
	{
		global $AVE_DB, $AVE_Template;

		if (is_numeric($import_id))
		{
			$sql = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_import
				WHERE id = '" . $import_id . "'
			");

			$row = $sql->FetchAssocArray();
		}
		else
		{
			$row['import_name'] = '';
			$row['import_text'] = '';
		}

		$row['import_text']=@unserialize($row['import_text']);
		$rubs = array();
		$sql = $AVE_DB->Query("SELECT * FROM " . PREFIX . "_rubrics");
		while ($result = $sql->FetchRow())
		{
			array_push($rubs, $result);
		}
		//var_dump($row['import_text']);
		$AVE_Template->assign('rubs',$rubs);
		$AVE_Template->assign('parses',Import::getParsers());
		$AVE_Template->assign('data',Import::getRubricFields($row['import_rub'],$row['import_text']));
		unset($row['import_text']);
		$AVE_Template->assign($row);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_edit.tpl'));
	}

	/**
	 * Удаление системного блока
	 *
	 * @param int $import_id идентификатор системного блока
	 */
	public static function importDelete($import_id)
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
	 * Удаление системного блока
	 *
	 * @param int $import_id идентификатор системного блока
	 */
	public static function DoImport($import_id, $jaststructure=false)
	{
		function replace_a(&$item, &$key, $repl_array)
		{
		//	echo $item.'<br>';
			$item=eval2var('?>'.stripslashes(strtr($item,$repl_array)).'<?');
		}
		function recurs($mixed,$key="")
		{
			global $enctext;
			static $arr=array();
			if (!is_array($mixed)) return $arr['[row'.$key.']']=$mixed;
			$res=$key;
			foreach ($mixed as $k=>$v)
			{
					if(is_array($v))$arr['[row:'.$k.']']=serialize($v);
					recurs($v,$res.':'.$k);
			}
			return $arr;
		}
		// определить кодировку текста
		function detectEncoding($string) {
			static $list = array('utf-8', 'windows-1251');
			foreach ($list as $item) {
				$sample = @iconv($item, $item, $string);
				if (md5($sample) == md5($string))
					return $item;
			}
			return null;
		}
		
		global $AVE_DB;
		//проверяем наличие файла
		//if(!file_exists(BASE_DIR.$import['import_default_file'])){return false;}
		$enctext=detectEncoding(file_get_contents(BASE_DIR.$import['import_default_file']));
		$ids=array();
		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_import
			WHERE id = '" . $import_id . "'
		");
		$import = $sql->FetchAssocArray();
		$import['import_text']=@unserialize($import['import_text']);
		//Создаем массив ключевых полей
		$keys=Array();
		foreach($import['import_text']['key'] as $k=>$v)
		{
			$keys[$k]=$import['import_text']['body'][$k];
		}
		$func=$import['import_parser'];
		$rows=$func(BASE_DIR.$import['import_default_file']);
		//$rows=@$import['import_parser']((BASE_DIR.$import['import_default_file']));
		$res=$AVE_DB->Query("UPDATE ".PREFIX."_documents SET document_status = 0, document_deleted=1 WHERE rubric_id=".$import['import_rub']);
		foreach($rows as $k1=>$row){
			$doc=array();
			$doc['header']=$import['import_text']['header'];
			$doc['body']=$import['import_text']['body'];
			$kk=$keys;
			//создаем массив замен
			$replace_array=recurs($row);
			$import['import_text']['tags']=array_keys($replace_array);
			$replace_array['[Y-m-d]']=date('Y-m-d');
			//гуляем по шаблону - заменяем теги на значения
			array_walk_recursive($kk,'replace_a',$replace_array);
			array_walk_recursive($doc, 'replace_a',$replace_array);
			//проверяем наличие документа по ключевому полю
		//echo "<pre>";
		//var_dump($doc);
		//echo "</pre>";
			if(!$jaststructure){
				$id=Import::Doc_Exists($kk,$import['import_rub']);
				if($id)
				{
					$ids[]=$id;
					//Тут сносим из массива знаечния которые может быть пользователь внес ручками по принципу - нету шаблона заполнения на поле - нечего и менять 
					foreach($import['import_text']['body'] as $k=>$v)if($v=='')unset($doc["body"][$k]);
					//die();
					Import::UpdateDoc($import['import_rub'],$id,$doc);
				}
				else
				{
					$id=Import::InsertDoc($import['import_rub'],$doc);
					$ids[]=$id;
				}
			}
		}
		if(!$jaststructure)
			{
				$res=$AVE_DB->Query("UPDATE ".PREFIX."_modul_import
					SET
						import_last_update = '".time()."',
						`import_text` = '" . addslashes(serialize($import['import_text'])) . "'
						WHERE id=".$import_id
						);
			}
			else
			{
				$res=$AVE_DB->Query("UPDATE ".PREFIX."_modul_import
					SET
						`import_text` = '" . addslashes(serialize($import['import_text'])) . "'
						WHERE id=".$import_id
						);
			}

		header('Location:index.php?do=modules&action=modedit&mod=import&moduleaction=1&cp=' . SESSION);
	}

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
function CSV2Array($csvfile,$fldnames=null,$sep=';',$protect='"',$filters=null){
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
function object_to_array($Class){
	# Typecast to (array) automatically converts stdClass -> array.
	$Class = (array)$Class;
    $emptyarr=array();
	if($emptyarr===$Class) return '';
	# Iterate through the former properties looking for any stdClass properties.
	# Recursively apply (array).
	foreach($Class as $key => &$value){
		if((is_object($value)||is_array($value))){
			$Class[$key] = object_to_array($value);
		}
		//$value=addslashes($value);
	}
	return $Class;
}
function XML2Array($fname) {
	$xml=(simplexml_load_file($fname));
	$xml=object_to_array($xml);
	//Убираем роот элемент из Массива чтобы добраться до самих записей - может есть варианты полегче ...
	$a=array_values($xml);
	//echo "<pre>";
	//var_dump($a[0]);
	//echo "</pre>";
    return ($a[0]);
}

function VolgainfoImport($fname){
	$data=file_get_contents(str_replace(BASE_DIR,'',$fname));
	$data=json_decode($data);
	$data=object_to_array($data);
	//echo "<pre>";
	//var_dump($data['RESULT']);
	//echo "</pre>";
	//die();
	return $data['RESULT'];
}
?>