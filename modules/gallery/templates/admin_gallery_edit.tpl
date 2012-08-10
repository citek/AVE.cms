<div class="title"><h5>{#ModSettingGal#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#ModSettingGalT#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><a href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=1&cp={$sess}">{#ModName#}</a></li>
	        <li>{#Overview#}</li>
	        <li><strong class="code">{$gallery.gallery_title|escape}</strong></li>
	    </ul>
	</div>
</div>



<form class="mainForm" method="post" name="gallery_form" id="gallery_form" action="index.php?do=modules&action=modedit&mod=gallery&moduleaction=editgallery&id={$smarty.request.id|escape}&cp={$sess}&sub=save">

<div class="widget first">
<div class="head">
<h5 class="iFrames">{#ModSettingGal#}</h5>
<div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=add&id={$smarty.request.id|escape}&cp={$sess}">{#AddnewImages#}</a></div>
<div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=showimages&id={$smarty.request.id|escape}&cp={$sess}&compile=1">{#ImageView#}</a></div>
</div>

	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
		<col width="250">
		<col>
        <thead>
		<tr>
			<td>{#GallerySetParam#}</td>
			<td>{#GallerySetVal#}</td>
		</tr>
        </thead>

		<tr>
			<td>{#GalleryTitle#}</td>
			<td>
				<input class="mousetrap" placeholder="{#GalleryTitle#}" name="gallery_title" type="text" id="gallery_title" value="{$gallery.gallery_title|escape}" size="40" style="width:500px" />
				<input name="gallery_title_old" type="hidden" value="{$gallery.gallery_title|escape}" />
			</td>
		</tr>

		<tr>
			<td>{#GalleryDesc#}</td>
			<td>
				<textarea class="mousetrap" placeholder="{#GalleryDesc#}" name="gallery_description" cols="40" rows="5" id="gallery_description" style="width:500px">{$gallery.gallery_description|escape}</textarea>
			</td>
		</tr>

		<tr>
			<td>{#GalleryFolder#}</td>
			<td>
				<input name="gallery_folder_old" type="hidden" value="{$gallery.gallery_folder|escape}" />
				<input class="mousetrap" placeholder="{#GalleryFolderP#}" name="gallery_folder" title="{#GalleryFolderDesc#}" type="text" id="dir__0" size="40" value="{$gallery.gallery_folder|escape}" style="width:500px" />&nbsp;
				<input type="button" class="basicBtn topDir" value="..." title="{#MAIN_OPEN_MEDIAPATH#}" onclick="browse_uploads('dir__0');" />
			</td>
		</tr>

		<tr>
			<td>{#Watermark#}</td>
			<td>
				<div><img id="preview__0" src="../{$gallery.gallery_watermark|escape}" alt="" border="0" /></div>
				<input class="mousetrap" placeholder="{#Watermark#}" name="gallery_watermark" type="text" id="image__0" value="{$gallery.gallery_watermark|escape}" size="40" style="width:500px" />&nbsp;
				<input type="button" class="basicBtn topDir" value="..." title="{#MAIN_OPEN_MEDIAPATH#}" onclick="browse_uploads('image__0');" />
			</td>
		</tr>

		<tr>
			<td>{#MaxWidth#}</td>
			<td>
				<input class="mousetrap" name="gallery_thumb_width" title="{#MaxWidthWarn#}" type="text" id="gallery_thumb_width" value="{$gallery.gallery_thumb_width}" size="5" maxlength="3" style="width: 35px;" />
				<input name="thumb_width_old" type="hidden" value="{$gallery.gallery_thumb_width}" />
			</td>
		</tr>
		<tr>
			<td>{#MaxHeight#}</td>
			<td>
				<input class="mousetrap" name="gallery_thumb_height" title="{#MaxHeightWarn#}" type="text" id="gallery_thumb_height" value="{$gallery.gallery_thumb_height}" size="5" maxlength="3" style="width: 35px;" />
				<input name="gallery_thumb_old" type="hidden" value="{$gallery.gallery_thumb_height}" />
			</td>
		</tr>
		<tr>
			<td>{#ThumbMethod#}</td>
			<td>
				<select name="gallery_thumb_method" style="width:250px">
					<option value="c" {if $gallery.gallery_thumb_method == 'c'}selected="selected" {/if}/>{#Crop#}</option>
					<option value="r" {if $gallery.gallery_thumb_method == 'r'}selected="selected" {/if}/>{#Resize#}</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>{#MaxImagesERow#}</td>
			<td>
				<input class="mousetrap" name="gallery_image_on_line" type="text" id="gallery_image_on_line" value="{$gallery.gallery_image_on_line}" size="5" maxlength="2" style="width: 35px;" />
			</td>
		</tr>

		<tr>
			<td class="first">{#MaxImagesPage#}</td>
			<td>
				<input class="mousetrap" name="gallery_image_on_page" type="text" id="gallery_image_on_page" value="{$gallery.gallery_image_on_page}" size="5" maxlength="4" style="width: 35px;" />
			</td>
		</tr>

		<tr>
			<td>{#OrderImage#}</td>
			<td>
				<select name="gallery_orderby" style="width:250px">
					<option value="dateasc" {if $gallery.gallery_orderby == 'dateasc'}selected="selected" {/if}/>{#OrderDateAsc#}</option>
					<option value="datedesc" {if $gallery.gallery_orderby == 'datedesc'}selected="selected" {/if}/>{#OrderDateDesc#}</option>
					<option value="titleasc" {if $gallery.gallery_orderby == 'titleasc'}selected="selected" {/if}/>{#OrderTitleAsc#}</option>
					<option value="titledesc" {if $gallery.gallery_orderby == 'titledesc'}selected="selected" {/if}/>{#OrderTitleDesc#}</option>
					<option value="position" {if $gallery.gallery_orderby == 'position'}selected="selected" {/if}/>{#OrderPosition#}</option>
				</select>
			</td>
		</tr>

		<tr>
			<td>{#GallerySeppLine#}</td>
			<td>
				<textarea class="mousetrap" placeholder="{#GallerySeppLine#}" name="gallery_sepp_line" cols="40" rows="5" id="gallery_sepp_line" style="width:500px">{$gallery.gallery_sepp_line|escape}</textarea>
			</td>
		</tr>

    		<tr>
    			<td colspan="2">
    				<input type="submit" class="basicBtn" value="{#ButtonSave#}" />
					<input type="submit" class="blackBtn SaveEdit" value="{#ButtonSaveEdit#}" />
    			</td>
    		</tr>
	</table>
</div>


<div class="widget first">
<div class="head"><h5 class="iFrames">{#GalleryScripts#}</h5></div>

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
      .CodeMirror-scroll {height: 300px;}
    </style>
{/literal}

<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
<col width="250">
<col>
    <thead>
    <tr>
        <td>{#GalleryScriptsTag#}</td>
        <td>{#GalleryScripts#}</td>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><strong><a class="rightDir" title="{#GalleryTagId#}" href="javascript:void(0);" onclick="textSelection('[tag:gal:id]', '');">[tag:gal:id]</a></strong></td>
        <td rowspan="9"><textarea name="gallery_script" cols="80" rows="10" id="gallery_script" style="width:100%">{$gallery.gallery_script|escape}</textarea></td>
    </tr>
    <tr>
        <td>
            <strong><a class="rightDir" title="{#GalleryTagFolder#}" href="javascript:void(0);" onclick="textSelection('[tag:gal:folder]', '');">[tag:gal:folder]</a></strong>
        </td>
    </tr>
    <tr>
        <td>
            <strong><a class="rightDir" title="{#GalleryTagTitl#}" href="javascript:void(0);" onclick="textSelection('[tag:gal:title]', '');">[tag:gal:title]</a></strong>
        </td>
    </tr>
    <tr>
        <td>
            <strong><a class="rightDir" title="{#GalleryTagDesc#}" href="javascript:void(0);" onclick="textSelection('[tag:gal:description]', '');">[tag:gal:description]</a></strong>
        </td>
    </tr>
    <tr>
        <td>
            <strong><a class="rightDir" title="{#GalleryTagContent#}" href="javascript:void(0);" onclick="textSelection('[tag:gal:content]', '');">[tag:gal:content]</a></strong>
        </td>
    </tr>
    <tr>
        <td>
            <strong><a class="rightDir" title="{#GalleryTagPages#}" href="javascript:void(0);" onclick="textSelection('[tag:gal:pages]', '');">[tag:gal:pages]</a></strong>
        </td>
    </tr>
    <tr>
        <td>
            <strong><a class="rightDir" title="{#GalleryTagPath#}" href="javascript:void(0);" onclick="textSelection('[tag:path]', '');">[tag:path]</a></strong>
        </td>
    </tr>
    <tr>
        <td>
            <strong><a class="rightDir" title="{#GalleryMediaPath#}" href="javascript:void(0);" onclick="textSelection('[tag:mediapath]', '');">[tag:mediapath]</a></strong>
        </td>
    </tr>
    <tr>
        <td></td>
    </tr>
            <tr>
                <td>{#GalleryTags#}</td>
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
<div class="head"><h5 class="iFrames">{#ImageTpl#}</h5></div>

<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
<col width="250">
<col>
    <thead>
    <tr>
        <td>{#ImageTplTag#}</td>
        <td>{#ImageTpl#}</td>
    </tr>
    </thead>
    <tbody>
			<tr>
				<td><strong><a class="rightDir" title="{#GalleryTagId#}" href="javascript:void(0);" onclick="textSelection2('[tag:gal:id]', '');">[tag:gal:id]</a></strong></td>
                <td rowspan="10"><textarea name="gallery_image_template" cols="80" rows="10" id="gallery_image_template" style="width:100%">{$gallery.gallery_image_template|escape}</textarea></td>
			</tr>

			<tr>
				<td><strong><a class="rightDir" title="{#GalleryTagFolder#}" href="javascript:void(0);" onclick="textSelection2('[tag:gal:folder]', '');">[tag:gal:folder]</a></strong></td>
			</tr>

            <tr>
                <td>
                    <strong><a class="rightDir" title="{#GalleryTagPath#}" href="javascript:void(0);" onclick="textSelection2('[tag:path]', '');">[tag:path]</a></strong>
                </td>
            </tr>

			<tr>
				<td><strong><a class="rightDir" title="{#GalleryTagImgId#}" href="javascript:void(0);" onclick="textSelection2('[tag:img:id]', '');">[tag:img:id]</a></strong></td>
			</tr>

			<tr>
				<td><strong><a class="rightDir" title="{#GalleryTagImgTitle#}" href="javascript:void(0);" onclick="textSelection2('[tag:img:title]', '');">[tag:img:title]</a></strong></td>
			</tr>

			<tr>
				<td><strong><a class="rightDir" title="{#GalleryTagImgDesc#}" href="javascript:void(0);" onclick="textSelection2('[tag:img:description]', '');">[tag:img:description]</a></strong></td>
			</tr>

			<tr>
				<td><strong><a class="rightDir" title="{#GalleryTagImgFilename#}" href="javascript:void(0);" onclick="textSelection2('[tag:img:original]', '');">[tag:img:original]</a></strong></td>
			</tr>

			<tr>
				<td><strong><a class="rightDir" title="{#GalleryTagImgThumb#}" href="javascript:void(0);" onclick="textSelection2('[tag:img:thumbnail]', '');">[tag:img:thumbnail]</a></strong></td>
			</tr>
			<tr>
				<td><strong><a class="rightDir" title="{#GalleryTagImgSize#}" href="javascript:void(0);" onclick="textSelection2('[tag:img:size]', '');">[tag:img:size]</a></strong></td>
			</tr>
			<tr>
				<td></td>
			</tr>
            <tr>
                <td>{#GalleryTags#}</td>
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
    			<td colspan="2">
    				<input type="submit" class="basicBtn" value="{#ButtonSave#}" />&nbsp;или&nbsp;
    				<input type="submit" class="blackBtn SaveEdit" value="{#ButtonSaveEdit#}" />
    			</td>
    		</tr>
    </tbody>
	</table>


    <script language="javascript">
    var sett_options = {ldelim}
		url: 'index.php?do=modules&action=modedit&mod=gallery&moduleaction=editgallery&id={$smarty.request.id|escape}&cp={$sess}&sub=save',
		beforeSubmit: Request,
        success: Response
	{rdelim}

	function Request(){ldelim}
		$.alerts._overlay('show');
	{rdelim}

	function Response(){ldelim}
		$.alerts._overlay('hide');
		$.jGrowl('{#SavedOk#}');
	{rdelim}

	$(document).ready(function(){ldelim}

		Mousetrap.bind(['ctrl+s', 'meta+s'], function(e) {ldelim}
		    if (e.preventDefault) {ldelim}
		        e.preventDefault();
		    {rdelim} else {ldelim}
		        // internet explorer
		        e.returnValue = false;
		    {rdelim}
		    $("#gallery_form").ajaxSubmit(sett_options);
			return false;
		{rdelim});

	    $(".SaveEdit").click(function(e){ldelim}
		    if (e.preventDefault) {ldelim}
		        e.preventDefault();
		    {rdelim} else {ldelim}
		        // internet explorer
		        e.returnValue = false;
		    {rdelim}
		    $("#gallery_form").ajaxSubmit(sett_options);
			return false;
		{rdelim});

	{rdelim});

{literal}    
      var editor = CodeMirror.fromTextArea(document.getElementById("gallery_script"), {
      	extraKeys: {"Ctrl-S": function(cm){$("#gallery_form").ajaxSubmit(sett_options);}},
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
	  var hlLine = editor.setLineClass(0, "activeline");

      function getSelectedRange() {
        return { from: editor.getCursor(true), to: editor.getCursor(false) };
      }

      function textSelection(startTag,endTag) {
        var range = getSelectedRange();
        editor.replaceRange(startTag + editor.getRange(range.from, range.to) + endTag, range.from, range.to)
        editor.setCursor(range.from.line, range.from.ch + startTag.length);
      }

      var editor2 = CodeMirror.fromTextArea(document.getElementById("gallery_image_template"), {
      	extraKeys: {"Ctrl-S": function(cm){$("#gallery_form").ajaxSubmit(sett_options);}},
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

</div>

</form>


<script language="javascript">
    {if $empty_gallery_title == 1}
        alert("{#EmptyGalleryTitle#}");
    {/if}

    {if $folder_exist == 1}
        alert("{#FolderExists#}");
    {/if}
</script>