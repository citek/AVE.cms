<div class="title"><h5>{#SETTINGS_CASE_TITLE#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#SETTINGS_SAVE_INFO#}
    </div>
</div>

<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=settings&amp;cp={$sess}">{#SETTINGS_MAIN_TITLE#}</a></li>
			<li>{#SETTINGS_CASE_TITLE#}</li>
	    </ul>
	</div>
</div>

<div class="widget first">
<div class="head"><h5 class="iFrames">{#SETTINGS_INFO#}</h5></div>
    <div class="body">
		<a href="index.php?do=settings&amp;cp={$sess}" title="" class="btnIconLeft mr10"><img src="{$tpl_dir}/images/icons/cog3.png" alt="" class="icon" /><span>{#SETTINGS_MAIN_SETTINGS#}</span></a>
		<a href="index.php?do=settings&amp;sub=countries&amp;cp={$sess}" title="" class="btnIconLeft mr10"><img src="{$tpl_dir}/images/icons/cog3.png" alt="" class="icon" /><span>{#MAIN_COUNTRY_EDIT#}</span></a>
		<a href="#" title="" class="btnIconLeft mr10 clearCacheSess"><img src="{$tpl_dir}/images/icons/cog3.png" alt="" class="icon"><span>{#MAIN_STAT_CLEAR_CACHE_FULL#}</span></a>
		<a href="#" title="" class="btnIconLeft mr10 clearThumb"><img src="{$tpl_dir}/images/icons/cog3.png" alt="" class="icon"><span>{#MAIN_STAT_CLEAR_THUMB#}</span></a>
    </div>
</div>


<form id="settings" name="settings" method="post" action="index.php?do=settings&cp={$sess}&sub=save&dop=case" class="mainForm">
<fieldset>
<div class="widget first">

<div class="head"><h5 class="iFrames">{#SETTINGS_CASE_TITLE#}</h5></div>
<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
	<tbody>

		{foreach from=$CMS_CONFIG item=def key=_var}
<tr>
<td width="300">{$def.DESCR} <br /><small>{$_var}</small></td>
        <td>
			{if $def.TYPE=="dropdown"}
				<select name="GLOB[{$_var}]" style="width: 250px;"/>
					{foreach from=$def.VARIANT item=elem}
						<option value="{$elem}"
							{php}
								echo (constant($this->_tpl_vars['_var'])==$this->_tpl_vars['elem'] ? 'selected' :'' );
							{/php}>{$elem}</option>
					{/foreach}
				</select>
			{/if}
			{if $def.TYPE=="string"}
				<input class="mousetrap" name="GLOB[{$_var}]" type="text" id="{$_var}" style="width:550px" value="{php} echo(constant  ($this->_tpl_vars['_var']));{/php}" size="100" />
			{/if}
			{if $def.TYPE=="integer"}
				<input class="mousetrap" name="GLOB[{$_var}]" type="text" id="{$_var}" style="width:550px" value="{php} echo(constant  ($this->_tpl_vars['_var']));{/php}" size="100" />
			{/if}
			{if $def.TYPE=="bool"}
				<input type="radio" name="GLOB[{$_var}]" value="1" {php} echo(constant($this->_tpl_vars['_var']) ? 'checked' : "");{/php} /><label style="cursor: pointer;">{#SETTINGS_YES#}</label>
				<input type="radio" name="GLOB[{$_var}]" value="0" {php} echo(constant($this->_tpl_vars['_var']) ? '' : "checked");{/php} /><label style="cursor: pointer;">{#SETTINGS_NO#}</label>
			{/if}
        </td>
      </tr>
		{/foreach}
    </tbody>
</table>



<div class="rowElem">
	<input type="submit" class="basicBtn SaveSettings" value="{#SETTINGS_BUTTON_SAVE#}" />
</div>



</div>
</fieldset>

</form>

<script language="javascript">

$(document).ready(function(){ldelim}

    var sett_options = {ldelim}
		url: 'index.php?do=settings&cp={$sess}&sub=save&dop=case',
		{*target: '#contentPage',*}
		beforeSubmit: Request,
        success: Response
	{rdelim}

    $(".SaveSettings").click(function(e){ldelim}
		e.preventDefault();
		var title = '{#SETTINGS_BUTTON_SAVE#}';
		var confirm = '{#SETTINGS_SAVE_CONFIRM#}';
		jConfirm(
				confirm,
				title,
				function(b){ldelim}
					if (b){ldelim}
        				$("#settings").ajaxSubmit(sett_options);
					{rdelim}
				{rdelim}
			);
	{rdelim});

		Mousetrap.bind(['ctrl+s', 'meta+s'], function(e) {ldelim}
		    if (e.preventDefault) {ldelim}
		        e.preventDefault();
		    {rdelim} else {ldelim}
		        // internet explorer
		        e.returnValue = false;
		    {rdelim}
		    $("#settings").ajaxSubmit(sett_options);
			return false;
		{rdelim});

{rdelim});

function Request(){ldelim}
	$.alerts._overlay('show');
	$('html, body').animate({ldelim}scrollTop:0{rdelim});
{rdelim}

function Response(){ldelim}
	$.alerts._overlay('hide');
	$.jGrowl('{#SETTINGS_SAVED#}');
{rdelim}

</script>