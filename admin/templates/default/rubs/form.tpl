<link rel="stylesheet" href="{$ABS_PATH}admin/codemirror/lib/codemirror.css">

<script src="{$ABS_PATH}admin/codemirror/lib/codemirror.js" type="text/javascript"></script>
    <script src="{$ABS_PATH}admin/codemirror/mode/xml/xml.js"></script>
    <script src="{$ABS_PATH}admin/codemirror/mode/javascript/javascript.js"></script>
    <script src="{$ABS_PATH}admin/codemirror/mode/css/css.js"></script>
    <script src="{$ABS_PATH}admin/codemirror/mode/clike/clike.js"></script>
    <script src="{$ABS_PATH}admin/codemirror/mode/php/php.js"></script>

{literal}
    <style type="text/css">
      .activeline {background: #e8f2ff !important;}
      .CodeMirror-scroll {height: 400px;}
    </style>
{/literal}

{if $smarty.request.action=='new'}
	<div class="title"><h5>{#RUBRIK_TEMPLATE_NEW#}</h5></div>
{else}
	<div class="title"><h5>{#RUBRIK_TEMPLATE_EDIT#}</h5></div>
{/if}
<div class="widget" style="margin-top: 0px;"><div class="body">{#RUBRIK_TEMPLATE_TIP#}</div></div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=rubs&amp;cp={$sess}">{#RUBRIK_SUB_TITLE#}</a></li>
			{if $smarty.request.action=='new'}
	        <li>{#RUBRIK_TEMPLATE_NEW#}</li>
			<li><strong class="code">{$row->rubric_title|escape}</strong></li>
			{else}
	        <li>{#RUBRIK_TEMPLATE_EDIT#}</li>
			<li><strong class="code">{$row->rubric_title|escape}</strong></li>
			{/if}
	    </ul>
	</div>
</div>

<form name="f_tpl" id="f_tpl" method="post" action="{$formaction}" class="mainFrom">

{if $php_forbidden==1}
	<div class="infobox_error">{#RUBRIK_PHP_DENIDED#} </div>
{/if}

{if $errors}
	{foreach from=$errors item=e}
		{assign var=message value=$e}
		<ul>
			<li>{$message}</li>
		</ul>
	{/foreach}
{/if}

<div class="widget first">
<div class="head"><h5>{#RUBRIK_HTML#}</h5><div class="num"><a class="basicNum" href="index.php?do=rubs&action=edit&Id={$smarty.request.Id|escape}&cp={$sess}">{#RUBRIK_EDIT#}</a></div></div>

<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
<tbody>

	<tr class="noborder">
		<td width="200">
    <a class="rightDir" title="{#RUBRIK_DOCID_INFO#}" href="javascript:void(0);" onclick="textSelection('[tag:docid]', '');"><strong>[tag:docid]</strong></a>
		</td>
        <td rowspan="11"><textarea {$read_only} class="{if $php_forbidden==1}tpl_code_readonly{else}{/if}" style="width:100%; height:350px" name="rubric_template" id="rubric_template">{$row->rubric_template|default:$prefab|escape:html}</textarea></td>
	</tr>
	<tr>
		<td>
	<a class="rightDir" title="{#RUBRIK_DOCDATE_INFO#}" href="javascript:void(0);" onclick="textSelection('[tag:docdate]', '');"><strong>[tag:docdate]</strong></a>
		</td>
	</tr>
	<tr>
		<td>
	<a class="rightDir" title="{#RUBRIK_DOCTIME_INFO#}" href="javascript:void(0);" onclick="textSelection('[tag:doctime]', '');"><strong>[tag:doctime]</strong></a>
		</td>
	</tr>
	<tr>
		<td>
	<a class="rightDir" title="{#RUBRIK_DATE_INFO#}" href="javascript:void(0);" onclick="textSelection('[tag:date:', ']');"><strong>[tag:date:XXX]</strong></a>
		</td>
	</tr>
	<tr>
		<td>
	<a class="rightDir" title="{#RUBRIK_DOCAUTHOR_INFO#}" href="javascript:void(0);" onclick="textSelection('[tag:docauthor]', '');"><strong>[tag:docauthor]</strong></a>
		</td>
	</tr>
	<tr>
		<td>
	<a class="rightDir" title="{#RUBRIK_VIEWS_INFO#}" href="javascript:void(0);" onclick="textSelection('[tag:docviews]', '');"><strong>[tag:docviews]</strong></a>
		</td>
	</tr>
	<tr>
		<td>
	<a class="rightDir" title="{#RUBRIK_TITLE_INFO#}" href="javascript:void(0);" onclick="textSelection('[tag:title]', '');"><strong>[tag:title]</strong></a>
		</td>
	</tr>
	<tr>
		<td>
	<a class="rightDir" title="{#RUBRIK_PATH_INFO#}" href="javascript:void(0);" onclick="textSelection('[tag:path]', '');"><strong>[tag:path]</strong></a>
		</td>
	</tr>
	<tr>
		<td>
	<a class="rightDir" title="{#RUBRIK_MEDIAPATH_INFO#}" href="javascript:void(0);" onclick="textSelection('[tag:mediapath]', '');"><strong>[tag:mediapath]</strong></a>
		</td>
	</tr>
	<tr>
		<td>
	<a class="rightDir" title="{#RUBRIK_HIDE_INFO#}" href="javascript:void(0);" onclick="textSelection('[tag:hide:', ']\n\n[/tag:hide]');"><strong>[tag:hide:X,X][/tag:hide]</strong></a>
		</td>
	</tr>
	<tr>
		<td>
	<a class="rightDir" title="{#RUBRIK_BREADCRUMB#}" href="javascript:void(0);" onclick="textSelection('[tag:breadcrumb]', '');"><strong>[tag:breadcrumb]</strong></a>
		</td>
	</tr>
    <tr>
    	<td>HTML Tags</td>
    	<td>
        |&nbsp;
        <a href="javascript:void(0);" onclick="textSelection('<ol>', '</ol>');"><strong>OL</strong></a>&nbsp;|&nbsp;
        <a href="javascript:void(0);" onclick="textSelection('<ul>', '</ul>');"><strong>UL</strong></a>&nbsp;|&nbsp;
        <a href="javascript:void(0);" onclick="textSelection('<li>', '</li>');"><strong>LI</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection('<p class=&quot;&quot;>', '</p>');"><strong>P</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection('<strong>', '</strong>');"><strong>B</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection('<em>', '</em>');"><strong>I</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection('<h1>', '</h1>');"><strong>H1</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection('<h2>', '</h2>');"><strong>H2</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection('<h3>', '</h3>');"><strong>H3</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection('<h4>', '</h4>');"><strong>H4</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection('<h5>', '</h5>');"><strong>H5</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection('<div class=&quot;&quot; id=&quot;&quot;>', '</div>');"><strong>DIV</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection('<a href=&quot;&quot; title=&quot;&quot;>', '</a>');"><strong>A</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection('<img src=&quot;&quot; alt=&quot;&quot; />', '');"><strong>IMG</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection('<span>', '</span>');"><strong>SPAN</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection('<pre>', '</pre>');"><strong>PRE</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection('<br />', '');"><strong>BR</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection('\t', '');"><strong>TAB</strong></a>&nbsp;|
    	</td>
    </tr>
</tbody>
</table>


	<div class="fix"></div>
</div>

<div class="widget first">
<div class="head"><h5 class="iFrames">Поля рубрики</h5></div>

	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
		<thead>
			<tr>
				<td width="10%">{#RUBRIK_ID#}</td>
				<td width="20%">{#RUBRIK_FIELD_NAME#}</td>
				<td width="30%">{#RUBRIK_FIELD_TYPE#}</td>
			</tr>
		</thead>
		{foreach from=$tags item=tag}
			<tr>
				<td width="10%"><a class="rightDir" title="{#RUBRIK_INSERT_HELP#}" href="javascript:void(0);" onclick="textSelection('[tag:fld:{$tag->Id}]', '');"><strong>[tag:fld:{$tag->Id}]</strong></a></td>
				<td width="10%"><strong>{$tag->rubric_field_title}</strong></td>
				<td width="10%">
					{section name=feld loop=$feld_array}
						{if $tag->rubric_field_type == $feld_array[feld].id}{$feld_array[feld].name}{/if}
					{/section}
				</td>
			</tr>
		{/foreach}
	</table>

		<div class="rowElem">
			<input type="hidden" name="Id" value="{$smarty.request.Id|escape}" />
			<input class="basicBtn" type="submit" value="{#RUBRIK_BUTTON_TPL#}" />
			&nbsp;или&nbsp;
			<input type="submit" class="blackBtn" name="next_edit" value="{#RUBRIK_BUTTON_TPL_NEXT#}" />
		</div>


</div>
	<div class="fix"></div>

</form>
{literal}
    <script>
      var editor = CodeMirror.fromTextArea(document.getElementById("rubric_template"), {
        lineNumbers: true,
		lineWrapping: true,
        matchBrackets: true,
        mode: "application/x-httpd-php",
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

      function getSelectedRange() {
        return { from: editor.getCursor(true), to: editor.getCursor(false) };
      }

      function textSelection(startTag,endTag) {
        var range = getSelectedRange();
        editor.replaceRange(startTag + editor.getRange(range.from, range.to) + endTag, range.from, range.to)
        editor.setCursor(range.from.line, range.from.ch + startTag.length);
      }

	  var hlLine = editor.setLineClass(0, "activeline");
    </script>
{/literal}