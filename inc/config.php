<?php
/**
 * AVE.cms
 *
 * @package AVE.cms
 * @filesource
 */
define('APP_NAME', 'AVE.cms');
define('APP_VERSION', '3.0RC1');
define('APP_INFO', '&copy; 2007-2012 <a target="_blank" href="http://www.ave-cms.ru/">Ave-Cms.Ru</a>');

$GLOBALS['CMS_CONFIG']['IDS_LIB'] = array('DESCR' =>'Использовать систему обнаружения вторжений IDS для параноиков<br/>(существенно снижает производительность)','default'=>false,'TYPE'=>'bool','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['REWRITE_MODE'] = array('DESCR' =>'Использовать ЧПУ Адреса вида index.php будут преобразованы в /home/','default'=>true,'TYPE'=>'bool','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['TRANSLIT_URL'] = array('DESCR' =>'Использовать транслит в ЧПУ адреса вида /страница/ поменяються на /page/','default'=>true,'TYPE'=>'bool','VARIANT'=>''); 
$GLOBALS['CMS_CONFIG']['URL_SUFF'] = array('DESCR' =>'Cуффикс ЧПУ','default'=>'','TYPE'=>'string','VARIANT'=>'');

$themes = array();
foreach (glob(dirname(dirname(__FILE__))."/templates/*") as $filename) {
	if(is_dir($filename))$themes[]=basename($filename);
}
$GLOBALS['CMS_CONFIG']['DEFAULT_THEME_FOLDER'] = array('DESCR' =>'Тема публичной части','default'=>$themes[0],'TYPE'=>'dropdown','VARIANT'=>$themes);

$themes = array();
foreach (glob(dirname(dirname(__FILE__))."/admin/templates/*") as $filename) {
	if(is_dir($filename))$themes[]=basename($filename);
}
$GLOBALS['CMS_CONFIG']['DEFAULT_ADMIN_THEME_FOLDER'] = array('DESCR' =>'Тема панели администратора','default'=>$themes[0],'TYPE'=>'dropdown','VARIANT'=>$themes);

$GLOBALS['CMS_CONFIG']['DEFAULT_THEME_FOLDER_COLOR'] = array('DESCR' =>'Цвет панели администратора','default'=>'blue','TYPE'=>'dropdown','VARIANT'=>array('blue','darkwood','darkwood_blue','green','mini','orange','purple','red','wood'));
$GLOBALS['CMS_CONFIG']['ADMIN_FAVICON'] = array('DESCR' =>'Использовать для админки альтернативную admin.favicon.ico вместо favicon.ico','default'=>true,'TYPE'=>'bool','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['ADMIN_CAPTCHA'] = array('DESCR' =>'Использовать капчу при входе в админку','default'=>false,'TYPE'=>'bool','VARIANT'=>'');

$GLOBALS['CMS_CONFIG']['ATTACH_DIR'] = array('DESCR' =>'Директория для хранения вложений','default'=>'cache/attachments','TYPE'=>'string','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['UPLOAD_DIR'] = array('DESCR' =>'Директория для хранения файлов','default'=>'uploads','TYPE'=>'string','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['UPLOAD_SHOP_DIR'] = array('DESCR' =>'Директория для хранения миниатюр Магазина','default'=>'uploads/shop','TYPE'=>'string','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['UPLOAD_GALLERY_DIR'] = array('DESCR' =>'Директория для хранения миниатюр Галерей','default'=>'uploads/gallery','TYPE'=>'string','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['THUMBNAIL_DIR'] = array('DESCR' =>'Директория для хранения миниатюр изображений','default'=>'thumbnail','TYPE'=>'string','VARIANT'=>'');

$GLOBALS['CMS_CONFIG']['DEFAULT_LANGUAGE'] = array('DESCR' =>'Язык по умолчанию','default'=>'ru','TYPE'=>'dropdown','VARIANT'=>array('ru','en','ua'));
$GLOBALS['CMS_CONFIG']['SESSION_SAVE_HANDLER'] = array('DESCR' =>'Хранить сессии в БД','default'=>true,'TYPE'=>'bool','VARIANT'=>''); 
$GLOBALS['CMS_CONFIG']['SESSION_LIFETIME'] = array('DESCR' =>'Время жизни сессии (Значение по умолчанию 24 минуты)','default'=>60*60*24,'TYPE'=>'integer','VARIANT'=>''); 
$GLOBALS['CMS_CONFIG']['COOKIE_LIFETIME'] = array('DESCR' =>'Время жизни cookie автологина (60*60*24*14 - 2 недели)','default'=>60*60*24*14,'TYPE'=>'integer','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['PROFILING'] = array('DESCR' =>'Вывод статистики и списка выполненых запросов','default'=>false,'TYPE'=>'bool','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['SEND_SQL_ERROR'] = array('DESCR' =>'Отправка писем с ошибками MySQL','default'=>false,'TYPE'=>'bool','VARIANT'=>''); 
$GLOBALS['CMS_CONFIG']['SMARTY_COMPILE_CHECK'] = array('DESCR' =>'Контролировать изменения tpl файлов После настройки сайта установить - false','default'=>true,'TYPE'=>'bool','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['SMARTY_DEBUGGING'] = array('DESCR' =>'Консоль отладки Smarty','default'=>false,'TYPE'=>'bool','VARIANT'=>''); 
$GLOBALS['CMS_CONFIG']['SMARTY_USE_SUB_DIRS'] = array('DESCR' =>'Создание папок для кэширования Установите это в false если ваше окружение PHP не разрешает создание директорий от имени Smarty. Поддиректории более эффективны, так что используйте их, если можете.','default'=>true,'TYPE'=>'bool','VARIANT'=>''); 
$GLOBALS['CMS_CONFIG']['CACHE_DOC_TPL'] = array('DESCR' =>'Кэширование скомпилированных шаблонов документов','default'=>true,'TYPE'=>'bool','VARIANT'=>''); 
$GLOBALS['CMS_CONFIG']['CACHE_LIFETIME'] = array('DESCR' =>'Время жизни кэша (300 = 5 минут)','default'=>0,'TYPE'=>'integer','VARIANT'=>''); 
$GLOBALS['CMS_CONFIG']['YANDEX_MAP_API_KEY'] = array('DESCR' =>'Yandex MAP API REY','default'=>'','TYPE'=>'string','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['GOOGLE_MAP_API_KEY'] = array('DESCR' =>'Google MAP API REY','default'=>'','TYPE'=>'string','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['Memcached_Server'] = array('DESCR' =>'Адрес Memcached сервера','default'=>'','TYPE'=>'string','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['Memcached_Port'] = array('DESCR' =>'Порт Memcached сервера','default'=>'','TYPE'=>'string','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['SVN_ACTIVE'] = array('DESCR' =>'Проверка обновлений','default'=>false,'TYPE'=>'bool','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['SVN_URL'] = array('DESCR' =>'Адрес SVN репозитария (включая папку, изменения которой Вас интересуют, например, trunk)','default'=>'http://ave-cms.googlecode.com/svn/trunk/','TYPE'=>'string','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['SVN_LINK'] = array('DESCR' =>'Ссылка на репозитарий для просмотра информации о ревизии (%num% - номер ревизии)','default'=>'http://code.google.com/p/ave-cms/source/detail?r=%num%','TYPE'=>'string','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['SVN_LOGIN'] = array('DESCR' =>'Логин для SVN репозитария','default'=>'','TYPE'=>'string','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['SVN_PASSWORD'] = array('DESCR' =>'Пароль для SVN репозитария','default'=>'','TYPE'=>'string','VARIANT'=>'');
$GLOBALS['CMS_CONFIG']['DB_EXPORT_TPL'] = array('DESCR' =>'Шаблон имени файла экспорта бд (%SERVER%,%DATE%,%TIME%)','default'=>'%SERVER%_DB_BackUP_%DATE%_%TIME%','TYPE'=>'string','VARIANT'=>'');

@include(dirname(dirname(__FILE__)).'/inc/config.inc.php');
foreach($GLOBALS['CMS_CONFIG'] as $k=>$v)
{
	if(!defined($k))
		define($k,$v['default']);
}
?>