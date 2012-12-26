<div class="title"><h5>{#ModName#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#WelcomeText#}
    </div>
</div>

<div class="widgets">
			<!-- Left widgets -->
            <div class="left">

                <!-- Statistics -->
                <div class="widget">
                    <div class="head">
                        <h5>Вид оплаты</h5>
                        <div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_payment&cp={$sess}">{#ButtonEdit#}</a></div>
                    </div>
                    <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
						<col width="95%">
						<col width="5%">
                        <tbody>
						{foreach from=$payment item=payment}
                            <tr>
                                <td>{$payment->payment_title|stripslashes}</td>
                                <td align="center">{if $payment->payment_activ=='1'}<span class="icon_sprite ico_ok"></span>{else}<span class="icon_sprite ico_delete"></span>{/if}</td>
                            </tr>
						{/foreach}
                        </tbody>
                    </table>
                </div>

            </div>

            <!-- Right widgets -->
            <div class="right">

                <!-- User widget -->
                <div class="widget">
                    <div class="head">
                        <h5>{#DeliveryMethod#}</h5>
                        <div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_delivery&cp={$sess}">{#ButtonEdit#}</a></div>
                    </div>
                    <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
						<col width="95%">
						<col width="5%">
                        <tbody>
						{foreach from=$delivery item=delivery}
                            <tr>
                                <td>{$delivery->delivery_title|stripslashes}</td>
                                <td align="center">{if $delivery->delivery_activ=='1'}<span class="icon_sprite ico_ok"></span>{else}<span class="icon_sprite ico_delete"></span>{/if}</td>
                            </tr>
						{/foreach}
                        </tbody>
                    </table>
                </div>

            </div>

	<div class="fix"></div>

</div>