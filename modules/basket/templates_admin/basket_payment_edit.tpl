<div class="first"></div>

<div class="title"><h5>{#EditPaymentMethod#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#EditPaymentInfo#}
    </div>
</div>

<div class="widget">
    <div class="head">
        <h5>{#EditDeliveryMethod#}</h5>
    </div>
<form method="post" action="index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_payment_edit&cp={$sess}&pop=1&id={$smarty.request.id}&sub=save" class="mainForm">
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
		<tr>
			<td width="180">{#PaymentName#}</td>
			<td>
				<input style="width:200px" type="text" name="payment_title" value="{$payment->payment_title|stripslashes}">
			</td>
		</tr>

		<tr>
			<td>{#PaymentDescription#}</td>
			<td>{$Edi}</td>
		</tr>

		<tr>
			<td>{#PaymentActive#} </td>
			<td>
				<input type="radio" name="payment_activ" value="1" {if $payment->payment_activ=='1'}checked {/if}/><label>{#Yes#}</label>&nbsp;
				<input type="radio" name="payment_activ" value="0" {if $payment->payment_activ=='0'}checked {/if}/><label>{#No#}</label>
			</td>
		</tr>

		<tr>
			<td>{#PaymentPrice#}</td>
			<td>
				<input name="payment_price" type="text" id="payment_price" value="{$payment->payment_price}" size="55" style="width: 300px;" style="float: left;" />
				<select name="payment_price_operands">
					<option value="Money" {if $payment->payment_price_operands=='Money'}selected="selected"{/if}>{#PaymentCostMoney#}</option>
					<option value="%" {if $payment->payment_price_operands=='%'}selected="selected"{/if}>{#PaymentCostPercent#}</option>
					<option value="Text" {if $payment->payment_price_operands=='Text'}selected="selected"{/if}>{#PaymentCostText#}</option>
				</select>
			</td>
		</tr>

		<tr>
			<td>
				{#AllowedDeliveryMethods#}<br />
				<small>{#DeliveryMethodInf#}</small>
			</td>
			<td>
				<select name="payment_delivery[]" multiple="multiple" size="8" style="width:200px">
					{foreach from=$basket_delivery item=delivery}
						{assign var='sel' value=''}
						{if $delivery->id}
							{if (in_array($delivery->id,$payment->payment_delivery))}
								{assign var='sel' value='selected'}
							{/if}
						{/if}
						<option value="{$delivery->id}" {$sel}>{$delivery->delivery_title|escape:html}</option>
					{/foreach}
				</select>
			</td>
		</tr>

		<tr>
			<td colspan="2"><input class="basicBtn" type="submit" value="{#ButtonSave#}" /></td>
		</tr>
	</table>

	
</form>
</div>