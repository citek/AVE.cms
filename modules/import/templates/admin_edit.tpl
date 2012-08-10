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
<form method="post" action="index.php?do=modules&action=modedit&mod=import&moduleaction=saveedit&cp={$sess}" class="mainForm">
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
          <select name="import_rub" {if $smarty.request.id != ''}disabled="disabled"{/if}>
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
          <select name="import_parser">
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
        <td>{#IMPORT_FILE#}</td>
        <td><div class="pr12">
            <input name="import_default_file" type="text" value="{$import_default_file|escape}" size="50" placeholder="{#IMPORT_FILE#}" style="width: 500px;" />
          </div></td>
      </tr>
      <tr>
        <td>{#IMPORT_CHECK_FILE#}</td>
        <td><input name="import_monitor_file" id="import_monitor_file" type="checkbox" value="1" {if $import_monitor_file==1}checked="checked"{/if}/></td>
      </tr>
      <tr>
        <td class="third" colspan="3">
          {if $smarty.request.id != ''}
            <input type="hidden" name="id" value="{$id}">
            <input name="submit" type="submit" class="basicBtn" value="{#IMPORT_SAVEDIT#}" />
          {else}
            <input name="submit" type="submit" class="basicBtn" value="{#IMPORT_SAVE#}" />
          {/if} </td>
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
        <col width="1">
        <col width="300">
        <col>
        <thead>
          <tr>
            <td align="center"><div align="center">
                <a href="javascript:void(0);" class="topleftDir icon_sprite ico_info" title="{#IMPORT_KEYS_INFO#}"></a>
              </div></td>
            <td>{#IMPORT_F#}</td>
            <td>{#IMPORT_TPL#}</td>
          </tr>
        </thead>
        <tbody>
          {foreach from=$data.header key=k item=v}
            <tr>
              <td><input type="checkbox" disabled/></td>
              <td>{$data.name.$k}</td>
              <td><input type="text" name="document[header][{$k}]" value="{$v|escape|stripslashes}" size="50" style="width:95%" /></td>
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
        <col width="1">
        <col width="300">
        <col>
        <thead>
          <tr>
            <td width="1%" align="center">
              <div align="center">
                <a href="javascript:void(0);" class="topleftDir icon_sprite ico_info" title="{#IMPORT_KEYS_INFO#}"></a>
              </div>
            </td>
            <td width="300">{#IMPORT_F#}</td>
            <td>{#IMPORT_TPL#}</td>
          </tr>
        </thead>
        <tbody>
          {foreach from=$data.body key=k item=v}
            <tr>
              <td><input name="document[key][{$k}]" id="document_key_{$k}" type="checkbox" value="1" {if $data.key.$k==1}checked="checked"{/if}/></td>
              <td>{$v[1]}</td>
              <td><input type="text" name="document[body][{$k}]" value="{$v[0]|escape|stripslashes}" size="50" style="width:95%" /></td>
            </tr>
          {/foreach}
          <tr>
            <td class="third" colspan="3"><input type="hidden" name="id" value="{$id}">
              <input name="submit" type="submit" class="basicBtn" value="{#IMPORT_SAVEDIT#}"/>
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
      <input readonly type="text" value="[Y-m-d]" style="margin-top:1px;" title="Тег текущей даты. Формат вывода: yyyy-mm-dd">
      <input readonly type="text" value="[row:XXX]" style="margin-top:1px;" title="Значение из элемента массива, где XXX - имя ключа">
      <input readonly type="text" value="[row:XXX:YYY:...]" style="margin-top:1px; margin-bottom:1px;" title="Значение из многомерного массива; уровень вложенности через :">
      {if $data.tags}
        Теги файла:
        {foreach from=$data.tags key=k item=v}
          <input readonly type="text" value="{$v}" style="margin-top:1px;">
        {/foreach}
      {/if}
    </div>
  </div>
  {/if}
</form>