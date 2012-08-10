<script language="javascript">

$(document).ready(function(){ldelim}

    var sett_options = {ldelim}
		url: 'index.php?do=settings&sub=countries&cp={$sess}&save=1',
		beforeSubmit: Request,
        success: Response
	{rdelim}

    $(".ConfirmSettings").click(function(e){ldelim}
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

<div class="title"><h5>{#SETTINGS_COUNTRIES#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#SETTINGS_COUNTRY_TIP#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=settings&amp;cp={$sess}">{#SETTINGS_MAIN_TITLE#}</a></li>
			<li>{#SETTINGS_COUNTRIES#}</li>
	    </ul>
	</div>
</div>


<div class="widget first">
<div class="head"><h5 class="iFrames">{#SETTINGS_INFO#}</h5></div>
    <div class="body">
		<a href="index.php?do=settings&amp;cp={$sess}" title="" class="btnIconLeft mr10"><img src="{$tpl_dir}/images/icons/cog3.png" alt="" class="icon" /><span>{#SETTINGS_MAIN#}</span></a>
		<a href="index.php?do=settings&amp;sub=case&amp;cp={$sess}" title="" class="btnIconLeft mr10"><img src="{$tpl_dir}/images/icons/cog3.png" alt="" class="icon" /><span>{#SETTINGS_CASE_TITLE#}</span></a>
		<a href="#" title="" class="btnIconLeft mr10 clearCacheSess"><img src="{$tpl_dir}/images/icons/cog3.png" alt="" class="icon"><span>{#MAIN_STAT_CLEAR_CACHE_FULL#}</span></a>
    </div>
</div>


<form id="settings" name="settings" method="post" action="index.php?do=settings&sub=countries&cp={$sess}&save=1" class="mainForm">
<fieldset>
<div class="widget first">
<div class="head"><h5 class="iFrames">{#SETTINGS_COUNTRIES_ALL#}</h5></div>

			<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
            	<thead>
                	<tr>
                        <td width="20%">{#SETTINGS_COUNTRY_NAME#}</td>
                        <td width="20%">{#SETTINGS_ACTIVE#}</td>
                        <td width="20%">{#SETTINGS_IN_EC#}</td>
                    </tr>
                </thead>
                <tbody>
			{foreach from=$laender item=land name=l}
			<tr>
				<td>
					<input name="country_name[{$land.Id}]" type="text" id="country_name[{$land.Id}]" value="{$land.country_name}" style="width: 95%;"/>
				</td>

				<td>
					<input type="radio" name="country_status[{$land.Id}]" value="1"{if $land.country_status==1} checked{/if} /><label style="cursor: pointer;">{#SETTINGS_YES#}</label>
					<input type="radio" name="country_status[{$land.Id}]" value="2"{if $land.country_status==2} checked{/if} /><label style="cursor: pointer;">{#SETTINGS_NO#}</label>
				</td>

				<td>
					<input type="radio" name="country_eu[{$land.Id}]" value="1"{if $land.country_eu==1} checked{/if} /><label style="cursor: pointer;">{#SETTINGS_YES#}</label>
					<input type="radio" name="country_eu[{$land.Id}]" value="2"{if $land.country_eu==2} checked{/if} /><label style="cursor: pointer;">{#SETTINGS_NO#}</label>
				</td>
			</tr>
			{/foreach}
                </tbody>
            </table>

			<div class="rowElem">
				<input type="submit" class="basicBtn ConfirmSettings" value="{#SETTINGS_BUTTON_SAVE#}" />
			</div>

</div>
</fieldset>
</form>


{if $page_nav}
	<div class="pagination">
	<ul class="pages">
		{$page_nav}
	</ul>
	</div>
{/if}

<br />