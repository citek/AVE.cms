<?php
// Определяем пустое изображение
$img_pixel = 'templates/' . $_SESSION['admin_theme'] . '/images/blanc.gif';

function get_field_default($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	global $AVE_Template, $AVE_Core, $AVE_Document;
	$res=0;
	switch ($type)
	{
		case 'edit' :
				$field  = '<a name="' . $field_id . '"></a>';
				$field .= '<input id="feld_' . $field_id . '" type="text" style="width:' . $AVE_Document->_field_width . '" name="feld[' . $field_id . ']" value="' . htmlspecialchars($field_value, ENT_QUOTES) . '"> ';
				$res=$field;
			break;

		case 'doc' :
			//$field_value = htmlspecialchars($field_value, ENT_QUOTES);
			$field_value = pretty_chars($field_value);
			$field_value = clean_php($field_value);
			$field_value = str_replace('"', '&quot;', $field_value);
			if (!$tpl_field_empty)
			{
				$field_param = explode('|', $field_value);
				$field_value = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_param[\\1]', $rubric_field_template);
			}
			$res=$field_value;
			break;

		case 'req' :
			$field_value = clean_php($field_value);
			$field_param = explode('|', $field_value);
			$field_param[1] = isset($field_param[1]) ? $field_param[1] : '';
			$field_value = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_param[\\1]', $document_fields[$rubric_id]['rubric_field_template_request']);
			$res=$field_value;
			break;
	}
	return ($res ? $res : $field_value);
}

//Однострочное
function get_field_kurztext($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	global $AVE_Template, $AVE_Core, $AVE_Document;
	$res=0;
	switch ($type)
	{
		case 'edit' :
				$field  = '<a name="' . $field_id . '"></a>';
				$field .= '<input id="feld_' . $field_id . '" type="text" style="width:' . $AVE_Document->_field_width . '" name="feld[' . $field_id . ']" value="' . htmlspecialchars($field_value, ENT_QUOTES) . '"> ';
				$res=$field;
			break;

		case 'doc' :
			//$field_value = htmlspecialchars($field_value, ENT_QUOTES);
			$field_value = pretty_chars($field_value);
			$field_value = clean_php($field_value);
			$field_value = str_replace('"', '&quot;', $field_value);
			if (!$tpl_field_empty)
			{
				$field_param = explode('|', $field_value);
				$field_value = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_param[\\1]', $rubric_field_template);
			}
			$res=$field_value;
			break;

		case 'req' :
			$res=get_field_default($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength,$document_fields,$rubric_id);
			break;

		case 'name' :
			$res='FIELD_TEXT';
		break;
	}
	return ($res ? $res : $field_value);
}

//Многострочное (Упрощенное)
function get_field_smalltext($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	global $AVE_Template, $AVE_Core, $AVE_Document;
	$res=0;
	switch ($type)
	{
		case 'edit' :
				if (isset($_COOKIE['no_wysiwyg']) && $_COOKIE['no_wysiwyg'] == 1)
				{
					$field  = "<a name=\"" . $field_id . "\"></a>";
					$field .= "<textarea style=\"width:" . $AVE_Document->_textarea_width_small . "; height:" . $AVE_Document->_textarea_height_small . "\"  name=\"feld[" . $field_id . "]\">" . $field_value . "</textarea>";
				}
				else
				{
					switch ($_SESSION['use_editor']) {
					case '0': // стандартный редактор
						$oFCKeditor = new FCKeditor('feld[' . $field_id . ']') ;
						$oFCKeditor->Height = $AVE_Document->_textarea_height_small;
						$oFCKeditor->Value  = $field_value;
						$oFCKeditor->ToolbarSet = 'cpengine_small';
						$field = $oFCKeditor->Create($field_id);
						break;
						
					case '1': // Elrte и Elfinder 
						$field  = '<a name="' . $field_id . '"></a>';
						$field  .='<textarea style="width:' . $AVE_Document->_textarea_width_small . ';height:' . $AVE_Document->_textarea_height_small . '" name="feld[' . $field_id . ']" class="small-editor">' . $field_value . '</textarea>';
						break;
						
					case '2': // Innova
						require(BASE_DIR . "/admin/redactor/innova/innova_settings.php");
						$field  = '<a name="' . $field_id . '"></a>';
						$field .= "<textarea style=\"width:" . $AVE_Document->_textarea_width_small . "; height:" . $AVE_Document->_textarea_height_small . "\"  name=\"feld[" . $field_id . "]\" Id=\"small-editor[" . $field_id . "]\">" . $field_value . "</textarea>";
						$field  .= $innova[2];
						break;	
					}		
				}
				$res=$field;
				break;
		case 'doc' :
			$field_value = document_pagination($field_value);
			$field_value = pretty_chars($field_value);
			if (!$tpl_field_empty)
			{
				$field_param = explode('|', $field_value);
				$field_value = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_param[\\1]', $rubric_field_template);
			}
			$res=$field_value;
			break;

		case 'req' :
			$res=get_field_default($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength,$document_fields,$rubric_id);
			break;

		case 'name' :
			$res='FIELD_TEXTAREA_S';
		break;
	}
	return ($res ? $res : $field_value);

}

//Многострочное
function get_field_langtext($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	global $AVE_Template, $AVE_Core, $AVE_Document;
	$res=0;
	switch ($type)
	{
		case 'edit' :
				if (isset($_COOKIE['no_wysiwyg']) && $_COOKIE['no_wysiwyg'] == 1)
				{
					$field  = '<a name="' . $field_id . '"></a>';
					$field .= '<textarea style="width:' . $AVE_Document->_textarea_width . ';height:' . $AVE_Document->_textarea_height . '" name="feld[' . $field_id . ']">' . $field_value . '</textarea>';
				}
				else
				{							
					switch ($_SESSION['use_editor']) {
					case '0': // стандартный редактор
						$oFCKeditor = new FCKeditor('feld[' . $field_id . ']') ;
						$oFCKeditor->Height = $AVE_Document->_textarea_height;
						$oFCKeditor->Value  = $field_value;
						$field  = $oFCKeditor->Create($field_id);
						break;
						
					case '1': // Elrte и Elfinder 
						$field  = '<a name="' . $field_id . '"></a>';
						$field  .='<textarea style="width:' . $AVE_Document->_textarea_width . ';height:' . $AVE_Document->_textarea_height . '" name="feld[' . $field_id . ']" class="editor">' . $field_value . '</textarea></div>';
						break;
						
					case '2': // Innova
						require(BASE_DIR . "/admin/redactor/innova/innova_settings.php");
						$field  = '<a name="' . $field_id . '"></a>';
						$field  .='<textarea style="width:' . $AVE_Document->_textarea_width . ';height:' . $AVE_Document->_textarea_height . '" name="feld[' . $field_id . ']" Id="editor[' . $field_id . ']">' . $field_value . '</textarea></div>';
						$field  .= $innova[1];
						break;	
					}					
				}
				$res=$field;
			break;
		case 'doc' :
			$res=get_field_smalltext($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength,$document_fields,$rubric_id);
			break;

		case 'req' :
			$res=get_field_default($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength,$document_fields,$rubric_id);
			break;

		case 'name' :
			$res='FIELD_TEXTAREA';
		break;
	}
	return ($res ? $res : $field_value);
}

//Изображение
function get_field_bild($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	global $AVE_Template, $AVE_Core, $AVE_Document,$img_pixel;
	$res=0; 
	switch ($type)
	{
		case 'edit' :
				$blanc = 'templates/' . $_SESSION['admin_theme'] . '/images/blanc.gif';
				$massiv = explode('|', $field_value);
				$field .= "<div><img id=\"preview__" . $field_id . "\" src=\"" . (!empty($field_value) ? '../' . make_thumbnail(array('link' => $massiv[0])) : $blanc) . "\" height=\"120px\" alt=\"\" border=\"0\" /></div>";

				switch ($_SESSION['use_editor']) {
					case '0': // стандартный редактор
					case '2':
						$field .= "<input type=\"text\" style=\"width:" . $AVE_Document->_field_width . "\" name=\"feld[" . $field_id . "]\" value=\"" . htmlspecialchars($field_value, ENT_QUOTES) . "\" id=\"image__" . $field_id . "\" />&nbsp;";
						$field .= "<input type=\"button\" class=\"basicBtn\" value=\"...\" title=\"" . $AVE_Template->get_config_vars('MAIN_OPEN_MEDIAPATH') . "\" onclick=\"browse_uploads('image__" . $field_id . "');\" />";
						break;

					case '1': // Elrte и Elfinder
						$field .= "<input class=\"docm finder\" type=\"text\" style=\"width:" . $AVE_Document->_field_width . "\" name=\"feld[" . $field_id . "]\" value=\"" . htmlspecialchars($field_value, ENT_QUOTES) . "\" id=\"img_feld__" . $field_id . "\"/>&nbsp;";
						$field .= "<span class=\"button basicBtn dialog_images\" rel=\"". $field_id ."\">" . $AVE_Template->get_config_vars('MAIN_OPEN_MEDIAPATH') . "</span>";
						break;
				}
				$res=$field;
				break;
		case 'doc' :
			$field_value = clean_php($field_value);
			$field_param = explode('|', $field_value);
			if ($tpl_field_empty)
			{
				$field_value = '<img alt="' . (isset($field_param[1]) ? $field_param[1] : '')
					. '" src="' . ABS_PATH . $field_param[0] . '" border="0" />';
			}
			else
			{
				$field_value = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_param[\\1]', $rubric_field_template);
				$field_value = preg_replace_callback('/\[tag:([r|c]\d+x\d+r*):(.+?)]/', 'callback_make_thumbnail', $field_value);
			}
			$res=$field_value;
			break;

		case 'req' :
			$field_value = clean_php($field_value);
			$field_param = explode('|', $field_value);
			$field_param[1] = isset($field_param[1]) ? $field_param[1] : '';
			if ($document_fields[$rubric_id]['tpl_req_empty'])
			{
				$field_value = '<img src="' . ABS_PATH . $field_param[0] . '" alt="' . $field_param[1] . '" border="0" />';
			}
			else
			{
				$field_value = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_param[\\1]', $document_fields[$rubric_id]['rubric_field_template_request']);
                $field_value = preg_replace_callback('/\[tag:([r|c]\d+x\d+r*):(.+?)]/', 'callback_make_thumbnail', $field_value);
			}
			$maxlength = '';
			$res=$field_value;
			break;

		case 'name' :
			$res='FIELD_IMAGE';
		break;
	}
	return ($res ? $res : $field_value);
}

//Выпадающий список
function get_field_dropdown($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	global $AVE_Template, $AVE_Core, $AVE_Document;
	$res=0;
	switch ($type)
	{
		case 'edit' :
				$items = explode(',', $dropdown);
				$field = "<select name=\"feld[" . $field_id . "]\">";
				$cnt = sizeof($items);
				for ($i=0;$i<$cnt;$i++)
				{
					$field .= "<option value=\"" . htmlspecialchars($items[$i], ENT_QUOTES) . "\"" . ((trim($field_value) == trim($items[$i])) ? " selected=\"selected\"" : "") . ">" . htmlspecialchars($items[$i], ENT_QUOTES) . "</option>";
				}
				$field .= "</select>";
				$res=$field;
			break;

		case 'doc' :
			$field_value = clean_php($field_value);
			if (!$tpl_field_empty)
			{
				$field_param = explode('|', $field_value);
				$field_value = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_param[\\1]', $rubric_field_template);
			}
			$res=$field_value;
			break;
			
		case 'req' :
			$res=get_field_default($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength,$document_fields,$rubric_id);
			break;
			
		case 'name' :
			$res='FIELD_DROPDOWN';
		break;

	}
	return ($res ? $res : $field_value);
}

//Чекбокс
function get_field_checkbox($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	global $AVE_Template, $AVE_Core, $AVE_Document;
	$res=0;
	switch ($type)
	{
		case 'edit' :
			$field = "<input type=\"hidden\" name=\"feld[" . $field_id . "]\" value=\"\">
				      <input type=\"checkbox\" name=\"feld[" . $field_id . "]\" value=\"1\"" . (((int)$field_value == 1) ? " checked" : "") . ">";
			$res=$field;
			break;

		case 'doc' :
			$field_value = clean_php($field_value);
			if ((int)$field_value != 1) $field_value = 0;
			if (!$tpl_field_empty)
			{
				$field_value = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_value', $rubric_field_template);
			}
			$res=$field_value;
			break;

		case 'req' :
			$field_value = clean_php($field_value);
			if ((int)$field_value != 1) $field_value = 0;
			$field_value = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_value', $document_fields[$rubric_id]['rubric_field_template_request']);
			$res=$field_value;
			break;

		case 'name' :
			$res='FIELD_CHECKBOX';
		break;

	}
	return ($res ? $res : $field_value);
}

//Мульти список
function get_field_multidropdown($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	global $AVE_Template, $AVE_Core, $AVE_Document;
	$res=0;
	switch ($type)
	{
		case 'edit' :
				$items = explode(',', $dropdown);
				$field_value = unserialize($field_value);
				$field = "<select size=\"10\" style=\"width: 350px;\" multiple=\"multiple\" name=\"feld[" . $field_id . "][]\">";
				$cnt = sizeof($items);
				for ($i=0;$i<$cnt;$i++)
				{
					if (in_array($items[$i], $field_value))
					{
						$field .= "<option value=\"" . htmlspecialchars($items[$i], ENT_QUOTES) .  "\" selected=\"selected\">" . htmlspecialchars($items[$i], ENT_QUOTES) . "</option>";
					}else{
				   		$field .= "<option value=\"" . htmlspecialchars($items[$i], ENT_QUOTES) . "\">" . htmlspecialchars($items[$i], ENT_QUOTES) . "</option>";
					}
				}
				$field .= "</select>";
				$res=$field;
			break;

		case 'doc' :
			$massa=unserialize($field_value);
			$res='';
			if($massa!=false)
				foreach($massa as $k=>$v)
				{
					$v = clean_php($v);
					$field_param = explode('|', $v);
					if($v){
						if ($tpl_field_empty)
						{
							$v = $field_param[0];
						}
						else
						{
							$v = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_param[\\1]', $rubric_field_template);
						}
					}
					$res.=$v;
				}
			break;

		case 'req' :
			$massa=unserialize($field_value);
			$res='';
			if($massa!=false)
				foreach($massa as $k=>$v)
				{
					$v = clean_php($v);
					$field_param = explode('|', $v);
					if($v){
						if ($tpl_field_empty)
						{
							$v = $field_param[0];
						}
						else
						{
							$v = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_param[\\1]', $rubric_field_template);
						}
					}
					$res.=$v;
				}
			break;

		case 'name' :
			$res='FIELD_MDROPDOWN';
		break;

	}
	return ($res ? $res : $field_value);
}

//Ссылка
function get_field_link($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	global $AVE_Template, $AVE_Core, $AVE_Document;
	$res=0;
	switch ($type)
	{
		case 'edit' :
				$field  = "<a name=\"" . $field_id . "\"></a>";
				$field .= "<input id=\"feld_" . $field_id . "\" type=\"text\" style=\"width:" . $AVE_Document->_field_width . "\" name=\"feld[" . $field_id . "]\" value=\"" . htmlspecialchars($field_value, ENT_QUOTES) . "\">&nbsp;";
				$field .= "<input value=\"" . $AVE_Template->get_config_vars('MAIN_BROWSE_DOCUMENTS') . "\" class=\"basicBtn\" type=\"button\" onclick=\"openLinkWin('feld_" . $field_id . "', 'feld_" . $field_id . "');\" />";
				$res=$field;
			break;

		case 'doc' :
			$field_value = clean_php($field_value);
			$field_param = explode('|', $field_value);
			$field_param[1] = empty($field_param[1]) ? $field_param[0] : $field_param[1];
			if ($tpl_field_empty)
			{
				$field_value = ' <a target="_self" href="' . ABS_PATH . $field_param[0] . '">' . $field_param[1] . '</a>';
			}
			else
			{
				$field_value = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_param[\\1]', $rubric_field_template);
			}
			$res=$field_value;
			break;

		case 'req' :
			$field_value = clean_php($field_value);
			$field_param = explode('|', $field_value);
			if (empty($field_param[1])) $field_param[1] = $field_param[0];
			if ($document_fields[$rubric_id]['tpl_req_empty'])
			{
				$field_value = " <a target=\"_self\" href=\"" . ABS_PATH . $field_param[0] . "\">" . $field_param[1] . "</a>";
			}
			else
			{
				$field_value = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_param[\\1]', $document_fields[$rubric_id]['rubric_field_template_request']);
			}
			$maxlength = '';
			$res=$field_value;
			break;

		case 'name' :
			$res='FIELD_LINK';
		break;
	
	}
	return ($res ? $res : $field_value);
}
//Flash-ролик
function get_field_flash($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	global $AVE_Template, $AVE_Core, $AVE_Document,$img_pixel;
	$res=0;
	switch ($type)
	{
		case 'edit' :
				$field  = "<a name=\"" . $field_id . "\"></a>";
				$field .= "<div style=\"display:none\" id=\"feld_" . $field_id . "\"><img style=\"display:none\" id=\"_img_feld__" . $field_id . "\" src=\"". (!empty($field_value) ? htmlspecialchars($field_value, ENT_QUOTES) : $img_pixel) . "\" alt=\"\" border=\"0\" /></div>";
				$field .= "<div style=\"display:none\" id=\"span_feld__" . $field_id . "\"></div>";
				$field .= "<input type=\"text\" style=\"width:" . $AVE_Document->_field_width . "\" name=\"feld[" . $field_id . "]\" value=\"" . htmlspecialchars($field_value, ENT_QUOTES) . "\" id=\"img_feld__" . $field_id . "\" />&nbsp;";
				$field .= "<input value=\"" . $AVE_Template->get_config_vars('MAIN_OPEN_MEDIAPATH') . "\" class=\"basicBtn\" type=\"button\" onclick=\"cp_imagepop('img_feld__" . $field_id . "', '', '', '0');\" />";
				$field .= '<a class="basicBtn topDir" title="'.$AVE_Template->get_config_vars('DOC_FLASH_TYPE_HELP').'" href="#">?</a>';
				$res=$field;
			break;

		case 'doc' :
			$field_value = clean_php($field_value);
			$field_param = explode('|', $field_value);
			$field_param[1] = (!empty($field_param[1]) && is_numeric($field_param[1])) ? $field_param[1] : 470;
			$field_param[2] = (!empty($field_param[2]) && is_numeric($field_param[2])) ? $field_param[2] : 320;
			if ($tpl_field_empty)
			{
				$field_value = '<embed scale="exactfit" width="' . $field_param[1] . '" height="' . $field_param[2]
					. '" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" src="'
					. ABS_PATH . $field_param[0] . '" play="true" loop="true" menu="true"></embed>';
			}
			else
			{
				$field_value = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_param[\\1]', $rubric_field_template);
			}
			$res=$field_value;
			break;

		case 'req' :
				$res=get_field_default($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength,$document_fields,$rubric_id);
			break;

		case 'name' :
			$res='FIELD_FLASH';
		break;
	
	}
	return ($res ? $res : $field_value);
}

//Документ из рубрики
function get_field_docfromrub($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	global $AVE_DB,$AVE_Template, $AVE_Core, $AVE_Document;
	$res=0;
	switch ($type)
	{
	case 'edit' :
	    $field  = '<a name="' . $field_id . '"></a>';
	    $sql="SELECT Id, document_parent, document_title from ". PREFIX ."_documents WHERE rubric_id='".$dropdown."' order by document_parent, document_title";
	    $res=$AVE_DB->Query($sql);
	    $field = "<select name=\"feld[" . $field_id . "]\">";
	    $array=array();
	    $items=array();
		while($row = $res->FetchRow()){
			$row->document_title=($array[$row->document_parent] >'' ? $array[$row->document_parent].' > '.$row->document_title: $row->document_title);
			$items[$row->document_title]="<option value=\"" . htmlspecialchars($row->Id, ENT_QUOTES) . "\"" . ((trim($field_value) == trim($row->Id)) ? " selected=\"selected\"" : "") . ">" . htmlspecialchars($row->document_title, ENT_QUOTES) . "</option>";
			$array[$row->Id]=$row->document_title;
		}
	    ksort($items);
	    $field.= implode(chr(10),$items);

	    $field .= "</select>";

	    $res=$field;
	break;

	case 'doc' :
		$sql="SELECT document_title from ". PREFIX ."_documents WHERE Id='".$field_value."' LIMIT 1";
		$field_value=$AVE_DB->Query($sql)->GetCell();
		$field_value = htmlspecialchars($field_value, ENT_QUOTES);
		$field_value = pretty_chars($field_value);
		$field_value = clean_php($field_value);
		$field_value = str_replace('"', '&quot;', $field_value);
		if (!$tpl_field_empty)
		{
			$field_param = explode('|', $field_value);
			$field_value = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_param[\\1]', $rubric_field_template);
		}
		$res=$field_value;
	break;

	case 'req' :
		$res=get_field_default($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength,$document_fields,$rubric_id);
	break;

	case 'name' :
		$res='FIELD_DOCFROMRUB';
	break;
	}
	return ($res ? $res : $field_value);
}


//Документ из рубрики(CHECKBOX)
function get_field_docfromrubcheck($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	global $AVE_DB,$AVE_Template, $AVE_Core, $AVE_Document;

	$res=0;
	switch ($type)
	{
		case 'edit' :
			$array=array();
			$items=array();
			$sql="SELECT Id, document_parent, document_title from ". PREFIX ."_documents WHERE rubric_id='".$dropdown."' order by document_parent, document_title";
			$field_value1=explode(',',$field_value);
			$res=$AVE_DB->Query($sql);
				//$field = "<input id=\"feld_" . $field_id . "\" name=\"feld[" . $field_id . "]\" value=\"".$field_value."\" type=\"hidden\">";
				$field = "<input id=\"feld_" . $field_id . "\" name=\"feld[" . $field_id . "]\" value=\"".$field_value."\" type=\"hidden\">";
				while($row = $res->FetchRow()){
					$row->document_title=($array[$row->document_parent] >'' ? $array[$row->document_parent].' > '.$row->document_title: $row->document_title);
					$items[$row->document_title]="<div class=\"fix\"><input class=\"float field_docfromrubcheck\" value='".$row->Id."' type='checkbox' ".((in_array($row->Id, $field_value1)==false) ? "" : "checked=checked").
					" onchange=\"
					$('#feld_" . $field_id ."').val('');
					var n = $('.field_docfromrubcheck:checked').each(
					function() {
					$('#feld_" . $field_id . "').val($('#feld_" . $field_id . "').val() > '' ?  $('#feld_" . $field_id . "').val()+',' + $(this).val() : $(this).val())
					}
					);
					\"><label>".htmlspecialchars($row->document_title, ENT_QUOTES)."</label></div>";

					$array[$row->Id]=$row->document_title;
				}

		ksort($items);
		$field.= implode(chr(10),$items);

		$res=$field;
		break;

		case 'doc' :
			$field_value1=explode(',',$field_value);
			if(is_array($field_value1)){
				$res=$AVE_DB->Query("SELECT Id,document_title FROM " . PREFIX . "_documents WHERE Id IN (".implode(', ',$field_value1).")");
				$result=Array();
				while ($mfa=$res->FetchArray())$result[$mfa['Id']]=$mfa['document_title'];
				$res='';
				if ($tpl_field_empty)$res.='<ul>';
				foreach($field_value1 as $k=>$v){
					$field_value = htmlspecialchars($v, ENT_QUOTES);
					$field_value = pretty_chars($field_value);
					$field_value = clean_php($field_value);
					if (!$tpl_field_empty)
					{
						$field_param = explode('|', $field_value);
						$field_value = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_param[\\1]', $rubric_field_template);
					}
					else
					{
					  $field_value="<li>".$result[$field_value]."</li>";
					}
					$res.=$field_value;
				}
				if ($tpl_field_empty)$res.='</ul>';
			}
			break;

			case 'req' :
			$res=get_field_default($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength,$document_fields,$rubric_id);

			break;
		case 'name' :
			$res='FIELD_DOCFROMRUB_CHECK';
		break;
	}	return ($res ? $res : $field_value);

}

//Документ из рубрики(CHECKBOX) Old edition
/*function get_field_docfromrubcheck($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	global $AVE_DB,$AVE_Template, $AVE_Core, $AVE_Document;

	$res=0;
	switch ($type)
	{
		case 'edit' :
				$sql="SELECT Id,document_title from ". PREFIX ."_documents WHERE rubric_id='".$dropdown."' order by document_title";
				$field_value=unserialize($field_value);
				$res=$AVE_DB->Query($sql);
				$field = "";
				while($row = $res->FetchRow()){
					$field.="<div class=\"fix\"><input name=\"feld[" . $field_id . "][]\" value=\"".$row->Id."\" type=\"checkbox\"  class=\"float\" ".((in_array($row->Id, $field_value)==false) ? "" : "checked=checked")."><label>".htmlspecialchars($row->document_title, ENT_QUOTES)."</label></div>";
				}
				$field .= "";

				$res=$field;
			break;

		case 'doc' :
			$field_value1=unserialize($field_value);
			if(is_array($field_value1)){
				$res=$AVE_DB->Query("SELECT Id,document_title FROM " . PREFIX . "_documents WHERE Id IN (".implode(', ',$field_value1).")");
				$result=Array();
				while ($mfa=$res->FetchArray())$result[$mfa['Id']]=$mfa['document_title'];
				$res='';
				if ($tpl_field_empty)$res.='<ul>';
				foreach($field_value1 as $k=>$v){
					$field_value = htmlspecialchars($v, ENT_QUOTES);
					$field_value = pretty_chars($field_value);
					$field_value = clean_php($field_value);
					if (!$tpl_field_empty)
					{
						$field_param = explode('|', $field_value);
						$field_value = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_param[\\1]', $rubric_field_template);
					}
					else
					{
					  $field_value="<li>".$result[$field_value]."</li>";
					}
					$res.=$field_value;
				}
				if ($tpl_field_empty)$res.='</ul>';
			}
			break;

			case 'req' :
			$res=get_field_default($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength,$document_fields,$rubric_id);

			break;
		case 'name' :
			$res='FIELD_DOCFROMRUB_CHECK';
		break;
	}	return ($res ? $res : $field_value);

}*/

//Пользовательские поля
if(file_exists(BASE_DIR . '/functions/user.fields.php'))
	require(BASE_DIR . '/functions/user.fields.php');

function get_field_type()
{
	global $AVE_Template;
	static $felder;
	if(is_array($felder))return $felder;
	$arr = get_defined_functions();

	$AVE_Template->config_load(BASE_DIR . '/admin/lang/' . $_SESSION['admin_language'] . '/fields.txt', 'fields');
	$felder_vars = $AVE_Template->get_config_vars();
	$felder=Array();
	foreach($arr['user'] as $k=>$v)
	{
		if(trim(substr($v,0,strlen('get_field_')))=='get_field_')
		{
			$d='';
			$name=@$v('','name','','',0,$d);
			$id=substr($v,strlen ('get_field_'));
			if($name!=false && is_string($name))$felder[]=array('id' => $id,'name' => ($felder_vars[$name] ? $felder_vars[$name] : $name));
		}	
	}
/*	$felder = array(
	);
*/
	return $felder;
}

?>