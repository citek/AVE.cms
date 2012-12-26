<div class="title"><h5>{#PaymentMethod#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#WelcomeText#}
    </div>
</div>

<div class="widget">
    <div class="head">
        <h5>{#PaymentMethod#}</h5>
        <div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_delivery&cp={$sess}">{#EditDeliveryMethod#}</a></div>
        <div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=basket&moduleaction=1&cp={$sess}">{#mainPage#}</a></div>
    </div>

<form action="index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_payment&cp={$sess}&sub=save" method="post" class="mainForm">
<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
	<col>
	<col width="60">
	<col width="140">
	<col width="20">
	<col width="20">
	<thead>
		<tr>
			<td>{#PaymentMethodName#}</td>
			<td>{#PaymentMethodPosition#}</td>
			<td>{#PaymentMethodActive#}</td>
			<td colspan="2">{#Actions#}</td>
		</tr>
	</thead>
	<tbody>
		{foreach from=$methods item=payment}
			<tr>
				<td>
					<div class="pr12"><input type="text" name="payment_title[{$payment->id}]" value="{$payment->payment_title|stripslashes}"></div>
				</td>
				<td>
					<div class="pr12"><input name="payment_position[{$payment->id}]" type="text" value="{$payment->payment_position}" size="3" maxlength="3" /></div>
				</td>

				<td>
					<input type="radio" name="payment_activ[{$payment->id}]" value="1" {if $payment->payment_activ=='1'}checked {/if}/><label>{#Yes#}</label>&nbsp;
					<input type="radio" name="payment_activ[{$payment->id}]" value="0" {if $payment->payment_activ=='0'}checked {/if}/><label>{#No#}</label>
				</td>
				<td>
					<a class="topleftDir icon_sprite ico_edit" href="javascript:void(0);" title="{#ButtonEdit#}" onclick="cp_pop('index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_payment_edit&cp={$sess}&pop=1&id={$payment->id}','800','680','1','shopshipper');"></a>
				</td>
				<td>
					{if $payment->id!=1}
						<a class="topleftDir icon_sprite ico_delete ConfirmDelete" title="{#PaymentMethodDel#}" dir="{#PaymentMethodDel#}" name="{#PaymentMethodDelTitle#}" href="index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_payment_del&id={$payment->id}"></a>
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
        <h5>{#NewPaymentMethod#}</h5>
    </div>
<form method="post" action="index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_payment_new&cp={$sess}" class="mainForm">
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic" id="Fields">
		<tr>
			<td class="first">
				<input style="width:250px" type="text" name="payment_title" value="" placeholder="{#PaymentMethodName#}">&nbsp;<input type="submit" class="basicBtn" value="{#ButtonAdd#}" />
			</td>
		</tr>
	</table>
</form>
</div>