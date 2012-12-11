Модуль управления настройками редактора LiveEditor 1.01
Запуск: 1. В настройках системы выберите InnovaEditor 
2. Установите модуль управления LiveEditor
3. После установки модуля, настройки редактора будут доступны. Есть видео чего и как....
Первая версия содержит только настройку тулбаров. 99% возможных плюшек -в следующих обновлениях модуля.
С файлом лицензии игры опасны, попытки изменения файла могут привести редактор в неработоспособное состояние.


Если используется данный редактор, не забывайте в шаблоне подключить:
<head>
<link href="[tag:path]admin/liveeditor/styles/default.css" rel="stylesheet" type="text/css" />	
<script src="[tag:path]admin/liveeditor/scripts/common/jquery-1.7.min.js" type="text/javascript"></script>	
<script src="http://ajax.googleapis.com/ajax/libs/webfont/1.0.30/webfont.js" type="text/javascript"></script>
<script src="[tag:path]admin/liveeditor/scripts/common/webfont.js" type="text/javascript"></script>


Если будуте использовать миниатюры изображений (редактором разумеется создавать) 
так же подключите в head шаблона:
  <script src="scripts/common/fancybox13/jquery.easing-1.3.pack.js" type="text/javascript"></script>
        <script src="scripts/common/fancybox13/jquery.mousewheel-3.0.2.pack.js" type="text/javascript"></script>
        <script src="scripts/common/fancybox13/jquery.fancybox-1.3.1.pack.js" type="text/javascript"></script>
        <link href="scripts/common/fancybox13/jquery.fancybox-1.3.1.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript">
            $(document).ready(function () {
                $('a[rel=lightbox]').fancybox();
            });
        </script>

</head>

Удачи!
Repellent.



