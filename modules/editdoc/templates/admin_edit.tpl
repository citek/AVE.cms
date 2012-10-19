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
    </style>
{/literal}

<div class="title"><h5>{#EDITDOC_INSERT_H#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#EDITDOC_INSERT#}
    </div>
</div>

<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><a href="index.php?do=modules&action=modedit&mod=editdoc&moduleaction=1&cp={$sess}">{#EDITDOC_LIST_LINK#}</a></li>
	        <li><strong class="code">{if $smarty.request.id != ''}{$editdoc_name|escape}{else}{$smarty.request.editdoc_name}{/if}</strong></li>
	    </ul>
	</div>
</div>

<form id="save_editdoc" action="index.php?do=modules&action=modedit&mod=editdoc&moduleaction=saveedit&cp={$sess}" method="post" class="mainForm">

{if $smarty.request.id != ''}

<div class="widget first">
<div class="head"><h5 class="iFrames">{if $smarty.request.id != ''}{#EDITDOC_EDIT_H#}{else}{#EDITDOC_INSERT_H#}{/if}</h5></div>

	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">

			<tr>
				<td>{#EDITDOC_NAME#}</td>
				<td><div class="pr12"><input name="editdoc_name" class="mousetrap" type="text" value="{if $smarty.request.id != ''}{$editdoc_name|escape}{else}{$smarty.request.editdoc_name}{/if}" size="80" /></div></td>
			</tr>
			<tr>
				<td>{#EDITDOC_RUBRICS#}</td>
				<td>
					<select name="editdoc_rub" {if $smarty.request.id != ''}disabled="disabled"{/if}>
					{foreach from=$rubs item=rub}
						{if $rub->Id==$editdoc_rub}
							<option value="{$rub->Id}" selected>{$rub->rubric_title}</option>
						{else}
							<option value="{$rub->Id}">{$rub->rubric_title}</option>
						{/if}
					{/foreach}
					</select>
					</td>
			</tr>
	</table>

</div>


	<div class="widget first">
	<div class="head"><h5 class="iFrames">{#EDITDOC_HEADER_FORM#}</h5></div>

		<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
				<thead>
				<tr>
					<td>{#EDITDOC_HEADER_PHP#}</td>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td>
					<textarea class="mousetrap" {$read_only} name="editdoc_template" id="editdoc_template" wrap="off" style="width:100%; height:340px">{$editdoc_template|default:$prefab|escape:html}</textarea>
					</td>
				</tr>
				<tr>
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

	</div>


<div class="widget first">
<div class="head"><h5 class="iFrames">{#EDITDOC_HEADER_HEAD#}</h5></div>

	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
		<col width="20%" />
		<col width="40%" />
		<col width="40%" />
		<thead>
		<tr>
			<td>&nbsp;</td>
			<td>{#EDITDOC_HEADER_CORE#}</td>
			<td>{#EDITDOC_HEADER_INSTR#}</td>
		</tr>
		</thead>

		<tbody>
						{foreach from=$data.header key=k item=v}
						<tr>
							<td>
								<strong>$data['header']['{$k}']</strong>
							</td>
							<td>
								<div class="pr12"><textarea class="mousetrap" name="document[header][{$k}]" id="document_header_{$k}" cols="60" rows="7">{$v[0]|default:$prefab|escape:html}</textarea></div>
							</td>
							<td>
								<div class="pr12"><textarea class="mousetrap" name="document[template][{$k}]" id="document_template_{$k}" cols="60" rows="7">{$v[1]|default:$prefab|escape:html}</textarea></div>
							</td>
						</tr>
						{/foreach}
		</tbody>
	</table>

</div>



<div class="widget first">
<div class="head"><h5 class="iFrames">{#EDITDOC_HEADER_BODY#}</h5></div>
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
		<col width="20%" />
		<col width="40%" />
		<col width="40%" />
		<thead>
		<tr>
			<td>&nbsp;</td>
			<td>{#EDITDOC_HEADER_CORE#}</td>
			<td>{#EDITDOC_HEADER_INSTR#}</td>
		</tr>
		</thead>
		<tbody>
			{foreach from=$data.body key=k item=v}
			<tr>
				<td>
					<strong>{$v[0]}</strong><br>
					$data['body']['{$k}']
				</td>
				<td>
					<div class="pr12"><textarea class="mousetrap" name="document[body][{$k}]" id="document_body_{$k}" cols="70" rows="7">{$v[1]|default:$prefab|escape:html}</textarea></div>
				</td>
				<td>
					<div class="pr12"><textarea class="mousetrap" name="document[template][{$k}]" id="document_template_{$k}" cols="70" rows="7">{$v[2]|default:$prefab|escape:html}</textarea></div>
				</td>
			</tr>
			{/foreach}
		</tbody>
	</table>
</div>

	<div class="widget first">
	<div class="head"><h5 class="iFrames">{#EDITDOC_HEADER_AFTER#}</h5></div>
		<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
			<thead>
				<tr>
					<td>{#EDITDOC_HEADER_PHP#}</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<textarea {$read_only} name="editdoc_afteredit" id="editdoc_afteredit" wrap="off" style="width:100%; height:340px">{$editdoc_afteredit|default:$prefab|escape:html}</textarea>
					</td>
				</tr>
				<tr>
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
					<td colspan="3">
							<input type="hidden" name="id" value="{$id}">
							<input name="submit" type="submit" class="basicBtn" value="{#EDITDOC_SAVEDIT#}" />
							&nbsp;или&nbsp;
							<input type="submit" class="blackBtn SaveEdit" name="next_edit" value="{#EDITDOC_SAVEDIT_NEXT#}" />
					</td>
				</tr>
			</tbody>
		</table>
	</div>

<script language="javascript">
    var sett_options = {ldelim}
		url: 'index.php?do=modules&action=modedit&mod=editdoc&moduleaction=saveedit&cp={$sess}',
		beforeSubmit: Request,
        success: Response
	{rdelim}

	function Request(){ldelim}
		$.alerts._overlay('show');
	{rdelim}

	function Response(){ldelim}
		$.alerts._overlay('hide');
		$.jGrowl('{#EDITDOC_SAVED#}', {ldelim}theme: 'accept'{rdelim});
	{rdelim}

	$(document).ready(function(){ldelim}

		Mousetrap.bind(['ctrl+s', 'meta+s'], function(e) {ldelim}
		    if (e.preventDefault) {ldelim}
		        e.preventDefault();
		    {rdelim} else {ldelim}
		        // internet explorer
		        e.returnValue = false;
		    {rdelim}
		    $("#save_editdoc").ajaxSubmit(sett_options);
			return false;
		{rdelim});

	    $(".SaveEdit").click(function(e){ldelim}
		    if (e.preventDefault) {ldelim}
		        e.preventDefault();
		    {rdelim} else {ldelim}
		        // internet explorer
		        e.returnValue = false;
		    {rdelim}
		    $("#save_editdoc").ajaxSubmit(sett_options);
			return false;
		{rdelim});

	{rdelim});

{literal}
      var editor = CodeMirror.fromTextArea(document.getElementById("editdoc_template"), {
      	extraKeys: {"Ctrl-S": function(cm){$("#save_editdoc").ajaxSubmit(sett_options);}},
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

      var editor2 = CodeMirror.fromTextArea(document.getElementById("editdoc_afteredit"), {
      	extraKeys: {"Ctrl-S": function(cm){$("#save_editdoc").ajaxSubmit(sett_options);}},
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
	{/literal}

</script>


	{else}

	<div class="widget first">
	<div class="head"><h5 class="iFrames">{if $smarty.request.id != ''}{#EDITDOC_EDIT_H#}{else}{#EDITDOC_INSERT_H#}{/if}</h5></div>

		<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">

				<tr>
					<td>{#EDITDOC_NAME#}</td>
					<td><div class="pr12"><input name="editdoc_name" class="mousetrap" type="text" value="{if $smarty.request.id != ''}{$editdoc_name|escape}{else}{$smarty.request.editdoc_name}{/if}" size="80" /></div></td>
				</tr>
				<tr>
					<td>{#EDITDOC_RUBRICS#}</td>
					<td>
						<select name="editdoc_rub" {if $smarty.request.id != ''}disabled="disabled"{/if}>
						{foreach from=$rubs item=rub}
							{if $rub->Id==$editdoc_rub}
								<option value="{$rub->Id}" selected>{$rub->rubric_title}</option>
							{else}
								<option value="{$rub->Id}">{$rub->rubric_title}</option>
							{/if}
						{/foreach}
						</select>
						</td>
				</tr>
				<tr>
					<td colspan="2">
						<input name="submit" type="submit" class="basicBtn" value="{#EDITDOC_SAVE#}" />
					</td>
				</tr>
		</table>

	</div>

	{/if}

</form>