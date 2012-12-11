    <link rel="stylesheet" type="text/css" href="{$ABS_PATH}modules/liveeditor/css/mod_liveeditor.css" media="screen" />
    <script src="{$ABS_PATH}admin/liveeditor/scripts/language/ru-RU/editor_lang.js"></script>
    <script src="{$ABS_PATH}admin/liveeditor/scripts/innovaeditor.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/webfont/1.0.30/webfont.js" type="text/javascript"></script>
    <script src="{$ABS_PATH}admin/liveeditor/scripts/common/webfont.js" type="text/javascript"></script>
    <script src="{$ABS_PATH}admin/liveeditor/scripts/common/nlslightbox/nlslightbox.js" type="text/javascript"></script>
    <script src="{$ABS_PATH}admin/liveeditor/scripts/common/nlslightbox/nlsanimation.js" type="text/javascript"></script>
    <script src="{$ABS_PATH}admin/liveeditor/scripts/common/nlslightbox/dialog.js" type="text/javascript"></script>
    <script src="{$ABS_PATH}admin/templates/default/js/jquery.tipsy.js" type="text/javascript"></script>
    <script src="{$ABS_PATH}modules/liveeditor/js/jquery.dragsort-0.5.1.min.js" type="text/javascript"></script>
    <link href="{$ABS_PATH}admin/liveeditor/scripts/common/nlslightbox/nlslightbox.css" rel="stylesheet" type="text/css" />


{literal}
    <style type="text/css">
      .activeline {background: #e8f2ff !important;}
	  .istoolbar_container tbody, tr, th, td {vertical-align:top;}/*Фикс, влияет reset.css - клик в тулбаре на кнопку стилей - они улет. вниз*/
	  .box_container {margin-top:0px !important;} /*Модальные окна на этой странице отображаются ниже/выше центра этим стилем*/
    </style>
{/literal}

<div class="title"><h5>{#LIVEEDITOR_EDIT_H#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#LIVEEDITOR_INSERT#}
    </div>
</div>

<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><a href="index.php?do=modules&action=modedit&mod=liveeditor&moduleaction=1&cp={$sess}" title="">{#LIVEEDITOR_LIST_LINK#}</a></li>
	        <li>{if $smarty.request.id != ''}{#LIVEEDITOR_EDIT_H#}{else}{#LIVEEDITOR_INSERT_H#}{/if}</li>
	        <li><strong class="code">{if $smarty.request.id != ''}{$liveeditor_name|escape}{else}{$smarty.request.liveeditor_name}{/if}</strong></li>
	    </ul>
	</div>
</div>
 <script type="text/javascript">
	$(document).ready(function()
		{literal}{
		$('.collapsible').collapsible({
			defaultOpen: 'opened',
			cssOpen: 'inactive',
			cssClose: 'normal',
			cookieName: 'collaps_liv',
			cookieOptions: {
		        expires: 7,
				domain: ''
	    	},
			speed: 200
		}); 
		
		$('div#mod_le_vid .istoolbar_container').prepend("<span class='topDir mod_le_video' title=\"{/literal}{#LIVEEDITOR_DEMO_DESC#}{literal}\" style='float:right;margin-right:90px; margin-top:20px;' onClick=\"modalDialog('/modules/liveeditor/lesson/lesson.html', 896,524)\">&nbsp;&nbsp;{/literal}{#LIVEEDITOR_DEMO#}{literal}</span>");
		
		$('.istoolbar_container').find('img').addClass('topDir');
		//===== Tooltip =====//
	$('.topleftDir').tipsy({fade: false, gravity: 'se'});
	$('.toprightDir').tipsy({fade: false, gravity: 'sw'});
	$('.leftDir').tipsy({fade: false, gravity: 'e'});
	$('.rightDir').tipsy({fade: false, gravity: 'w'});
	$('.topDir').tipsy({fade: false, gravity: 's'});
	$('.botDir').tipsy({fade: false, gravity: 'n'});
	});
		{/literal}
</script>

<div class="widget first">
<div class="head collapsible" id="opened"><h5 class="iFrames"><span class="topDir mod_le_col" title="{#LIVEEDITOR_OPEN#}">{#LIVEEDITOR_CAP#}</span></h5></div>
<div id="mod_le_vid" style="display: block;">

<textarea class="mousetrap" id="txtContent" rows="4" cols="30" style="width: 100%;"></textarea>
{literal}
<script type="text/javascript">
var oEdit778 = new InnovaEditor("oEdit778");
oEdit778.css = "/admin/liveeditor/styles/default.css";
oEdit778.fileBrowser = "/admin/liveeditor/assetmanager/asset.php";
oEdit778.width="100%";
oEdit778.height="200";
oEdit778.groups = [
        ["group1", "", ["FontName", "FontSize", "Superscript", "ForeColor", "BackColor", "FontDialog", "Quote", "CompleteTextDialog", "BRK", "Bold", "Italic", "Underline", "Strikethrough", "TextDialog", "Styles", "RemoveFormat", "CustomObject"]],
        ["group2", "", ["JustifyLeft", "JustifyCenter", "JustifyRight", "Paragraph", "BRK", "Bullets", "Numbering", "Indent", "Outdent"]],
        ["group3", "", ["Table", "TableDialog", "Emoticons", "FlashDialog", "BRK", "LinkDialog", "ImageDialog", "YoutubeDialog"]],
        ["group4", "", ["InternalLink", "CharsDialog", "Line", "BRK", "CustomTag", "MyCustomButton"]],
        ["group5", "", ["SearchDialog", "SourceDialog", "ClearAll", "BRK", "Undo", "Redo", "FullScreen"]]
        ];
oEdit778.REPLACE("txtContent");
</script>
{/literal}
</div>
</div>
<form id="liveeditor" action="index.php?do=modules&action=modedit&mod=liveeditor&moduleaction=saveedit&cp={$sess}" method="post" class="mainForm">

<div class="widget first">
 <div class="head"><h5 class="iFrames">{if $smarty.request.id != ''}{#LIVEEDITOR_EDIT_H#}{else}{#LIVEEDITOR_INSERT_H#}{/if}&nbsp;|&nbsp;{#LIVEEDITOR_STATUS#} :&nbsp;<span class="mod_le_active"></span><span style="margin-left:10px; cursor:pointer;" onclick="modalDialog('/modules/liveeditor/lesson/lesson_mod.html', 930,638)">|&nbsp;{#LIVEEDITOR_LES_VID_M#}</span></h5></div>
  <div class="rowElem noborder">
	<label>{#LIVEEDITOR_NAME_A#}</label>
	<div class="formRight"><input name="liveeditor_name" class="mousetrap" type="text" value="{if $smarty.request.id != ''}{$liveeditor_name|escape}{else}{$smarty.request.liveeditor_name}{/if}" size="80" /></div>
	<div class="fix"></div>
    </div>
 </div>
 
<script type="text/javascript">
$(document).ready(function()
		{literal}{
		$a = 1;
		$b = {/literal}{if $smarty.request.id != ''}{$liveeditor_status|escape}{else}{$smarty.request.liveeditor_status}{/if}{literal};
		$c = {/literal}{if $smarty.request.id != ''}{$liveeditor_fields|escape}{else}{$smarty.request.liveeditor_fields}{/if}{literal};
		if($a == $b)     {
	$('.mod_le_active').prepend("{/literal}{#LIVEEDITOR_ACTIVATED#}{literal}&nbsp;")
} 
	    else             {
	$('.mod_le_active').prepend("{/literal}{#LIVEEDITOR_DEACTIVATED#}{literal}&nbsp;")
}		
	    if($a == $c)     {
	$('.mod_le_active').append("{/literal}{#LIVEEDITOR_M_FIELD#}{literal}")
} 
        else if($a < $c) {
	$('.mod_le_active').append("{/literal}{#LIVEEDITOR_SM_FIELD#}{literal}")
}
	    else             {
	$('.mod_le_active').append("{/literal}{#LIVEEDITOR_EM_FIELD#}{literal}")
}				
				
});
		{/literal}
</script>
 
<div class="widget first">
 <div class="head"><h5 class="iFrames">{if $smarty.request.id != ''}{#LIVEEDITOR_TOOLBAR#}{else}{#LIVEEDITOR_TOOLBAR_ADD#}{/if}</h5></div>
 
 <div title ="{#LIVEEDITOR_RESET_VAR#}" class="topleftDir mod_li_reset">{#LIVEEDITOR_RESET#}</div>
 <div title="{#LIVEEDITOR_CHEC_HELP#}" class="topDir title_btn_mod_li_real_toolbar">{#LIVEEDITOR_CHEC_TITLE#}</div>
 <div class="btn_mod_li_real_toolbar"><input type="checkbox" id="btn_mod_li_real" /></div>
 
  <div class="rowElem noborder" style="background:transparent">
 
 <div class="mod_li_dv_2">
    <ul class="mod_le_drag_ul" id="list2">
    {if $smarty.request.id == 1}
	{php}
	require(BASE_DIR . "/modules/liveeditor/f_config/li_available_mf.tpl");
	{/php}
    {else}
    {php}
	require(BASE_DIR . "/modules/liveeditor/f_config/li_available_smf.tpl");
	{/php}
    {/if}      
	</ul>
  </div>
  
<div class="mod_li_dv_1">
    <ul class="mod_le_drag_ul" id="list1">
    {if $smarty.request.id == 1}
	{php}
	require(BASE_DIR . "/modules/liveeditor/f_config/li_new_mf.tpl");
	{/php}
    {else}
    {php}
	require(BASE_DIR . "/modules/liveeditor/f_config/li_new_smf.tpl");
	{/php}
    {/if}	
	</ul>
</div>
   
	<div class="formRight"><input name="liveeditor_available_toolbar" id ="liveeditor_available_toolbar{$smarty.request.id}" type="hidden" value="" /></div>
    <div class="formRight"><input name="liveeditor_new_toolbar" id="liveeditor_new_toolbar{$smarty.request.id}" type="hidden" value="" /></div>
    <div class="formRight"><input name="liveeditor_real_toolbar" id="liveeditor_real_toolbar{$smarty.request.id}" type="hidden"  value=""  /></div>
    <div class="fix"></div>
  </div>
</div>



<script type="text/javascript">
var mod_li_id1 = {$id};
{literal}

         $(".mod_li_reset").click(function(){
			 
			if (mod_li_id1 == 1){
                $("#list2").load("{/literal}{$ABS_PATH}{literal}modules/liveeditor/f_config/reset/li_res_available_mf.tpl");
				$("#list1").load("{/literal}{$ABS_PATH}{literal}modules/liveeditor/f_config/reset/li_res_new_mf.tpl");
		   }
		   else {
			    $("#list2").load("{/literal}{$ABS_PATH}{literal}modules/liveeditor/f_config/reset/li_res_available_smf.tpl");
				$("#list1").load("{/literal}{$ABS_PATH}{literal}modules/liveeditor/f_config/reset/li_res_new_smf.tpl");
		   }
		});	
		   
		   
var name_input_available_toolbar_first_open = document.getElementById({/literal}'liveeditor_available_toolbar{$smarty.request.id}{literal}')
    name_input_available_toolbar_first_open.value = document.getElementById('list2').innerHTML;
var name_input_new_toolbar_first_open = document.getElementById({/literal}'liveeditor_new_toolbar{$smarty.request.id}{literal}')
    name_input_new_toolbar_first_open.value = document.getElementById('list1').innerHTML;

	var datas = $("#list1 li").map(function() { return $(this).children().attr('class'); }).get();
	var tmp_toolbar_real01 = 'var oEdit\' . $field_id . \' = new InnovaEditor("oEdit\' . $field_id . \'");';
			var tmp_toolbar_real11 = 'oEdit\' . $field_id . \'.css = "/admin/liveeditor/styles/default.css"; ';
			var tmp_toolbar_real21 = 'oEdit\' . $field_id . \'.fileBrowser = "/admin/liveeditor/assetmanager/asset.php";';
		    if(mod_li_id1 == 1){
				var tmp_toolbar_real_start1 = '\<?php\r\n $large = \'';
				var tmp_toolbar_real31 = 'oEdit\' . $field_id . \'.width = "\' . $AVE_Document->_textarea_width . \'";';
		        var tmp_toolbar_real41 = 'oEdit\' . $field_id . \'.height = "\' . $AVE_Document->_textarea_height . \'";';
				var tmp_toolbar_real71 = 'oEdit\' . $field_id . \'.REPLACE("editor[\' . $field_id . \']");';
				var tmp_toolbar_real_finish1 = '\';\r\n $innova = array (1 =>"$large");\r\n ?>';
			}
			else {
				var tmp_toolbar_real_start1 = '<?php\r\n $small = \'';
			    var tmp_toolbar_real31 = 'oEdit\' . $field_id . \'.width = "\' . $AVE_Document->_textarea_width_small . \'";';
		        var tmp_toolbar_real41 = 'oEdit\' . $field_id . \'.height = "\' . $AVE_Document->_textarea_height_small . \'";';
				var tmp_toolbar_real71 = 'oEdit\' . $field_id . \'.REPLACE("small-editor[\' . $field_id . \']");';
				var tmp_toolbar_real_finish1 = '\';\r\n $innova = array (2 =>"$small");\r\n ?>';
			}
		    var tmp_toolbar_real51 = 'oEdit\' . $field_id . \'.groups = [[\"group1\", \"\", [\"'
			var tmp_toolbar_real61 = '\"]]];';
			
			var pos_form_real_first_open = tmp_toolbar_real_start1 + '\r\n<sc' + 'ript type="text/javascript">\r\n' + tmp_toolbar_real01 + '\r\n' + tmp_toolbar_real11 + '\r\n' + tmp_toolbar_real21 + '\r\n' + tmp_toolbar_real31 + '\r\n' + tmp_toolbar_real41 + '\r\n' + tmp_toolbar_real51 + datas.join("\", \"") + tmp_toolbar_real61 + '\r\n' + tmp_toolbar_real71 + '\r\n' + '</sc' + 'ript>\r\n' + tmp_toolbar_real_finish1;
			
			var name_input_first_open = document.getElementById({/literal}'liveeditor_real_toolbar{$smarty.request.id}'{literal})
			name_input_first_open.value = pos_form_real_first_open;
	
</script>
{/literal}



    <script type="text/javascript">
	var mod_li_id = {$smarty.request.id};
	{literal}
		$("#list1, #list2").dragsort({ dragSelector: "div", dragBetween: true, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>" });
		
					
			function saveOrder() {
			var data = $("#list1 li").map(function() { return $(this).children().attr('class'); }).get();
			var li_new = $("#list1 li").map(function() { return '<li title="' + $(this).attr('title') + '"><div class="' + $(this).children().attr('class') + '"></div></li>'; }).get();
			var li_available = $("#list2 li").map(function() { return '<li title="' + $(this).attr('title') + '"><div class="' + $(this).children().attr('class') + '"></div></li>'; }).get();
			
			
			var tmp_toolbar_real0 = 'var oEdit\' . $field_id . \' = new InnovaEditor("oEdit\' . $field_id . \'");';
			var tmp_toolbar_real1 = 'oEdit\' . $field_id . \'.css = "/admin/liveeditor/styles/default.css"; ';
			var tmp_toolbar_real2 = 'oEdit\' . $field_id . \'.fileBrowser = "/admin/liveeditor/assetmanager/asset.php";';
		    if(mod_li_id == 1){
				var tmp_toolbar_real_start = '\<?php\r\n $large = \'';
				var tmp_toolbar_real3 = 'oEdit\' . $field_id . \'.width = "\' . $AVE_Document->_textarea_width . \'";';
		        var tmp_toolbar_real4 = 'oEdit\' . $field_id . \'.height = "\' . $AVE_Document->_textarea_height . \'";';
				var tmp_toolbar_real7 = 'oEdit\' . $field_id . \'.REPLACE("editor[\' . $field_id . \']");';
				var tmp_toolbar_real_finish = '\';\r\n $innova = array (1 =>"$large");\r\n ?>';
			}
			else {
				var tmp_toolbar_real_start = '<?php\r\n $small = \'';
			    var tmp_toolbar_real3 = 'oEdit\' . $field_id . \'.width = "\' . $AVE_Document->_textarea_width_small . \'";';
		        var tmp_toolbar_real4 = 'oEdit\' . $field_id . \'.height = "\' . $AVE_Document->_textarea_height_small . \'";';
				var tmp_toolbar_real7 = 'oEdit\' . $field_id . \'.REPLACE("small-editor[\' . $field_id . \']");';
				var tmp_toolbar_real_finish = '\';\r\n $innova = array (2 =>"$small");\r\n ?>';
			}
		    var tmp_toolbar_real5 = 'oEdit\' . $field_id . \'.groups = [[\"group1\", \"\", [\"'
			var tmp_toolbar_real6 = '\"]]];';
			
			var pos_form_real = tmp_toolbar_real_start + '\r\n<sc' + 'ript type="text/javascript">\r\n' + tmp_toolbar_real0 + '\r\n' + tmp_toolbar_real1 + '\r\n' + tmp_toolbar_real2 + '\r\n' + tmp_toolbar_real3 + '\r\n' + tmp_toolbar_real4 + '\r\n' + tmp_toolbar_real5 + data.join("\", \"") + tmp_toolbar_real6 + '\r\n' + tmp_toolbar_real7 + '\r\n' + '</sc' + 'ript>\r\n' + tmp_toolbar_real_finish;
			
			var name_input = document.getElementById({/literal}'liveeditor_real_toolbar{$smarty.request.id}'{literal})
            name_input.value=pos_form_real;
			
			var tmp_toolbar0 = 'var oEdit777 = new InnovaEditor("oEdit777");\r\n';
			var tmp_toolbar1 = 'oEdit777.css = "/admin/liveeditor/styles/default.css";\r\n';
			var tmp_toolbar2 = 'oEdit777.fileBrowser = "/admin/liveeditor/assetmanager/asset.php";\r\n';
			var tmp_toolbar3 = 'oEdit777.width="100%";\r\n';
			var tmp_toolbar4 = 'oEdit777.height="200";\r\n';
			var tmp_gr_start = 'oEdit777.groups = [[\"group1\", \"\", [\"';
			var tmp_gr_end = '\"]]];\r\n';
			var tmp_toolbar5 = 'oEdit777.REPLACE("onlineContent");\r\n';
			var pos_form_lived = '<sc' + 'ript>' + tmp_toolbar0 + tmp_toolbar1 + tmp_toolbar2 + tmp_toolbar3 + tmp_toolbar4 + tmp_gr_start + data.join("\", \"") + tmp_gr_end + tmp_toolbar5 + '</sc' + 'ript>';
			$.cookie("live_make_toolbar", pos_form_lived, {expires: 7, path: '/', domain: ''});
			
			var name_input_new_toolbar = document.getElementById({/literal}'liveeditor_new_toolbar{$smarty.request.id}'{literal})
			name_input_new_toolbar.value = li_new.join(" ");
			
			var name_input_available_toolbar = document.getElementById({/literal}'liveeditor_available_toolbar{$smarty.request.id}'{literal})
			name_input_available_toolbar.value = li_available.join(" ");
			
			
			li_check = $("#btn_mod_li_real").attr("checked");
		    if(li_check == 'checked')
			{
			modalDialog('/modules/liveeditor/templates/toolbar-on-line.tpl', 900,82);
			}
	    };
	</script>
 {/literal}
 
 
 <div class="widget first">
 <div class="head"><h5 class="iFrames">{#LIVEEDITOR_EDIT_END#}</h5></div>
 <div class="rowElem">
				{if $smarty.request.id != ''}
					<input type="hidden" name="id" value="{$id}">
					<input name="submit" type="submit" class="basicBtn" value="{#LIVEEDITOR_SAVEDIT#}" />
				{else}
					<input name="submit" type="submit" class="basicBtn" value="{#LIVEEDITOR_SAVE#}" />
				{/if}

				&nbsp;или&nbsp;

				{if $smarty.request.moduleaction=='edit'}
					<input type="submit" class="blackBtn SaveEdit" name="next_edit" value="{#LIVEEDITOR_SAVEDIT_NEXT#}" />
				{else}
					<input type="submit" class="blackBtn SaveEdit" name="next_edit" value="{#LIVEEDITOR_SAVE_NEXT#}" />
				{/if}
 </div>
</div>

</form>
<script language="javascript">

    var sett_options = {ldelim}
		url: 'index.php?do=modules&action=modedit&mod=liveeditor&moduleaction=saveedit&cp={$sess}',
		beforeSubmit: Request,
        success: Response
	{rdelim}

	function Request(){ldelim}
		$.alerts._overlay('show');
	{rdelim}

	function Response(){ldelim}
		$.alerts._overlay('hide');
		$.jGrowl('{#LIVEEDITOR_SAVED#}');
	{rdelim}

	$(document).ready(function(){ldelim}

		Mousetrap.bind(['ctrl+s', 'meta+s'], function(e) {ldelim}
		    if (e.preventDefault) {ldelim}
		        e.preventDefault();
		    {rdelim} else {ldelim}
		        // internet explorer
		        e.returnValue = false;
		    {rdelim}
		    $("#liveeditor").ajaxSubmit(sett_options);
			return false;
		{rdelim});

	    $(".SaveEdit").click(function(e){ldelim}
		    if (e.preventDefault) {ldelim}
		        e.preventDefault();
		    {rdelim} else {ldelim}
		        // internet explorer
		        e.returnValue = false;
		    {rdelim}
		    $("#liveeditor").ajaxSubmit(sett_options);
			return false;
		{rdelim});

	{rdelim});

</script>

