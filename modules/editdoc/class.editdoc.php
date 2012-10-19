<?php
class editdoc
{

	/**
	* Метод, предназначенный для получения структуры документа из БД
	*
	* @param int $document_id	идентификатор Документа
	* return - возвращает документ положенный в структуру ....
	**/
	public static function documentGet($document_id,$rubric_id=0){
		global $AVE_DB;
		//var_dump($document_id);
		$document_id=(int)$document_id;
		$rubric_id=(int)$rubric_id;
		if($document_id==0&&$rubric_id==0)return false;
		$sql="SELECT * FROM " . PREFIX . "_documents WHERE Id='$document_id' and document_author_id=".$_SESSION['user_id']." LIMIT 1";
		$rows=$AVE_DB->Query($sql);
		if($rows->NumRows()>0)$rubric_id=0;
		if($rubric_id>0)$rows=$AVE_DB->Query("SELECT * FROM " . PREFIX . "_documents LIMIT 1");
		while ($row = $rows->FetchAssocArray()) {
				$header=$row;
			}
		if($rubric_id>0)foreach($header as $k=>&$v)$v="";	
		$felds=array();
		$feldsType=array();
		if(!$rubric_id>0){
			$rows=$AVE_DB->Query("
				SELECT
				doc.Id AS df_id,
				rub.*,
				rubric_field_default,
				doc.field_value
				FROM " . PREFIX . "_rubric_fields AS rub
				LEFT JOIN " . PREFIX . "_document_fields AS doc ON rubric_field_id = rub.Id
				WHERE document_id = '" . $document_id . "' AND rubric_id
				ORDER BY rubric_field_position ASC
			");
		}else{
			$rows=$AVE_DB->Query("
				SELECT
				0 as df_id,
				rub.*,
				rubric_field_default,
				rubric_field_default as field_value
				FROM " . PREFIX . "_rubric_fields AS rub
				WHERE rub.rubric_id = '" . $rubric_id . "'
				ORDER BY rubric_field_position ASC
			");		
		}
		while ($row = $rows->FetchAssocArray()) {
				$felds[$row['Id']]=$row['df_id'] ? $row['field_value'] : $row['rubric_field_default'];
				$feldsType[$row['Id']]['type']=$row['rubric_field_type'];
				$feldsType[$row['Id']]['title']=$row['rubric_field_title'];
			}
		$result['header']=$header;
		$result['body']=$felds;
		$result['feld_type']=$feldsType;
		//echo "<pre>";
		//var_dump($result);
		//echo "</pre>";
		return $result;	
	}
	
	public static function EditDocList($tpl_dir)
	{
		global $AVE_DB, $AVE_Template;

		$imports = array();

		$sql = $AVE_DB->Query("SELECT * FROM " . PREFIX . "_modul_editdoc");

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

		$AVE_Template->assign('editdocs', $imports);
		$AVE_Template->assign('rubs', $rubs);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_list.tpl'));
	}

	/**
	 * Добавление нового
	 *
	 * @param int $import_id идентификатор
	 * @param string $tpl_dir - путь к папке с шаблонами модуля
	 *
	 */
	public static function EditDocNew($tpl_dir)
	{
		global $AVE_DB, $AVE_Template;

		$rubs = array();

		$sql = $AVE_DB->Query("SELECT * FROM " . PREFIX . "_rubrics");

		while ($result = $sql->FetchRow())
		{
			array_push($rubs, $result);
		}

		$AVE_Template->assign('rubs',$rubs);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_edit.tpl'));
	}

	/**
	 * Редактирование
	 *
	 * @param int $import_id идентификатор
	 * @param string $tpl_dir - путь к папке с шаблонами модуля
	 *
	 */
	public static function EditDocEdit($import_id, $tpl_dir)
	{
		global $AVE_DB, $AVE_Template,$AVE_Document;

		if (is_numeric($import_id))
		{
			$sql = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_editdoc
				WHERE id = '" . $import_id . "'
			");

			$row = $sql->FetchAssocArray();
		}
		else
		{
			$row['editdoc_name'] = '';
			$row['editdoc_fill_filters']='';
		}

		$row['editdoc_fill_filters']=unserialize(base64_decode($row['editdoc_fill_filters']));
		$rubs = array();
		$sql = $AVE_DB->Query("SELECT * FROM " . PREFIX . "_rubrics");
		while ($result = $sql->FetchRow())
		{
			array_push($rubs, $result);
		}

		$AVE_Template->assign('rubs',$rubs);
		$data=editdoc::getRubricFields($row['editdoc_rub'],$row['editdoc_fill_filters']);
		//$data=editdoc::documentGet(null,$import_id);
		if(!$row['editdoc_template']){

			$tmpl="<form method=\"post\">\r\n
				<input type=\"hidden\" name=\"editdoc_action\" value=\"$import_id\">\r\n
				<input type=\"hidden\" name=\"editdoc_doc_id\" value=\"<?php echo \$_REQUEST['editdoc_doc_id']?>\">\r\n
			";

			foreach($data['header'] as $k => $v)
				$tmpl.="	<div id=\"edit_doc_header_$k\">[header:$k]</div>\r\n";

			foreach($data['body'] as $k => $v)
				$tmpl.="	<div id=\"edit_doc_body_$k\"><label>".$v[0]."</label>[body:$k]</div>\r\n";

			$tmpl.='<input type="submit" value="Сохранить"></form>';
			$row['editdoc_template']=$tmpl;
		}

		$AVE_Template->assign('data',$data);
		unset($row['editdoc_fill_filters']);
		$AVE_Template->assign($row);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_edit.tpl'));
	}


	/**
	 * Удаление
	 *
	 * @param int $import_id идентификатор
	 */
	public static function EditDocDelete($import_id)
	{
		global $AVE_DB;

		if (is_numeric($import_id))
		{
			$AVE_DB->Query("
				DELETE
				FROM " . PREFIX . "_modul_editdoc
				WHERE id = '" . $import_id . "'
			");
		}

		header('Location:index.php?do=modules&action=modedit&mod=editdoc&moduleaction=1&cp=' . SESSION);
	}
	

	/**
	 * Получение полей Документа
	 *
	 * @param inc $id - идентификатор рубрики
	 * @param array $array - массив со значениями 
	 */
	public static function getRubricFields($id,$array)
	{
		global $AVE_DB;
		$res=array();
		if(!is_array($array))$array=Array();
		$res=Array();
		$res['header']=array();
		$res['header']['document_parent'][0]=($array['header']['document_parent'] ? $array['header']['document_parent'] : "<?\r\n	return '0';\r\n?>");
		$res['header']['document_title'][0]=($array['header']['document_title'] ? $array['header']['document_title'] : "<?\r\n	return \$_REQUEST['document_title'] ? \$_REQUEST['document_title'] : \$data['header']['document_title'] ;\r\n?>");
		$res['header']['document_alias'][0]=($array['header']['document_alias'] ?  $array['header']['document_alias'] : "<?\r\n	return '';\r\n?>");
		$res['header']['document_published'][0]=($array['header']['document_published'] ? $array['header']['document_published'] : "<?\r\n	\$res= \$_REQUEST['document_published'] ? \$_REQUEST['document_published'] : \$data['header']['document_published'];\r\n return (\$res ? \$res : date('d.m.Y H:i'));\r\n?>");
		$res['header']['document_expire'][0]=($array['header']['document_expire'] ? $array['header']['document_expire'] : "<?\r\n	\$res= \$_REQUEST['document_expire'] ? \$_REQUEST['document_expire'] : \$data['header']['document_expire'];\r\n return (\$res ? \$res : date('d.m.Y H:i',strtotime('+20 years')));\r\n?>");
		$res['header']['document_meta_keywords'][0]=($array['header']['document_meta_keywords'] ? $array['header']['document_meta_keywords'] : "<?\r\n	return '';\r\n?>");
		$res['header']['document_meta_description'][0]=($array['header']['document_meta_description'] ? $array['header']['document_meta_description'] : "<?\r\n	return '';\r\n?>");
		$res['header']['document_in_search'][0]=($array['header']['document_in_search'] ? $array['header']['document_in_search'] : "<?\r\n	return '0';\r\n?>");
		$res['header']['document_meta_robots'][0]=($array['header']['document_meta_robots'] ? $array['header']['document_meta_robots'] : "<?\r\n	return 'index,follow';\r\n?>");
		$res['header']['document_status'][0]=($array['header']['document_status'] ? $array['header']['document_status'] : "<?\r\n	return '0';\r\n?>");
		$res['header']['document_deleted'][0]=($array['header']['document_deleted'] ? $array['header']['document_deleted']: "<?\r\n	return '0';\r\n?>");
		$res['header']['document_count_print'][0]=($array['header']['document_count_print'] ? $array['header']['document_count_print'] : "<?\r\n	return '0';\r\n?>");
		$res['header']['document_count_view'][0]=($array['header']['document_count_view'] ? $array['header']['document_count_view'] : "<?\r\n	return '0';\r\n?>");
		$res['header']['document_linked_navi_id'][0]=($array['header']['document_linked_navi_id'] ? $array['header']['document_linked_navi_id'] : "<?\r\n	return '0';\r	\n?>");
		foreach($res['header'] as $k=>$v)$res['header'][$k][1]=(isset($array['template'][$k]) ?	$array['template'][$k] :'');
		$sql = $AVE_DB->Query("select * from ".PREFIX."_rubric_fields where rubric_id=".$id);
		while ($result = $sql->FetchAssocArray())
		{
			$func='get_field_'.$result['rubric_field_type'];
			if(!is_callable($func)) $func='get_field_default';
			$val='<?php echo htmlspecialchars(stripslashes($_REQUEST["feld"]['.$result['Id'].'] ? ($_REQUEST["feld"]['.$result['Id'].']) : $data["body"]['.$result['Id'].']));?>';
			$field=$func("{{ХХХХ}}",'edit',$result['Id'],'',0,$x,0,0,$result['rubric_field_default']);
			$field=str_ireplace('{{ХХХХ}}',$val,$field);
			$a=array(
				'0'=>$result['rubric_field_title'],
				'1'=>(
					$array['body'][$result['Id']] ? 
					$array['body'][$result['Id']]: 
					"<?\r\n	return (isset(\$_REQUEST['feld'][".$result['Id']."]) ? \$_REQUEST['feld'][".$result['Id']."] : \$data['body'][".$result['Id']."]);\r\n?>"
				),
				'2'=>(isset($array['template'][$result['Id']]) ?	$array['template'][$result['Id']] :	$field)
				);
			$res['body'][$result['Id']]=$a;
		}
		return $res;
	}

	/**
	 * Сохранение импорта
	 *
	 * @param int $import_id идентификатор импорта
	 */
	public static function EditDocSave($import_id = null)
	{
		global $AVE_DB;

		function stripslashes_deep($value)
		{
			$value = is_array($value) ?
						array_map('stripslashes_deep', $value) :
						stripslashes($value);

			return $value;
		}

		$v=base64_encode(serialize(stripslashes_deep($_REQUEST['document'])));

		if (is_numeric($import_id))
		{
			$sql="
				UPDATE " . PREFIX . "_modul_editdoc
				SET
					`editdoc_name` = '" . ($_REQUEST['editdoc_name']) . "',
					".($_REQUEST['editdoc_rub']> '' ? "`editdoc_rub` = '" . ($_REQUEST['editdoc_rub']) . "'," : "")."
					`editdoc_lastchange` = '" . ($_REQUEST['editdoc_lastchange']) . "',
					`editdoc_fill_filters` = '" . $v . "',
					`editdoc_template` = '" . $_REQUEST['editdoc_template'] . "',
					`editdoc_afteredit` = '" . (($_REQUEST['editdoc_afteredit'] ? $_REQUEST['editdoc_afteredit'] : addslashes("<?php 
					//header('location : /'.rewrite_link('index.php?id='.\$GLOBAL['mod_editdoc'][".$import_id."]));
					?>"))) . "'
				WHERE
					id = '" . $import_id . "'
			";
		}
		else
		{
			$sql="
				INSERT
				INTO " . PREFIX . "_modul_editdoc
				SET
					id = '',
					`editdoc_name` = '" . ($_REQUEST['editdoc_name']) . "',
					".($_REQUEST['editdoc_rub']> '' ? "`editdoc_rub` = '" . ($_REQUEST['editdoc_rub']) . "'," : "")."
					`editdoc_lastchange` = '" . ($_REQUEST['editdoc_lastchange']) . "',
					`editdoc_fill_filters` = '" . $v . "',
					`editdoc_template` = '" . ($_REQUEST['editdoc_template']) . "',
					`editdoc_afteredit` = '" . ($_REQUEST['editdoc_afteredit']) . "'
			";
		}
		$AVE_DB->Query($sql);
		header('Location:index.php?do=modules&action=modedit&mod=editdoc&moduleaction=1&cp=' . SESSION);
	}
	
	static function EditDocDo($import_id)
	{
		global $AVE_DB, $AVE_Document;
				
		if (is_numeric($import_id))
		{
			$sql = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_editdoc
				WHERE id = '" . $import_id . "'
			");
			$row = $sql->FetchAssocArray();
			$row['editdoc_fill_filters']=unserialize(base64_decode($row['editdoc_fill_filters']));
			$document_id=(isset($_REQUEST['editdoc_doc_id']) ? (int)$_REQUEST['editdoc_doc_id'] : null);
			$data=editdoc::documentGet($document_id,(int)$row['editdoc_rub']);
			//Пришла форма
			if(isset($_REQUEST['editdoc_action']) && $_REQUEST['editdoc_action']==$import_id){
				//вот тут сохранение будет
				$save=true;
				foreach($row['editdoc_fill_filters']['header'] as $k=>$v)
				{
					$exp='
					function editdoc_reth_'.$import_id.'_'.$k.'($data){
						?>'.trim($v).'<?
					};';
					eval($exp);
					$ret='editdoc_reth_'.$import_id.'_'.$k;
					$data['header'][$k]=$ret($data);	
					if($data['header'][$k]===NULL){
						$save=false;
					}
				}
				$data['header']['rubric_id']=$row['editdoc_rub'];

				foreach($row['editdoc_fill_filters']['body'] as $k=>$v)
				{
					$exp='
					function editdoc_retb_'.$import_id.'_'.$k.'($data){
						?>'.trim($v).'<?
					};';
					eval($exp);
					$ret='editdoc_retb_'.$import_id.'_'.$k;
					$data['body'][$k]=$ret($data);	
					if($data['body'][$k]===NULL){
						$save=false;
					}
				}

				$d=$data['header'];
				$d['doc_title']=$d['document_title'];
				$d['feld']=$data['body'];
				require(BASE_DIR . '/admin/editor/fckeditor.php');
				require_once(BASE_DIR.'/class/class.docs.php');
				$AVE_Document=new AVE_Document();
				$AVE_Document->documentPermissionFetch($row['editdoc_rub']);
				require_once(BASE_DIR.'/admin/functions/func.admin.common.php');
				if($save){
					//надо перед сохранением уточнить являюсь ли я хозяином документа .....не забыть!!!!!!!!!! а то админы тут делов наделают
					$GLOBAL['mod_editdoc'][$import_id]=$AVE_Document->documentSave((int)$row['editdoc_rub'],$document_id,$d,true);
					eval(' ?>'.$row['editdoc_afteredit'].'<? ');
				}	
				
			}
			$template=$row['editdoc_template'];
			foreach($row['editdoc_fill_filters']["body"] as $k=>$v)$template=str_ireplace("[body:$k]",$row['editdoc_fill_filters']["template"][$k],$template);
			foreach($row['editdoc_fill_filters']["header"] as $k=>$v)$template=str_ireplace("[header:$k]",$row['editdoc_fill_filters']["template"][$k],$template);
			eval(' ?>'.$template.'<? ');

		}

	}
}

?>