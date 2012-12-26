<div class="title"><h5>{#DeliveryMethod#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#WelcomeText#}
    </div>
</div>

<div class="widget">
    <div class="head">
        <h5>{#DeliveryMethod#}</h5>
        <div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_payment&cp={$sess}">{#EditPaymentMethod#}</a></div>
        <div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=basket&moduleaction=1&cp={$sess}">{#mainPage#}</a></div>
    </div>

<form action="index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_delivery&cp={$sess}&sub=save" method="post" class="mainForm">
<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
	<col>
	<col width="60">
	<col width="140">
	<col width="20">
	<col width="20">
	<thead>
		<tr>
			<td>{#DeliveryMethodName#}</td>
			<td>{#DeliveryMethodPosition#}</td>
			<td>{#DeliveryMethodActive#}</td>
			<td colspan="2">{#Actions#}</td>
		</tr>
	</thead>
	<tbody>
		{foreach from=$methods item=delivery}
			<tr>
				<td>
					<div class="pr12"><input type="text" name="delivery_title[{$delivery->id}]" value="{$delivery->delivery_title|stripslashes}"></div>
				</td>
				<td>
					<div class="pr12"><input name="delivery_position[{$delivery->id}]" type="text" value="{$delivery->delivery_position}" size="3" maxlength="3" /></div>
				</td>

				<td>
					<input type="radio" name="delivery_activ[{$delivery->id}]" value="1" {if $delivery->delivery_activ=='1'}checked {/if}/><label>{#Yes#}</label>&nbsp;
					<input type="radio" name="delivery_activ[{$delivery->id}]" value="0" {if $delivery->delivery_activ=='0'}checked {/if}/><label>{#No#}</label>
				</td>
				<td>
					<a class="topleftDir icon_sprite ico_edit" href="javascript:void(0);" title="{#ButtonEdit#}" onclick="cp_pop('index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_delivery_edit&cp={$sess}&pop=1&id={$delivery->id}','800','680','1','shopshipper');"></a>
				</td>
				<td>
					{if $delivery->id!=1}
						<a class="topleftDir icon_sprite ico_delete ConfirmDelete" title="{#DeliveryMethodDel#}" dir="{#DeliveryMethodDel#}" name="{#DeliveryMethodDelTitle#}" href="index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_delivery_del&id={$delivery->id}"></a>
					{/if}
				</td>

			</tr>
		{/foreach}
			<tr>
				<td colspan="5"><input type="submit" class="basicBtn" value="{#ButtonSave#}"></td>
			</tr>
	</tbody>
	</table>
</form>
</div>


<div class="widget">
    <div class="head">
        <h5>{#NewDeliveryMethod#}</h5>
    </div>
<form method="post" action="index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_delivery_new&cp={$sess}" class="mainForm">
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic" id="Fields">
		<tr>
			<td class="first">
				<input style="width:250px" type="text" name="delivery_title" value="" placeholder="{#DeliveryMethodName#}">&nbsp;<input type="submit" class="basicBtn" value="{#ButtonAdd#}" />
			</td>
		</tr>
	</table>
</form>
</div>

