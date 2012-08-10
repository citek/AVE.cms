<script type="text/javascript" language="JavaScript">
$(document).ready(function(){ldelim}

    $(".ConfirmDelete").click(function(e){ldelim}
		e.preventDefault();
		var href = $(this).attr('href');
		var title = $(this).attr('name');
		var confirm = $(this).attr('dir');
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

<div class="title">
  <h5>{#IMPORT_MODULE_NAME#}</h5>
</div>
<div class="widget" style="margin-top: 0px;">
  <div class="body">
    {#IMPORT_EDIT_TIP#}
  </div>
</div>
<div class="breadCrumbHolder module">
  <div class="breadCrumb module">
    <ul>
      <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
      <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
      <li>{#IMPORT_MODULE#}</li>
      <li><strong class="code">{#IMPORT_MODULE_NAME#}</strong></li>
    </ul>
  </div>
</div>
<div class="widget first">
  <div class="head">
    <h5 class="iFrames">{#IMPORT_MODULE_NAME#}</h5>
    <div class="num">
      <a class="basicNum" href="index.php?do=modules&action=modedit&mod=import&moduleaction=edit&cp={$sess}">{#IMPORT_ADD#}</a>
    </div>
  </div>
  <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
    <thead>
      <tr>
        <td width="10">{#IMPORT_ID#}</td>
        <td width="300">{#IMPORT_NAME#}</td>
        <td width="200">{#IMPORT_RUBRICS#}</td>
        <td width="140">{#IMPORT_LAST_UPDATE#}</td>
        <td colspan="3">{#IMPORT_ACTIONS#}</td>
      </tr>
    </thead>
    <tbody>
    {foreach from=$imports item=import}
    <tr>
      <td>{$import->id}</td>
      <td><a class="topDir" title="{#IMPORT_EDIT_HINT#}" href="index.php?do=modules&action=modedit&mod=import&moduleaction=edit&cp={$sess}&id={$import->id}"><strong> {$import->import_name|escape}</strong></a></td>
      <td>
        {foreach from=$rubs item=rub}
        {if $rub->Id==$import->import_rub}
        {$rub->rubric_title}
        {/if}
        {/foreach}
      </td>
      <td>{$import->import_last_update|date_format:"%Y-%m-%d %H:%M"}</td>
      <td width="1%" align="center"><a class="topleftDir icon_sprite ico_start" title="{#IMPORT_DO_HINT#}" href="index.php?do=modules&action=modedit&mod=import&moduleaction=do&cp={$sess}&id={$import->id}"></a></td>
      <td width="1%" align="center"><a class="topleftDir icon_sprite ico_edit" title="{#IMPORT_EDIT_HINT#}" href="index.php?do=modules&action=modedit&mod=import&moduleaction=edit&cp={$sess}&id={$import->id}"></a></td>
      <td width="1%" align="center"><a class="topleftDir ConfirmDelete icon_sprite ico_delete" dir="{#IMPORT_DEL_HINT#}" name="{#IMPORT_DELETE_HINT#}" title="{#IMPORT_DELETE_HINT#}" href="index.php?do=modules&action=modedit&mod=import&moduleaction=del&cp={$sess}&id={$import->id}"></a></td>
    </tr>
    {/foreach}
    {if ! $imports}
    <tr>
      <td colspan="8"><ul class="messages">
          <li class="highlight yellow">{#IMPORT_NO_ITEMS#}</li>
        </ul></td>
    </tr>
    {/if}
    </tbody>
  </table>
</div>
{if $page_nav}
<div class="pagination">
  <ul class="pages">
    {$page_nav}
  </ul>
</div>
{/if}