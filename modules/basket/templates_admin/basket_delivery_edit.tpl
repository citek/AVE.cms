<div class="first"></div>

<div class="title"><h5>{#EditDeliveryMethod#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#EditDeliveryInfo#}
    </div>
</div>

<div class="widget">
    <div class="head">
        <h5>{#EditDeliveryMethod#}</h5>
    </div>
<form method="post" action="index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_delivery_edit&cp={$sess}&pop=1&id={$smarty.request.id}&sub=save" class="mainForm">
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
		<tr>
			<td width="180">{#DeliveryName#}</td>
			<td>
				<input style="width:200px" type="text" name="delivery_title" value="{$delivery->delivery_title|stripslashes}">
			</td>
		</tr>

		<tr>
			<td>{#DeliveryDescription#}</td>
			<td>{$Edi}</td>
		</tr>

		<tr>
			<td>{#DeliveryActive#} </td>
			<td>
				<input type="radio" name="delivery_activ" value="1" {if $delivery->delivery_activ=='1'}checked {/if}/><label>{#Yes#}</label>&nbsp;
				<input type="radio" name="delivery_activ" value="0" {if $delivery->delivery_activ=='0'}checked {/if}/><label>{#No#}</label>
			</td>
		</tr>

		<tr>
			<td>{#DeliveryPrice#}</td>
			<td>
				<input name="delivery_price" type="text" id="delivery_price" value="{$delivery->delivery_price}" size="55" style="width: 300px;" style="float: left;" />

				<select name="delivery_price_operands">
					<option value="Money" {if $delivery->delivery_price_operands=='Money'}selected="selected"{/if}>{#PaymentCostMoney#}</option>
					<option value="%" {if $delivery->delivery_price_operands=='%'}selected="selected"{/if}>{#PaymentCostPercent#}</option>
					<option value="Text" {if $delivery->delivery_price_operands=='Text'}selected="selected"{/if}>{#PaymentCostText#}</option>
				</select>
			</td>
		</tr>

		<tr>
			<td colspan="2"><input class="basicBtn" type="submit" value="{#ButtonSave#}" /></td>
		</tr>
	</table>
	
</form>
</div>