<div class="title">
  <h5>{if $smarty.request.id == ''}{#IMPORT_H_ADD#}{else}{#IMPORT_H_EDIT#}{/if}</h5>
</div>
<div class="widget" style="margin-top: 0px;">
  <div class="body">
    {#IMPORT_INFO_EDIT#}
  </div>
</div>
<div class="breadCrumbHolder module">
  <div class="breadCrumb module">
    <ul>
      <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
      <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
      <li><a href="index.php?do=modules&action=modedit&mod=import&moduleaction=1&cp={$sess}">{#IMPORT_MODULE_NAME#}</a></li>
      <li>{if $smarty.request.id == ''}{#IMPORT_H_ADD#}{else}{#IMPORT_H_EDIT#}{/if}</li>
      <li><strong class="code">{if $smarty.request.id == ''}{#IMPORT_H_ADD#}{else}{$import_name|escape}{/if}</strong></li>
    </ul>
  </div>
</div>
<form method="post" id="import_edit_form" action="index.php?do=modules&action=modedit&mod=import&moduleaction=saveedit&cp={$sess}" class="mainForm">
  <div class="widget first">
    <div class="head{if $smarty.request.id != ''} closed{/if}">
      <h5 class="iFrames">{#IMPORT_H_EDIT#}</h5>
    </div>
    <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
      <tr class="noborder">
        <td width="250">{#IMPORT_NAME#}</td>
        <td><div class="pr12">
            <input name="import_name" type="text" value="{$import_name|escape}" placeholder="{#CONTACT_FORM_NAME#}" size="50" style="width: 500px;" />
          </div></td>
      </tr>
      <tr>
        <td>{#IMPORT_RUBRICS#}</td>
        <td>
          <select class="mousetrap" name="import_rub" {if $smarty.request.id != ''}disabled="disabled"{/if}>
            {foreach from=$rubs item=rub}
              {if $rub->Id==$import_rub}
                <option value="{$rub->Id}" selected>{$rub->rubric_title}</option>
              {else}
                <option value="{$rub->Id}">{$rub->rubric_title}</option>
              {/if}
			{/foreach}
          </select></td>
      </tr>
      <tr>
        <td>{#IMPORT_PARSER#}</td>
        <td>
          <select class="mousetrap" name="import_parser">
            {foreach from=$parses item=parse}
              {if $parse==$import_parser}
                <option value="{$parse}" selected>{$parse}</option>
              {else}	
                <option value="{$parse}">{$parse}</option>
              {/if}
			{/foreach}
		  </select></td>
      </tr>
      <tr>
        <td>{#IMPORT_DELETE_DOCS#}</td>
        <td><input class="mousetrap" name="import_delete_docs" type="checkbox" value="1" {if $import_delete_docs==1}checked="checked"{/if}/></td>
      </tr>
      <tr>
        <td>{#IMPORT_FILE#}</td>
        <td><div class="pr12">
            <input class="mousetrap" name="import_default_file" type="text" value="{$import_default_file|escape}" size="50" placeholder="{#IMPORT_FILE#}" style="width: 500px;" />
          </div></td>
      </tr>
      <tr>
        <td>{#IMPORT_CHECK_FILE#}</td>
        <td><input class="mousetrap" name="import_monitor_file" id="import_monitor_file" type="checkbox" value="1" {if $import_monitor_file==1}checked="checked"{/if}/></td>
      </tr>
      <tr>
        <td class="third" colspan="3">
            <input type="submit" class="basicBtn" value="{if $smarty.request.id != ''}{#IMPORT_SAVE#}{else}{#IMPORT_CREATE#}{/if}"/>
            {if $smarty.request.id != ''}<input type="submit" class="blackBtn SaveEdit" value="{#IMPORT_CTRLS#}" />
            <input type="submit" class="greenBtn" value="{#IMPORT_REFRESH_TAGS#}" onclick="window.location ='index.php?do=modules&action=modedit&mod=import&moduleaction=tags&id={$id}&cp={$sess}';return false;" />{/if}
        </td>
      </tr>
    </table>
  </div>
  {if $smarty.request.id != ''}
  <div style="position:relative;width:73%;float:left">
    <div class="widget first">
      <div class="head closed">
        <h5 class="iFrames">{#IMPORT_MAIN_FIELDS#}</h5>
      </div>
      <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
        <thead>
          <tr>
            <td width="35" align="center">
              <div align="center">
                <a href="javascript:void(0);" class="topDir icon_sprite ico_info" title="{#IMPORT_ACTIVE_INFO#}"></a>
              </div>
            </td>
            <td width="35" align="center">
              <div align="center">
                <a href="javascript:void(0);" class="topDir icon_sprite ico_info" title="{#IMPORT_KEYS_INFO#}"></a>
              </div>
            </td>
            <td width="300">{#IMPORT_F#}</td>
            <td>{#IMPORT_TPL#}</td>
          </tr>
        </thead>
        <tbody>
          {foreach from=$data.fields.header key=k item=v}
            <tr>
              <td>
                <input class="mousetrap" name="document[active][header][{$k}]" type="hidden" value="0" />
                <input class="mousetrap" name="document[active][header][{$k}]" type="checkbox" value="1" {if !$data.active.header.$k==0}checked="checked"{/if} {if $k=='Id'}disabled="disabled"{/if} />
              </td>
              <td><input class="mousetrap" name="document[key][header][{$k}]" type="checkbox" value="1" {if $data.key.header.$k==1}checked="checked"{/if}/></td>
              <td>{$v[1]}</td>
              <td><input class="mousetrap" type="text" name="document[fields][header][{$k}]" value="{$v[0]|escape|stripslashes}" size="50" style="width:95%" /></td>
            </tr>
          {/foreach}
        </tbody>
      </table>
    </div>
    <div class="widget first">
      <div class="head">
        <h5 class="iFrames">{#IMPORT_RUB_FIELDS#}</h5>
      </div>
      <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
        <thead>
          <tr>
            <td width="35" align="center">
              <div align="center">
                <a href="javascript:void(0);" class="topDir icon_sprite ico_info" title="{#IMPORT_ACTIVE_INFO#}"></a>
              </div>
            </td>
            <td width="35" align="center">
              <div align="center">
                <a href="javascript:void(0);" class="topDir icon_sprite ico_info" title="{#IMPORT_KEYS_INFO#}"></a>
              </div>
            </td>
            <td width="300">{#IMPORT_F#}</td>
            <td>{#IMPORT_TPL#}</td>
          </tr>
        </thead>
        <tbody>
          {foreach from=$data.fields.body key=k item=v}
            <tr>
              <td>
                <input class="mousetrap" name="document[active][body][{$k}]" type="hidden" value="0" />
                <input class="mousetrap" name="document[active][body][{$k}]" type="checkbox" value="1" {if !$data.active.body.$k==0}checked="checked"{/if}/>
              </td>
              <td><input class="mousetrap" name="document[key][body][{$k}]" type="checkbox" value="1" {if $data.key.body.$k==1}checked="checked"{/if}/></td>
              <td>{$v[1]}</td>
              <td><input class="mousetrap" type="text" name="document[fields][body][{$k}]" value="{$v[0]|escape|stripslashes}" size="50" style="width:95%" /></td>
            </tr>
          {/foreach}
          <tr>
            <td class="third" colspan="4">
              <input type="hidden" name="id" value="{$id}">
              <input type="submit" class="basicBtn" value="{#IMPORT_SAVE#}"/>
              <input type="submit" class="blackBtn SaveEdit" value="{#IMPORT_CTRLS#}" />
              <input type="submit" class="greenBtn" value="{#IMPORT_REFRESH_TAGS#}" onclick="window.location ='index.php?do=modules&action=modedit&mod=import&moduleaction=tags&id={$id}&cp={$sess}';return false;" />
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
  <div class="widget first" style="position:relative;display:block;float:right;clear:none;width:25%">
    <div class="head">
      <h5 class="iFrames">{#IMPORT_TAGS#}</h5>
    </div>
    <div style="text-align:center">
      <input class="mousetrap" readonly type="text" value="[Y-m-d]" style="margin-top:1px; width:93%" title="{#IMPORT_TAG_DATE#}">
      <input class="mousetrap" readonly type="text" value="[row:XXX]" style="margin-top:1px; width:93%" title="{#IMPORT_TAG_1#}">
      <input class="mousetrap" readonly type="text" value="[row:XXX:YYY:...]" style="margin-top:1px; width:93%" title="{#IMPORT_TAG_2#}">
      {if $data.tags}
        {#IMPORT_TAGS_TITLE#}
        {foreach from=$data.tags key=k item=v}
          <input class="mousetrap" readonly type="text" value="{$v}" style="margin-top:1px; width:93%">
        {/foreach}
      {/if}
    </div>
  </div>
  {/if}
</form>
<script language="javascript">
var sett_options = {ldelim}
	url: 'index.php?do=modules&action=modedit&mod=import&moduleaction=saveedit&cp={$sess}',
	beforeSubmit: Request,
	success: Response,
	error: Error
{rdelim}

function Request(){ldelim}
	$.alerts._overlay('show');
{rdelim}

function Response(){ldelim}
	$.alerts._overlay('hide');
	$.jGrowl('{#IMPORT_SAVED#}', {ldelim}theme: 'accept'{rdelim});
{rdelim}

function Error(){ldelim}
	$.alerts._overlay('hide');
	$.jGrowl('{#IMPORT_FAILED#}', {ldelim}theme: 'error'{rdelim});
{rdelim}

$(document).ready(function(){ldelim}

	Mousetrap.bind(['ctrl+s', 'meta+s'], function(e) {ldelim}
		if (e.preventDefault) {ldelim}
			e.preventDefault();
		{rdelim} else {ldelim}
			// internet explorer
			e.returnValue = false;
		{rdelim}
		$("#import_edit_form").ajaxSubmit(sett_options);
		return false;
	{rdelim});

	$(".SaveEdit").click(function(e){ldelim}
		if (e.preventDefault) {ldelim}
			e.preventDefault();
		{rdelim} else {ldelim}
			// internet explorer
			e.returnValue = false;
		{rdelim}
		$("#import_edit_form").ajaxSubmit(sett_options);
		return false;
	{rdelim});

{rdelim});
</script>