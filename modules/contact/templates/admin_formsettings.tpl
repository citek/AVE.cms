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

<div class="widget first">
	<div class="head"><h5 class="iFrames">{#CONTACT_FORM_FIELDS#}</h5></div>

<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
	<tr class="noborder">
		<td width="1%"><a class="toprightDir icon_sprite ico_info" title="{#CONTACT_FORM_TITEL#}" href="#"></a></td>
		<td width="250">{#CONTACT_FORM_NAME2#}</td>
		<td><div class="pr12"><input name="contact_form_title" type="text" id="contact_form_title" placeholder="{#CONTACT_FORM_NAME#}" value="{$row->contact_form_title}" size="50" style="width: 500px;" /></div></td>
	</tr>

	<tr>
		<td width="1%"><a class="toprightDir icon_sprite ico_info" title="{#CONTACT_MAX_CHARS_EMAIL_TIP#}" href="#"></a></td>
		<td width="250">{#CONTACT_MAX_CHARS_EMAIL#}</td>
		<td><div class="pr12"><input name="contact_form_mail_max_chars" type="text" id="contact_form_mail_max_chars" value="{$row->contact_form_mail_max_chars|default:20000}" size="10" maxlength="10" style="width: 60px;" /></div></td>
	</tr>

	<tr>
		<td width="1%"><a class="toprightDir icon_sprite ico_info" title="{#CONTACT_DEFAULT_EMAIL#}" href="#"></a></td>
		<td width="250">{#CONTACT_DEFAULT_RECIVER#}</td>
		<td><div class="pr12"><input name="contact_form_reciever" type="text" id="contact_form_reciever" value="{$row->contact_form_reciever}" placeholder="{#CONTACT_DEFAULT_RECIVER#}" size="50" style="width: 300px;" /></div></td>
	</tr>

	<tr>
		<td width="1%"><a class="toprightDir icon_sprite ico_info" title="{#CONTACT_MULTI_LIST#}" href="#"></a></td>
		<td width="250">{#CONTACT_MULTI_LIST_FIELD#}</td>
		<td><div class="pr12"><input name="contact_form_reciever_multi" type="text" id="contact_form_reciever_multi" value="{$row->contact_form_reciever_multi}" placeholder="{#CONTACT_MULTI_LIST_FIELD#}" style="width: 300px;" /></div></td>
	</tr>

	<tr>
		<td width="1%"><a class="toprightDir icon_sprite ico_info" title="{#CONTACT_SCODE_INFO#}" href="#"></a></td>
		<td width="250">{#COUNACT_USE_SCODE_FIELD#}</td>
		<td><input type="radio" name="contact_form_antispam" value="1" {if $row->contact_form_antispam==1}checked{/if} /><label>{#CONTACT_YES#}</label>&nbsp;<input type="radio" name="contact_form_antispam" value="0" {if $row->contact_form_antispam!=1}checked{/if} /><label>{#CONTACT_NO#}</label></td>
	</tr>

	<tr>
		<td><a class="toprightDir icon_sprite ico_info" title="{#CONTACT_MAX_SIZE_INFO#}" href="#"></a></td>
		<td width="250">{#CONTACT_MAX_UPLOAD_FIELD#}</td>
		<td><div class="pr12"><input name="contact_form_max_upload" type="text" id="contact_form_max_upload" value="{$row->contact_form_max_upload|default:120}" size="10" maxlength="5" style="width: 60px;" /></div></td>
	</tr>

	<tr>
		<td><a class="toprightDir icon_sprite ico_info" title="{#CONTACT_SUBJECT_FIELD_INFO#}" href="#"></a></td>
		<td width="250">{#CONTACT_USE_SUBJECT_FIELD#}</td>
		<td><input type="radio" name="contact_form_subject_show" value="1" {if $row->contact_form_subject_show==1}checked{/if} /><label>{#CONTACT_YES#}</label>&nbsp;<input type="radio" name="contact_form_subject_show" value="0" {if $row->contact_form_subject_show!=1}checked{/if} /><label>{#CONTACT_NO#}</label></td>
	</tr>

	<tr>
		<td><a class="toprightDir icon_sprite ico_info" title="{#CONTACT_DEFAULT_SUBJ_INFO#}" href="#"></a></td>
		<td width="250">{#CONTACT_DEFAULT_SUBJECT#}</td>
		<td><div class="pr12"><input name="contact_form_subject_default" type="text" id="contact_form_subject_default" value="{$row->contact_form_subject_default|stripslashes|escape}" placeholder="{#CONTACT_DEFAULT_SUBJECT#}" style="width: 500px;" size="50" /></div></td>
	</tr>

	<tr>
		<td>&nbsp;</td>
		<td>{#CONTACT_USE_COPY_FIELD#}</td>
		<td><input type="radio" name="contact_form_send_copy" value="1" {if $row->contact_form_send_copy==1}checked{/if} /><label>{#CONTACT_YES#}</label>&nbsp;<input type="radio" name="contact_form_send_copy" value="0" {if $row->contact_form_send_copy!=1}checked{/if} /><label>{#CONTACT_NO#}</label></td>
	</tr>

	<tr>
		<td>&nbsp;</td>
		<td width="200" valign="top">{#CONTACT_PERMISSIONS_FIELD#}<br /><small>{#CONTACT_GROUPS_INFO#}</small></td>
		<td>
			<select style="width:200px" name="contact_form_allow_group[]" size="5" multiple="multiple">
				{foreach from=$groups item=group}
					<option value="{$group->user_group}" {if @in_array($group->user_group, $groups_form) || $smarty.request.moduleaction=="new"}selected="selected"{/if}>{$group->user_group_name|escape}</option>
				{/foreach}
			</select>
		</td>
	</tr>

	<tr>
		<td>&nbsp;</td>
		<td width="200" valign="top">{#CONTACT_TEXT_NO_PERMISSION#}</td>
		<td><textarea style="width:500px; height:100px" name="contact_form_message_noaccess" id="contact_form_message_noaccess">{$row->contact_form_message_noaccess|escape|stripslashes}</textarea></td>
	</tr>
</table>
</div>

<div class="widget first">
	<div class="head"><h5 class="iFrames">{#CONTACT_TEXT_SCRIPTS#}</h5></div>
	<div class="body">
		{#CONTACT_TEXT_SCRIPT_INFO#}
    </div>
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">

			<tr>
				<td><strong><a class="rightDir" title="{#CONTACT_TEMPLATES_MEDIAPATH#}" href="javascript:void(0);" onclick="textSelection('[tag:mediapath]','');">[tag:mediapath]</a></strong></td>
				<td rowspan="4">
					<textarea style="width:400px; height:100px" name="contact_form_message_scripts" id="contact_form_message_scripts">{$row->contact_form_message_scripts}</textarea>
				</td>
			</tr>
		<tr>
			<td>
				<strong><a class="rightDir" title="{#CONTACT_TEMPLATES_CSS#}" href="javascript:void(0);" onclick="textSelection('[tag:css:]','');">[tag:css:FFF:P]</a></strong>,&nbsp;&nbsp;
                <strong><a class="rightDir" title="{#CONTACT_TEMPLATES_JS#}" href="javascript:void(0);" onclick="textSelection('[tag:js:]','');">[tag:js:FFF:P]</a></strong>
			</td>
		</tr>

		<tr>
			<td>
				<strong><a class="rightDir" title="{#CONTACT_TEMPLATES_PATH#}" href="javascript:void(0);" onclick="textSelection('[tag:path]','');">[tag:path]</a></strong>
			</td>
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
					<a href="javascript:void(0);" onclick="textSelection('\t', '');"><strong>TAB</strong></a>
					&nbsp;|
                 </td>
            </tr>
	</table>
</div>

    <script language="Javascript" type="text/javascript">
{literal}
      var editor = CodeMirror.fromTextArea(document.getElementById("contact_form_message_scripts"), {
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
	  editor.setSize("100%", 200);
      function getSelectedRange() {
        return { from: editor.getCursor(true), to: editor.getCursor(false) };
      }

      function textSelection(startTag,endTag) {
        var range = getSelectedRange();
        editor.replaceRange(startTag + editor.getRange(range.from, range.to) + endTag, range.from, range.to)
        editor.setCursor(range.from.line, range.from.ch + startTag.length);
      }

	  var hlLine = editor.setLineClass(0, "activeline");
{/literal}
    </script>