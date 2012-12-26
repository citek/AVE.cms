{oBasket->getBasket assign='basket'}

{if $basket.products}
<div id="basket-order" class="tablebox">

<table class="progress" width="100%" border="0" cellpadding="0" cellspacing="0">
	<col width="38"><col width="195">
	<col width="38"><col width="195">
	<col width="38"><col width="195">
	<tr>
		<th class="active">1</th><td class="active">{#BASKET_PROGRESSBAR_STEP1#}</td>
		<th>2</th><td>{#BASKET_PROGRESSBAR_STEP2#}</td>
		<th>3</th><td>{#BASKET_PROGRESSBAR_STEP3#}</td>
	</tr>
</table>

<p><em>{#BASKET_ORDER_SHOW_TIP#}</em></p>

<form method="get" action="index.php">
	<input type="hidden" name="module" value="basket" />
	<input type="hidden" name="action" value="update" />

	<table width="100%" border="1" cellpadding="0" cellspacing="0">
		<colgroup>
			<col width="80">
			<col>
			<col width="80">
			<col width="80">
			<col width="80">
			<col width="80">
			<col width="80">
		</colgroup>

		<thead>
			<tr>
				<th>{#BASKET_PRODUCT_DELETE#}</th>
				<th>{#BASKET_PRODUCT_NAME#}</th>
                <th>{#BASKET_PRODUCT_SIZE#}</th>
                <th>{#BASKET_PRODUCT_ARTICLE#}</th>
				<th>{#BASKET_PRODUCT_QUANTITY#}</th>
				<th>{#BASKET_PRODUCT_PRICE#}</th>
				<th>{#BASKET_PRODUCT_AMOUNT#}</th>
			</tr>
		</thead>

		<tbody>
			{foreach from=$basket.products item=product}
				<tr>
					<td align="center"><input type="checkbox" name="product_delete[{$product->id}]" value="1" /></td>
					<td align="left">{$product->name|escape}</td>
                    <td align="left">{$product->size|escape}</td>
                    <td align="center">{$product->article|escape}</td>
					<td align="center"><input type="text" name="product_quantity[{$product->id}]" size="1" maxlength="2" value="{$product->quantity}" /></td>
					<td align="right">{$product->price|string_format:"%.2f"}</td>
					<td align="right">{$product->amount|string_format:"%.2f"}</td>
				</tr>
			{/foreach}
		</tbody>
	</table>

<br /><br />

<table width="100%" border="1" cellpadding="0" cellspacing="0">
<thead>
	<tr>
		<th colspan="4" class="table-head">Пожалуйста, выберите желаемый вид доставки</th>
	</tr>
</thead>
<tbody>
	<tr>
		<th width="5">&nbsp;</th>
		<th width="250" align="left">Вид доставки</th>
		<th width="150" align="left">Стоимость доставки</th>
		<th align="left">Описание</th>
	</tr>
{foreach from=$basket.delivery item=delivery}
	<tr>
		<td><input style="cursor:pointer" type="radio" name="delivery_id" value="{$delivery->id|escape}" {if $delivery->id|escape==$smarty.session.delivery_id}checked{/if}></td>
		<td><strong>{$delivery->delivery_title|escape}</strong></td>
		<td><strong>
		
		{if $delivery->delivery_price_operands|escape == '%'}{$delivery->delivery_price}%
		
		{elseif $delivery->delivery_price_operands|escape == 'Money'}
		
		{if $delivery->delivery_price|escape == 0 || $delivery->delivery_price=='0.00'}Бесплатно{else}{num_format val=$delivery->delivery_price|string_format:"%.2f"} руб.{/if}
		
		{elseif $delivery->delivery_price_operands|escape == 'Text'}{$delivery->delivery_price|escape}{/if}
		
		</strong></td>
		<td><a class="tooltip" title="" href="javascript:void(0);">Подробнее</a></td>
	</tr>
{/foreach}
</tbody>
</table>

{if $smarty.session.delivery_id}
<br /><br />
<table width="100%" border="1" cellpadding="0" cellspacing="0">
<thead>
	<tr>
		<th colspan="4" class="table-head">Выбор метода платежа</th>
	</tr>
</thead>
<tbody>
	<tr>
		<th width="5">&nbsp;</th>
		<th width="250" align="left">Метод оплаты</th>
		<th width="150" align="left">Стоимость</th>
		<th align="left">Описание</th>
	</tr>
{foreach from=$basket.payment item=payment}
	<tr>
		<td><input style="cursor:pointer" type="radio" name="payment_id" value="{$payment->id|escape}" {if $payment->id|escape==$smarty.session.payment_id}checked{/if}></td>
		<td><strong>{$payment->payment_title|escape}</strong></td>
		<td><strong>
		
		{if $payment->payment_price_operands|escape == '%'}{$payment->payment_price}%
		
		{elseif $payment->payment_price_operands|escape == 'Money'}
		
		{if $payment->payment_price|escape == 0 || $payment->payment_price=='0.00'}Бесплатно{else}{num_format val=$payment->payment_price|string_format:"%.2f"} руб.{/if}
		
		{elseif $payment->payment_price_operands|escape == 'Text'}{$payment->payment_price|escape}{/if}

		</strong></td>
		<td><a class="tooltip" title="" href="javascript:void(0);">Подробнее</a></td>
	</tr>
{/foreach}
</tbody>
</table>
{/if}

<br /><br />
<table width="100%" border="1" cellpadding="0" cellspacing="0">
<thead>
	<tr>
		<th colspan="5" class="table-head">Итого</th>
	</tr>
</thead>


		<tfoot>
			<tr>
				<th colspan="7" align="right">
					<span class="ajax-loader" style="display:none;"><img src="{$ABS_PATH}templates/{$smarty.const.THEME_FOLDER}/images/loader-12.gif"></span>{$basket.total|string_format:"%.2f"}
				</th>
			</tr>
		</tfoot>

</table>

<br /><br />
<input type="submit" class="button" value="{#BASKET_UPDATE#}" style="float:left;" />
<br /><br />

{if $smarty.session.delivery_id && $smarty.session.payment_id}
<a href="index.php?module=basket&action=form">{#BASKET_NEXT#}</a>
{/if}

</form>

{literal}
<script type="text/javascript">
$(document).ready(function() {
	$("#basket-order form").submit(function() {
		$(this).ajaxSubmit({
			type: "post",
			beforeSubmit: function(formData, jqForm) {
				$("#basket-order .ajax-loader").show();
			},
			success: function(response) {
				$("#basket-order").before(response).remove();
			}
		});
		return false;
	});

	$("input:radio[name=delivery_id]").click(function() {
		$("#basket-order form").unbind("submit").ajaxSubmit({
			type: "post",
			data: {delivery: '1', payment: '0'},
			beforeSubmit: function(formData, jqForm) {
				$("#basket-order .ajax-loader").show();
			},
			success: function(response) {
				$("#basket-order").before(response).remove();
			}
		});
		return false;
	});
	
	$("input:radio[name=payment_id]").click(function() {
		$("#basket-order form").unbind("submit").ajaxSubmit({
			type: "post",
			data: {delivery: '1', payment: '1'},
			beforeSubmit: function(formData, jqForm) {
				$("#basket-order .ajax-loader").show();
			},
			success: function(response) {
				$("#basket-order").before(response).remove();
			}
		});
		return false;
	});
});
</script>
{/literal}

</div>
{else}
	<h2 id="page-heading">{#BASKET_EMPTY#}</h2>
{/if}