<div class="title"><h5>{#LOGIN_MODULE_NAME#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#LOGIN_MODULE_INFO#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li>{#LOGIN_MODULE#}</li>
	        <li><strong class="code">{#LOGIN_MODULE_NAME#}</strong></li>
	    </ul>
	</div>
</div>

<div class="widget first">
<div class="head"><h5 class="iFrames">{#LOGIN_MODULE_EDIT#}</h5></div>

<form method="post" action="index.php?do=modules&action=modedit&mod=login&moduleaction=1&cp={$sess}&sub=save" class="mainForm">
<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">

		<tr class="noborder">
			<td width="200">{#LOGIN_REGISTRATION_TYPE#}</td>
			<td>
				<select name="login_reg_type" id="login_reg_type">
					<option value="email" {if $login_reg_type=='email'}selected{/if}>{#LOGIN_TYPE_BYEMAIL#}</option>
					<option value="now" {if $login_reg_type=='now'}selected{/if}>{#LOGIN_TYPE_NOW#}</option>
					<option value="byadmin" {if $login_reg_type=='byadmin'}selected{/if}>{#LOGIN_TYPE_BYADMIN#}</option>
				</select>
			</td>
		</tr>

		<tr>
			<td width="200">{#LOGIN_USE_SCODE#}</td>
			<td>
				<input name="login_antispam" type="radio" value="1" {if $login_antispam=='1'}checked{/if} > <label>{#LOGIN_YES#}</label>
				<input name="login_antispam" type="radio" value="0" {if $login_antispam!='1'}checked{/if}> <label>{#LOGIN_NO#}</label>
			</td>
		</tr>

		<tr>
			<td width="200">{#LOGIN_ENABLE_REGISTER#}</td>
			<td>
				<input name="login_status" type="radio" value="1" {if $login_status=='1'}checked{/if} > <label>{#LOGIN_YES#}</label>
				<input name="login_status" type="radio" value="0" {if $login_status!='1'}checked{/if}> <label>{#LOGIN_NO#}</label>
			</td>
		</tr>

		<tr>
			<td>{#LOGIN_SHOW_FIRSTNAME#}</td>
			<td>
				<input name="login_require_firstname" type="radio" value="1" {if $login_require_firstname=='1'}checked{/if} > <label>{#LOGIN_YES#}</label>
				<input name="login_require_firstname" type="radio" value="0" {if $login_require_firstname!='1'}checked{/if}> <label>{#LOGIN_NO#}</label>
			</td>
		</tr>

		<tr>
			<td>{#LOGIN_SHOW_LASTNAME#}</td>
			<td>
				<input name="login_require_lastname" type="radio" value="1" {if $login_require_lastname=='1'}checked{/if} > <label>{#LOGIN_YES#}</label>
				<input name="login_require_lastname" type="radio" value="0" {if $login_require_lastname!='1'}checked{/if}> <label>{#LOGIN_NO#}</label>
			</td>
		</tr>

		<tr>
			<td>{#LOGIN_SHOW_COMPANY#}</td>
			<td>
				<input name="login_require_company" type="radio" value="1" {if $login_require_company=='1'}checked{/if} > <label>{#LOGIN_YES#}</label>
				<input name="login_require_company" type="radio" value="0" {if $login_require_company!='1'}checked{/if}> <label>{#LOGIN_NO#}</label>
			</td>
		</tr>

		<tr>
			<td width="200" valign="top">{#LOGIN_BLACK_DOMAINS#}</td>
			<td>
				<textarea style="width:400px; height:100px" name="login_deny_domain" id="login_deny_domain">{$login_deny_domain}</textarea>
			</td>
		</tr>

		<tr>
			<td width="200" valign="top">{#LOGIN_BLACK_EMAILS#}</td>
			<td >
				<textarea style="width:400px; height:100px" name="login_deny_email" id="login_deny_email">{$login_deny_email}</textarea>
			</td>
		</tr>

		<tr>
			<td class="third" colspan="2"><input type="submit" class="basicBtn" value="{#LOGIN_BUTTON_SAVE#}" /></td>
		</tr>
	</table>
</form>
</div>