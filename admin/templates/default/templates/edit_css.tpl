<link rel="stylesheet" href="{$ABS_PATH}admin/codemirror/lib/codemirror.css">

<script src="{$ABS_PATH}admin/codemirror/lib/codemirror.js" type="text/javascript"></script>
<script src="{$ABS_PATH}admin/codemirror/mode/css/css.js"></script>

{literal}
    <style type="text/css">
      .activeline {background: #e8f2ff !important;}
    </style>
{/literal}

<div class="title"><h5>Редактор файлов</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		Пожалуйста, будьте предельно внимательны при редактировании файлов и помните, что неверно указанный код может испортить внешнее оформление сайта
    </div>
</div>

<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=templates&amp;cp={$sess}" title="">{#TEMPLATES_SUB_TITLE#}</a></li>
	        <li>Редактор файлов</li>
			<li><strong class="code">{$smarty.request.name_file|escape}</strong></li>
	    </ul>
	</div>
</div>

<form method="post" action="{$formaction}" class="mainForm">

<div class="widget first">
<div class="head"><h5 class="iFrames">{$smarty.request.name_file|escape}</h5></div>

<div class="rowElem" style="padding: 0;">
					<textarea id="code_text" name="code_text">{$code_text}</textarea>
	<div class="fix"></div>
</div>

<div class="rowElem">
<button class="basicBtn">{if $smarty.request.action=='new'}{#TEMPLATES_BUTTON_ADD#}{else}{#TEMPLATES_BUTTON_SAVE#}{/if}</button>
&nbsp;или&nbsp;
<input type="submit" class="basicBtn" name="next_edit" value="{#TEMPLATES_BUTTON_SAVE_NEXT#}" />
	<div class="fix"></div>
</div>

</div>
</form>
{literal}
    <script>
      var editor = CodeMirror.fromTextArea(document.getElementById("code_text"), {
        stylesheet: ["{$ABS_PATH}admin/codemirror/lib/codemirror.css"],
		height: "600px",
        lineNumbers: true,
		lineWrapping: true,
        matchBrackets: true,
        mode: "text/css",
        indentUnit: 4,
        indentWithTabs: true,
        enterMode: "keep",
        tabMode: "shift",
        onChange: function(){editor.save();},
		onCursorActivity: function() {
		  editor.setLineClass(hlLine, null, null);
		  hlLine = editor.setLineClass(editor.getCursor().line, null, "activeline");
		}
      });
	  var hlLine = editor.setLineClass(0, "activeline");
    </script>
{/literal}

