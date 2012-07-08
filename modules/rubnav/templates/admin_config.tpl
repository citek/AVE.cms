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
      .CodeMirror-scroll {height: 150px;}
    </style>
{/literal}

<div class="title"><h5>{#RUBNAV_MODULE#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#RUBNAV_MODULE_INFO#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li>{#RUBNAV_MODULE_SETUP#}</li>
	        <li><strong>{#RUBNAV_MODULE#}</strong></li>
	    </ul>
	</div>
</div>

<div class="widget first">
<div class="head"><h5 class="iFrames">{#RUBNAV_MODULE_SETUP#}</h5></div>

<form method="post" action="index.php?do=modules&action=modedit&mod=rubnav&moduleaction=1&cp={$sess}&sub=save" class="mainForm">
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
			<tr class="noborder">
				<td colspan="2"><strong>{#RubNavTeplNext#}</strong></td>
			</tr>
			<tr>
				<td><strong><a class="rightDir" title="{#RubNavLink#}" href="javascript:void(0);" onclick="textSelection('[tag:link]', '');">[tag:link]</a></strong></td>
				<td rowspan="3">
					<textarea style="width:400px; height:100px" name="rubnav_tmpl_next" id="rubnav_tmpl_next">{$rubnav_tmpl_next}</textarea>
				</td>
			</tr>
			<tr>
				<td><strong><a class="rightDir" title="{#RubNavLinkName#}" href="javascript:void(0);" onclick="textSelection('[tag:linkname]', '');">[tag:linkname]</a></strong></td>
			</tr>
			<tr>
				<td></td>
			</tr>
            <tr>
                <td>HTML tags</td>
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
			<tr>
				<td colspan="2"><strong>{#RubNavTeplPrev#}</strong></td>
			</tr>
			<tr>
				<td><strong><a class="rightDir" title="{#RubNavLink#}" href="javascript:void(0);" onclick="textSelection2('[tag:link]', '');">[tag:link]</a></strong></td>
				<td rowspan="3">
					<textarea style="width:400px; height:100px" name="rubnav_tmpl_prev" id="rubnav_tmpl_prev">{$rubnav_tmpl_prev}</textarea>
				</td>
			</tr>
			<tr>
				<td><strong><a class="rightDir" title="{#RubNavLinkName#}" href="javascript:void(0);" onclick="textSelection2('[tag:linkname]', '');">[tag:linkname]</a></strong></td>
			</tr>
			<tr>
				<td></td>
			</tr>
            <tr>
                <td>HTML tags</td>
                <td>
        |&nbsp;
        <a href="javascript:void(0);" onclick="textSelection2('<ol>', '</ol>');"><strong>OL</strong></a>&nbsp;|&nbsp;
        <a href="javascript:void(0);" onclick="textSelection2('<ul>', '</ul>');"><strong>UL</strong></a>&nbsp;|&nbsp;
        <a href="javascript:void(0);" onclick="textSelection2('<li>', '</li>');"><strong>LI</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection2('<p class=&quot;&quot;>', '</p>');"><strong>P</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection2('<strong>', '</strong>');"><strong>B</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection2('<em>', '</em>');"><strong>I</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection2('<h1>', '</h1>');"><strong>H1</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection2('<h2>', '</h2>');"><strong>H2</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection2('<h3>', '</h3>');"><strong>H3</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection2('<h4>', '</h4>');"><strong>H4</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection2('<h5>', '</h5>');"><strong>H5</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection2('<div class=&quot;&quot; id=&quot;&quot;>', '</div>');"><strong>DIV</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection2('<a href=&quot;&quot; title=&quot;&quot;>', '</a>');"><strong>A</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection2('<img src=&quot;&quot; alt=&quot;&quot; />', '');"><strong>IMG</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection2('<span>', '</span>');"><strong>SPAN</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection2('<pre>', '</pre>');"><strong>PRE</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection2('<br />', '');"><strong>BR</strong></a>&nbsp;|&nbsp;
		<a href="javascript:void(0);" onclick="textSelection2('\t', '');"><strong>TAB</strong></a>&nbsp;|
                 </td>
            </tr>
		<tr>
			<td class="third" colspan="2"><input type="submit" class="basicBtn" value="{#RUBNAV_MODULE_SAVE#}" /></td>
		</tr>
	</table>
</form>
</div>
{literal}
    <script language="javascript">
      var editor = CodeMirror.fromTextArea(document.getElementById("rubnav_tmpl_next"), {
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

      var editor2 = CodeMirror.fromTextArea(document.getElementById("rubnav_tmpl_prev"), {
        lineNumbers: true,
		lineWrapping: true,
        matchBrackets: true,
        mode: "application/x-httpd-php",
        indentUnit: 4,
        indentWithTabs: true,
        enterMode: "keep",
        tabMode: "shift",
        onChange: function(){editor2.save();},
		onCursorActivity: function() {
		  editor2.setLineClass(hlLine, null, null);
		  hlLine = editor2.setLineClass(editor2.getCursor().line, null, "activeline");
		}
      });
      function getSelectedRange2() {
        return { from: editor2.getCursor(true), to: editor2.getCursor(false) };
      }

      function textSelection2(startTag,endTag) {
        var range = getSelectedRange2();
        editor2.replaceRange(startTag + editor2.getRange(range.from, range.to) + endTag, range.from, range.to)
        editor2.setCursor(range.from.line, range.from.ch + startTag.length);
      }
      var hlLine = editor2.setLineClass(0, "activeline");
    </script>
{/literal}