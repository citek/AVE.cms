<?php

//Код
function get_field_code($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	global $AVE_Template, $AVE_Core, $AVE_Document;
	$res=0;
	switch ($type)
	{
		case 'edit' :
				$field  = "<a name=\"" . $field_id . "\"></a>";
				$field .= "<textarea id=\"feld_" . $field_id . "\" style=\"width:" . $AVE_Document->_textarea_width . "; height:" . $AVE_Document->_textarea_height . "\"  name=\"feld[" . $field_id . "]\">" . $field_value . "</textarea>";
				$res=$field;
			break;

		case 'doc' :
			$res=$field_value;
			break;
			case 'req' :
				$res=get_field_default($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength,$document_fields,$rubric_id);
			break;

		case 'name' :
			$res='FIELD_CODE';
		break;
	}
	return ($res ? $res : $field_value);
}

//Загрузить файл
function get_field_download($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	global $AVE_Template, $AVE_Core, $AVE_Document,$img_pixel;
	$res=0;
	switch ($type)
	{
		case 'edit' :
				$field  = "<div style=\"\" id=\"feld_" . $field_id . "\"><a name=\"" . $field_id . "\"></a>";
				$field .= "<div style=\"display:none\" id=\"feld_" . $field_id . "\">";
				$field .= "<img style=\"display:none\" id=\"_img_feld__" . $field_id . "\" src=\"" . (!empty($field_value) ? htmlspecialchars($field_value, ENT_QUOTES) : $img_pixel) . "\" alt=\"\" border=\"0\" /></div>";
				$field .= "<div style=\"display:none\" id=\"span_feld__" . $field_id . "\"></div>";
				$field .= "<input type=\"text\" style=\"width:" . $AVE_Document->_field_width . "\" name=\"feld[" . $field_id . "]\" value=\"" . htmlspecialchars($field_value, ENT_QUOTES) . "\" id=\"img_feld__" . $field_id . "\" />&nbsp;";
				$field .= "<input value=\"" . $AVE_Template->get_config_vars('MAIN_OPEN_MEDIAPATH') . "\" class=\"basicBtn\" type=\"button\" onclick=\"cp_imagepop('img_feld__" . $field_id . "', '', '', '0');\" />";
				$field .= '<a class="basicBtn topDir" title="'.$AVE_Template->get_config_vars('DOC_FILE_TYPE_HELP').'" href="#">?</a>';
				$field .= '</div>';
				$res=$field;
			break;

		case 'doc' :
			$field_value = clean_php($field_value);
			$field_param = explode('|', $field_value);
			if ($tpl_field_empty)
			{
				$field_value = (!empty($field_param[1]) ? $field_param[1] . '<br />' : '')
					. '<form method="get" target="_blank" action="' . ABS_PATH . $field_param[0]
					. '"><input class="basicBtn" type="submit" value="Скачать" /></form>';
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
			$res='FIELD_DOWNLOAD';
		break;

	}
	return ($res ? $res : $field_value);
}

//GPS координаты
function get_field_gps($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	$res=0;
	switch ($type)
	{
		case 'edit' :
			$res=get_field_default($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength).'<input type="button" class="basicBtn" value="+" onclick="SetPlaceMarkCoords();return false;"/>&nbsp;<input type="button" class="basicBtn" value="X" onclick="ErasePlaceMarkCoords();return false;"/>';
			$code='<script src="http://api-maps.yandex.ru/1.1/index.xml?key='.YANDEX_MAP_API_KEY.'" type="text/javascript"></script>
    <script type="text/javascript">
        var map, geoResult, placemark;

        // Создание обработчика для события window.onLoad
        YMaps.jQuery(function () {
            // Создание экземпляра карты и его привязка к созданному контейнеру
            map = new YMaps.Map(YMaps.jQuery("#Map")[0]);

            // Установка для карты ее центра и масштаба
			if("<#--FIELD_VALUE--#>">""){var coord=new YMaps.GeoPoint(<#--FIELD_VALUE--#>);}else{var coord=new YMaps.GeoPoint(49.38,53.52);}
            map.setCenter(coord, 13);

            // Добавление элементов управления
            map.addControl(new YMaps.TypeControl());
			placemark = new YMaps.Placemark(coord, {draggable: true});
            placemark.name = "Результат";
            if("<#--FIELD_VALUE--#>">"")map.addOverlay(placemark);

            // При щелчке на карте показывается балун со значениями координат указателя мыши и масштаба
            YMaps.Events.observe(placemark, placemark.Events.DragEnd, function (obj) {
                // Задаем контент для балуна
				document.getElementById("feld_<#--FIELD_ID--#>").value=placemark.getGeoPoint();
                obj.update();
            });
        });

        // Функция для отображения результата геокодирования
        // Параметр value - адрес объекта для поиска
        function showAddress (value) {
            // Удаление предыдущего результата поиска
            map.removeOverlay(geoResult);

            // Запуск процесса геокодирования
            var geocoder = new YMaps.Geocoder(value, {results: 1, boundedBy: map.getBounds()});

            // Создание обработчика для успешного завершения геокодирования
            YMaps.Events.observe(geocoder, geocoder.Events.Load, function () {
                // Если объект был найден, то добавляем его на карту
                // и центрируем карту по области обзора найденного объекта
                if (this.length()) {
                    geoResult = this.get(0);
                    //map.addOverlay(geoResult);
                    map.setBounds(geoResult.getBounds());
                }else {
                    alert("Ничего не найдено")
                }
            });

            // Процесс геокодирования завершен неудачно
            YMaps.Events.observe(geocoder, geocoder.Events.Fault, function (geocoder, error) {
                alert("Произошла ошибка: " + error);
            })
        }
		function SetPlaceMarkCoords(){
			map.addOverlay(placemark);
			placemark.setGeoPoint(map.getCenter());
			document.getElementById("feld_<#--FIELD_ID--#>").value=placemark.getGeoPoint();
		}
		function ErasePlaceMarkCoords(){
			map.removeOverlay(placemark);
			document.getElementById("feld_<#--FIELD_ID--#>").value=\'\';
		}
    </script>';
			$code='<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script type="text/javascript">
var geocoder = new google.maps.Geocoder();
var map=null;
var marker=null;

function updateMarkerPosition(latLng) {
  marker.setTitle([latLng].join(", "));
  document.getElementById("feld_<#--FIELD_ID--#>").value = [
    latLng.lat(),
    latLng.lng()
  ].join(", ");
}

function initialize() {
  if("<#--FIELD_VALUE--#>">""){
	var latlng = new google.maps.LatLng(<#--FIELD_VALUE--#>);
  }
  else
  {
    var latlng = new google.maps.LatLng(15.870, 100.992);
  }
  map = new google.maps.Map(document.getElementById("Map"), {
    zoom: 5,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });
  if("<#--FIELD_VALUE--#>">""){
		SetPlaceMarkCoords();
	}
}

  function showAddress(address) {
    geocoder.geocode({
      "address": address,
      "partialmatch": true}, geocodeResult);
  }

  function geocodeResult(results, status) {
    if (status == "OK" && results.length > 0) {
      map.fitBounds(results[0].geometry.viewport);
    }
  }

function parseLatLng(value) {
  value.replace("/\s//g");
  var coords = value.split(",");
  var lat = parseFloat(coords[0]);
  var lng = parseFloat(coords[1]);
  if (isNaN(lat) || isNaN(lng)) {
    return null;
  } else {
    return new google.maps.LatLng(lat, lng);
  }
}


function ErasePlaceMarkCoords(){
   marker.setMap(null);
}
function SetPlaceMarkCoords(){
  if(marker==null){marker = new google.maps.Marker({
    position: map.getCenter(),
    title: "",
    map: map,
    draggable: true
  });}else {
	marker.setMap(map);
	marker.setPosition(map.getCenter());
	}

  // Update current position info.
  updateMarkerPosition(map.getCenter());

  // Add dragging event listeners.

  google.maps.event.addListener(marker, "drag", function() {
    updateMarkerPosition(marker.getPosition());
  });

  google.maps.event.addListener(marker, "dragend", function() {
    updateMarkerPosition(marker.getPosition());
  });
}
// Onload handler to fire off the app.
google.maps.event.addDomListener(window, "load", initialize);



</script>
';
            $code.='<p>
			<input type="text" id="address" style="width:525px;" value="" />
            <input class="basicBtn" type="button" value="Искать" onclick="showAddress(document.getElementById(\'address\').value);return false;"/>
            <div id="Map" style="width:600px;height:400px"></div>';
			$res.=str_ireplace('<#--FIELD_ID--#>',$field_id,str_ireplace('<#--FIELD_VALUE--#>',$field_value,$code));
			break;
		case 'doc' :
			$res=get_field_default($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength);
			break;

		case 'req' :
				$res=get_field_default($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength,$document_fields,$rubric_id);
			break;
		case 'name' :
			$res='FIELD_GPS';
		break;
	}
	return ($res ? $res : $field_value);
}

//Каскад изображений
function get_field_bild_multi($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	global $AVE_Template, $AVE_Core, $AVE_Document;
	$res=0;

	switch ($_SESSION['use_editor']) {
		case '0': // стандартный редактор
		$img_js =
			"'<img height=\"120px\" id=\"_img_feld__'+field_id+'_'+_id+'\" src=\"'+img_path+'\" alt=\"'+alt+'\" border=\"0\" />' +
			'<div style=\"display:none\" id=\"span_feld__'+field_id+ '_'+_id+'\">&nbsp;</div>' + (field_value ? '<br />' : '') +
			'<input type=\"text\" style=\"width:50%;\" name=\"feld[' + field_id + '][]\" value=\"' + field_value + '\" id=\"img_feld__' + field_id +'_' + _id+'\" />&nbsp;'+
			'<input value=\"".$AVE_Template->get_config_vars('MAIN_OPEN_MEDIAPATH')."\" class=\"basicBtn\" type=\"button\" onclick=\"'+\"cp_imagepop('img_feld__\" + field_id + '_'+_id+\"', '', '', '0');\"+'\" />&nbsp;'";
		break;

		case '1': // Elrte и Elfinder
		$img_js =
			"'<div id=\"images_feld_'+field_id+'_'+_id+'\">' +
				'<img height=\"120px\" id=\"_img_feld__'+field_id+'_'+_id+'\" src=\"'+img_path+'\" alt=\"'+alt+'\" border=\"0\" />' +
			'</div>' +
			'<input class=\"docm finder\" type=\"text\" style=\"width:70%;\" name=\"feld[' + field_id + '][]\" value=\"' + field_value + '\" id=\"img_feld__' + field_id +'_' + _id+'\" />&nbsp;'+
			'<span class=\"basicBtn\" onClick=\"dialog_images($(this))\" rel=\"'+ field_id + '_'+_id+'\">".$AVE_Template->get_config_vars('MAIN_OPEN_MEDIAPATH')."</span>'";
		break;
    }
	$theme_folder =  '/admin/templates/'.DEFAULT_ADMIN_THEME_FOLDER;
	$jsCode = <<<BLOCK
		<script language="javascript" type="text/javascript">
			function dialog_images (elem_this){
				var id = elem_this.attr("rel");
				$('<div/>').dialogelfinder({
					url : ave_path+'admin/redactor/elfinder/php/connector.php',
					lang : 'ru',
					width : 1100,
					height: 600,
					modal : true,
					title : 'Файловый менеджер',
					getFileCallback : function(files, fm) {
						$("#img_feld__"+id).val(files['url'].slice(1));
						$("#images_feld_"+id).html('<img height="120px" src='+files['url']+'>');
					},
					commandsOptions : {
						getfile : {
							oncomplete : 'destroy',
							folders : false
						}
					}
				})
			};
			function field_image_multi_add(field_id, field_value, img_path, alt){
				var
					_id = Math.round(Math.random()*1000);
					img_id = '__img_feld__' + field_id + '_' + _id;

				var html={$img_js}+
					'<input type="button" class="blackBtn" value="&#8593;" onclick="field_image_multi_move(' + field_id + ', ' + _id + ', \'up\')" />&nbsp;'+
					'<input type="button" class="blackBtn" value="&#8595;" onclick="field_image_multi_move(' + field_id + ', ' + _id + ', \'down\')" />&nbsp;'+
					'<input type="button" class="blackBtn" value="&#215;" onclick="if(window.confirm(\'Удалить?\'))field_image_multi_delete(' + field_id + ', ' + _id + ')" />'

					element=document.createElement("div");
					element.id=img_id;
					element.innerHTML=html;
					document.getElementById("feld_"+field_id).appendChild(element);
			}

			function field_image_multi_delete(field_id, id){
				img_id = '__img_feld__' + field_id + '_' + id;
				element=document.getElementById(img_id);
				element.parentNode.removeChild(element);
			}

			function field_image_multi_move(field_id, id, direction){ // direction: {up, down};
				img_id = '__img_feld__' + field_id + '_' + id;
				element=document.getElementById(img_id);

				if(direction=='up')
					neighbour=element.previousSibling;
				else
					neighbour=element.nextSibling;

				if(neighbour){
					if(direction=='up')
						neighbour.parentNode.insertBefore(element.parentNode.removeChild(element), neighbour);
					else{
						if( neighbour.nextSibling )
							neighbour.parentNode.insertBefore(element.parentNode.removeChild(element), neighbour.nextSibling);
						else
							neighbour.parentNode.appendChild(element.parentNode.removeChild(element));
					}
				}
			}

			function field_image_multi_opimport(field_id){
				$("#on"+field_id).hide();
				var html='<br>Указывать нужно папку (Формат: uploads/images/samepath/)<br><input type="text" style="width:{$AVE_Document->_field_width}" value="uploads/images/" id="img_importfeld__' + field_id +'" />&nbsp;'+
					'<input type="button" class="basicBtn topDir" value="..." onclick="browse_uploads(&quot;img_importfeld__' + field_id +'&quot;);" />&nbsp;'+
					'<input type="button" class="basicBtn" onclick="field_image_multi_import(' + field_id + ');" value="Импорт" />';
					element=document.createElement("div");
					element.id=img_id;
					element.innerHTML=html;
					document.getElementById("feld_"+field_id).appendChild(element);
			}

			function field_image_multi_import(field_id){

				var path_import = $("#img_importfeld__"+field_id).val();
				var html = '';

				$.ajax({
					url: ave_path+'admin/index.php?do=docs&action=image_import',
					data: {"path": path_import},
					dataType: "json",
					success: function(dat) {

						for (var p = 0, max = dat.respons.length; p < max; p++) {
							var field_value = path_import + dat.respons[p];
							var img_path = '../index.php?thumb=' + field_value;
							field_image_multi_add(field_id, field_value, img_path, '');
						}
					},
					error: function(data) {
						alert("Ошибка импорта");
					},
				});
			}
		</script>
BLOCK;

	static $jsCodeWritten; // статическая переменная, показывающая, были ли уже выведен JS для редактирования поля multi image

	switch ($type)
	{
		case 'edit' :
			$field='';
			// выводим JS-код, только один раз
			if($jsCodeWritten!==1){
				$field.=$jsCode;
				$jsCodeWritten=1;
			}

			$field.="
				<div id=\"feld_{$field_id}\">
				</div>
				<input type='button' class='basicBtn' onclick=\"field_image_multi_add({$field_id},'','','');\" value='Добавить' /> <input type='button' class='basicBtn' id='on".$field_id."' onclick=\"field_image_multi_opimport({$field_id});\" value='Импорт' />
				<script language=\"javascript\" type=\"text/javascript\">";
				$massa=unserialize($field_value);
				if($massa!=false){
					foreach($massa as $k=>$v){
						$massiv = explode('|', $v);
						if($v){
							$field.="
							field_image_multi_add(
								'{$field_id}',
								'" . htmlspecialchars($v, ENT_QUOTES) . "',
								'" . (!empty($v) ? '../index.php?thumb=' . htmlspecialchars($massiv[0], ENT_QUOTES) : $img_pixel) . "',
								'" . (isset($massiv[1]) ? htmlspecialchars($massiv[1], ENT_QUOTES) : '') . "');";
						}
					}
				}
				else{
					$field.="field_image_multi_add({$field_id},'','','');";
				}
				$field.="</script>";
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
							$v = '<li><img src="'.ABS_PATH.$field_param[0].'" alt="'.$field_param[1].'"/></li>';
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
			$rubric_field_template_request = $document_fields[$rubric_id]['rubric_field_template_request'];
			if($massa!=false)
				foreach($massa as $k=>$v)
				{
					$v = clean_php($v);
					$field_param = explode('|', $v);
					if($v){
						if (!$rubric_field_template_request)
						{
							$v = '<li><img src="'.ABS_PATH.$field_param[0].'" alt="'.$field_param[1].'"/></li>';
						}
						else
						{
							$v = preg_replace('/\[tag:parametr:(\d+)\]/ie', '@$field_param[\\1]', $rubric_field_template_request);
						}
					}
					$res.=$v;
				}
			break;

		case 'name' :
			$res='FIELD_BILD_MULTI';
		break;
	}
	return $res;
}

//Видео в формате MOV
function get_field_video_mov($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	global $AVE_Template, $AVE_Core, $AVE_Document,$img_pixel;
	$res=0;
	switch ($type)
	{
		case 'edit' :
				$field  = "<div style=\"\" id=\"feld_" . $field_id . "\"><a name=\"" . $field_id . "\"></a>";
				$field .= "<div style=\"display:none\" id=\"feld_" . $field_id . "\"><img style=\"display:none\" id=\"_img_feld__" . $field_id . "\" src=\"". (!empty($field_value) ? htmlspecialchars($field_value, ENT_QUOTES) : $img_pixel) . "\" alt=\"\" border=\"0\" /></div>";
				$field .= "<div style=\"display:none\" id=\"span_feld__" . $field_id . "\"></div>";
				$field .= "<input type=\"text\" style=\"width:" . $AVE_Document->_field_width . "\" name=\"feld[" . $field_id . "]\" value=\"" . htmlspecialchars($field_value, ENT_QUOTES) . "\" id=\"img_feld__" . $field_id . "\" />&nbsp;";
				$field .= "<input value=\"" . $AVE_Template->get_config_vars('MAIN_OPEN_MEDIAPATH') . "\" class=\"basicBtn\" type=\"button\" onclick=\"cp_imagepop('img_feld__" . $field_id . "', '', '', '0');\" />";
				$field .= '<a class="basicBtn" title="'.$AVE_Template->get_config_vars('DOC_VIDEO_TYPE_HELP').'" href="#">?</a>';
				$field .= '</div>';
				$res=$field;
			break;

		case 'doc' :
			$field_value = clean_php($field_value);
			$field_param = explode('|', $field_value);
			$field_param[1] = (!empty($field_param[1]) && is_numeric($field_param[1])) ? $field_param[1] : 470;
			$field_param[2] = (!empty($field_param[2]) && is_numeric($field_param[2])) ? $field_param[2] : 320;
			if ($tpl_field_empty)
			{
				$field_value = '<object classid="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B" width="' . $field_param[1]
						. '" height="' . $field_param[2] . '" codebase="http://www.apple.com/qtactivex/qtplugin.cab">'
					. '<param name="src" value="' . ABS_PATH . $field_param[0] . '">'
					. '<param name="autoplay" value="false">'
					. '<param name="controller" value="true">'
					. '<param name="target" value="myself">'
					. '<param name="type" value="video/quicktime">'
					. '<embed target="myself" src="' . ABS_PATH . $field_param[0] . '" width="' . $field_param[1] . '" height="' . $field_param[2]
						. '" autoplay="false" controller="true" type="video/quicktime" pluginspage="http://www.apple.com/quicktime/download/">'
					. '</embed>'
					. '</object>';
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
			$res='FIELD_VIDEO_MOV';
		break;
	}
	return ($res ? $res : $field_value);
}

//Видео в формате AVI
function get_field_video_avi($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	$res=0;
	switch ($type)
	{
		case 'edit' :
			$res=get_field_video_mov($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength);
			break;
		case 'doc' :
			$field_value = clean_php($field_value);
			$field_param = explode('|', $field_value);
			$field_param[1] = (!empty($field_param[1]) && is_numeric($field_param[1])) ? $field_param[1] : 470;
			$field_param[2] = (!empty($field_param[2]) && is_numeric($field_param[2])) ? $field_param[2] : 320;
			if ($tpl_field_empty)
			{
				$field_value = '<object id="MediaPlayer" classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6" '
					. 'codebase="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=6,4,7,1112" height="'
						. $field_param[2] . '" width="' . $field_param[1] . '">'
					. '<param name="animationatStart" value="false">'
					. '<param name="autostart" value="false">'
					. '<param name="url" value="' . ABS_PATH . $field_param[0] . '">'
					. '<param name="volume" value="-200">'
					. '<embed type="application/x-mplayer2" pluginspage="http://www.microsoft.com/Windows/MediaPlayer/" name="MediaPlayer" src="'
						. ABS_PATH . $field_param[0] . '" autostart="0" displaysize="0" showcontrols="1" showdisplay="0" showtracker="1" showstatusbar="1" height="'
						. $field_param[2] . '" width="' . $field_param[1] . '">'
					. '</object>';
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
			$res='FIELD_VIDEO_AVI';
		break;

	}
	return ($res ? $res : $field_value);
}

//Видео в формате WMF
function get_field_video_wmf($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	$res=0;
	switch ($type)
	{
		case 'edit' :
			$res=get_field_video_mov($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength);
			break;
		case 'doc' :
			$res=get_field_video_avi($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength);
			break;

		case 'req' :
				$res=get_field_default($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength,$document_fields,$rubric_id);
			break;
		case 'name' :
			$res='FIELD_VIDEO_WMF';
		break;
	}

	return ($res ? $res : $field_value);
}

//Видео в формате WMV
function get_field_video_wmv($field_value,$type,$field_id='',$rubric_field_template='',$tpl_field_empty=0,&$maxlength = '',$document_fields=0,$rubric_id=0,$dropdown=''){
	$res=0;
	switch ($type)
	{
		case 'edit' :
			$res=get_field_video_mov($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength);
			break;
		case 'doc' :
			$res=get_field_video_avi($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength);
			break;

		case 'req' :
				$res=get_field_default($field_value,$type,$field_id,$rubric_field_template,$tpl_field_empty,$maxlength,$document_fields,$rubric_id);
			break;
		case 'name' :
			$res='FIELD_VIDEO_WMV';
		break;
	}
	return ($res ? $res : $field_value);
}
?>