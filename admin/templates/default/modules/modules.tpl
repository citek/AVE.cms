{assign var=permission_modules_admin value=check_permission('modules_admin')}
{if $permission_modules_admin}
<script type="text/javascript" language="JavaScript">
$(document).ready(function(){ldelim}

    $(".ConfirmReInstall").click(function(e){ldelim}
		e.preventDefault();
		var href = $(this).attr('href');
		var title = '{#MODULES_REINSTALL#}';
		var confirm = '{#MODULES_REINSTALL_CONF#}';
		jConfirm(
				confirm,
				title,
				function(b){ldelim}
					if (b){ldelim}
						$.alerts._overlay('show');
						window.location = href;
					{rdelim}
				{rdelim}
			);
	{rdelim});

{rdelim});
</script>
{/if}

<div class="title"><h5>{#MODULES_SUB_TITLE#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#MODULES_TIP#}
    </div>
</div>

{if $errors}
	<ul class="infobox_error">
		{foreach from=$errors item=message}
			<li>{$message}</li>
		{/foreach}
	</ul>
{/if}

<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li>{#MODULES_SUB_TITLE#}</li>
	    </ul>
	</div>
</div>

<div class="widget first">
	<ul class="tabs">
		<li class="activeTab"><a href="#tab1">{#MODULES_INSTALLED#}</a></li>
		<li class=""><a href="#tab2">{#MODULES_NOT_INSTALLED#}</a></li>
	</ul>

	<div class="tab_container">
		<div id="tab1" class="tab_content" style="display: block; ">

{assign var=permission_modules_admin value=check_permission('modules_admin')}
{if $permission_modules_admin}
	<form method="post" action="index.php?do=modules&action=quicksave&cp={$sess}" class="mainForm">
{/if}

<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
	<thead>
		<tr>
			<td width="30">?</td>
			<td>{#MODULES_NAME#}</td>
			<td width="200">{#MODULES_TEMPLATE#}</td>
			<td width="150">{#MODULES_SYSTEM_TAG#}</td>
			<td width="50">{#MODULES_VERSION#}</td>
			{if $permission_modules_admin}
				<td colspan="3" width="60">{#MODULES_ACTIONS#}</td>
			{/if}
		</tr>
	</thead>
	<tbody>
{foreach from=$installed_modules item=module}
		{if $module->mod_permission}
			<tr>
				<td align="center">
					<a title="<strong>{$module->name}</strong><br />{$module->info|escape|default:''}" href="javascript:void(0);" style="cursor:help;" class="rightDir icon_sprite ico_info"></a>
				</td>

				<td nowrap="nowrap">
					{if $module->adminedit && $module->status}
						<strong><a href="index.php?do=modules&action=modedit&mod={$module->path}&moduleaction=1&cp={$sess}" title="{#MODULES_SETUP#}" class="toprightDir docname">{$module->name}</a></strong>
                        {if $module->taglink != ""}<br /><span class="dgrey doclink">{$module->taglink}</span>{/if}
					{else}
						<strong>{$module->name}</strong>
					{/if}
				</td>

				<td>
					{if $module->template}
						{assign var=module_id value=$module->id}
						{if $module->status}
							{html_options name=Template[$module_id] options=$all_templates selected=$module->template style="width: 200px"}
						{else}
							{html_options name=Template[$module_id] options=$all_templates selected=$module->template style="width: 200px" disabled="disabled"}
						{/if}
					{else}
						&nbsp;
					{/if}
				</td>

				<td>{if $module->tag != ""}<input readonly type="text" value="{$module->tag|stripslashes|default:'&nbsp;'}" style="width: 150px;" />{/if}</td>

				<td align="center" class="webStatsLink">{$module->version|escape|default:''}</td>

				{if $permission_modules_admin}
					<td align="center" width="20">
						{if $module->status}
							<a title="{#MODULES_STOP#}" href="index.php?do=modules&amp;action=onoff&amp;module={$module->path}&amp;cp={$sess}" class="topDir icon_sprite ico_stop"></a>
						{else}
							<a title="{#MODULES_START#}" href="index.php?do=modules&amp;action=onoff&amp;module={$module->path}&amp;cp={$sess}" class="topDir icon_sprite ico_start"></a>
						{/if}
					</td>

					<td align="center" width="20">
						{if $module->status}
							<a title="{#MODULES_REINSTALL#}" href="index.php?do=modules&amp;action=reinstall&amp;module={$module->path}&amp;cp={$sess}" class="topleftDir ConfirmReInstall icon_sprite ico_reinstall"></a>
						{else}
							<a title="{#MODULES_DELETE#}" dir="{#MODULES_DELETE#}" name="{#MODULES_DELETE_CONFIRM#}" href="index.php?do=modules&amp;action=delete&amp;module={$module->path}&amp;cp={$sess}" class="topleftDir ConfirmDelete icon_sprite ico_delete"></a>
						{/if}
					</td>

					<td align="center" width="20">
						{if $module->need_update}
							<a title="{#MODULES_UPDATE#}" href="index.php?do=modules&amp;action=update&amp;module={$module->path}&amp;cp={$sess}" class="topleftDir icon_sprite ico_globus"></a>
						{else}
							<span title="" class="topleftDir icon_sprite ico_blanc"></span>
						{/if}
					</td>
				{/if}
			</tr>
		{/if}
	{/foreach}
	</tbody>
</table>

		{if $permission_modules_admin}
		<div class="rowElem">
			<input type="submit" class="basicBtn" value="{#MODULES_BUTTON_SAVE#}" />
		</div>
		</form>
		{/if}

</div>

<div id="tab2" class="tab_content" style="display: none; ">

{if $not_installed_modules}
<form class="mainForm">
<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
	<thead>
		<tr>
			<td width="30">?</td>
			<td>{#MODULES_NAME#}</td>
			<td width="200">{#MODULES_TEMPLATE#}</td>
			<td width="150">{#MODULES_SYSTEM_TAG#}</td>
			<td width="50">{#MODULES_VERSION#}</td>
			{if $permission_modules_admin}
				<td colspan="2" width="40">{#MODULES_ACTIONS#}</td>
			{/if}
		</tr>
	</thead>
                        <tbody>
	{foreach from=$not_installed_modules item=module}
		{if $module->mod_permission}
			<tr>
				<td align="center">
					<a title="<strong>{$module->name}</strong><br />{$module->info|escape|default:''}" href="javascript:void(0);" style="cursor: help;" class="rightDir icon_sprite ico_info_no"></a>
				</td>

				<td>{if $module->adminedit}<strong>{$module->name}</strong>{else}{$module->name}{/if}{if $module->taglink != ""}<br /><span class="dgrey doclink">{$module->taglink}</span>{/if}</td>

				<td>
					{if $module->template}
						<select style="width: 200px;" disabled="disabled"><option>{$all_templates[1]}</option></select>
					{else}
						&nbsp;
					{/if}
				</td>

				<td>{if $module->tag != ""}<input readonly type="text" value="{$module->tag|stripslashes|default:'&nbsp;'}" style="width: 150px;" />{/if}</td>

				<td align="center" class="Version">{$module->version|escape|default:''}</td>

				{if $permission_modules_admin}
					<td align="center" width="20">
						<a title="{#MODULES_INSTALL#}" href="index.php?do=modules&amp;action=install&amp;module={$module->path}&amp;cp={$sess}" class="topDir icon_sprite ico_install"></a>
					</td>

					<td align="center" width="20"><span title="" class="topleftDir icon_sprite ico_delete_no"></span></td>
				{/if}
			</tr>
		{/if}
	{/foreach}
                        </tbody>
                    </table>
</form>
{else}
<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
	<thead>
		<tr>
			<td width="30">?</td>
			<td>{#MODULES_NAME#}</td>
			<td width="200">{#MODULES_TEMPLATE#}</td>
			<td width="150">{#MODULES_SYSTEM_TAG#}</td>
			<td width="50">{#MODULES_VERSION#}</td>
            <td width="150">{#MODULES_ACTIONS#}</td>
		</tr>
	</thead>
	<tbody>
		<tr>
		<td colspan="6">
        <ul class="messages">
            <li class="highlight yellow"><strong>Сообщение:</strong><br />В системе нет неустановленных модулей.</li>
        </ul>
        </td>
		</tr>
	</tbody>
</table>
{/if}


</div>
            </div>
            <div class="fix"></div>
        </div>


