<?php

/**
 * Класс работы с Корзиной
 *
 * @package AVE.cms
 * @subpackage module_Basket
 * @filesource
 */
class ModulBasketAdmin
{

/**
 *	СВОЙСТВА
 */

/**
 *	ВНУТРЕННИЕ МЕТОДЫ
 */

/**
 *	ВНЕШНИЕ МЕТОДЫ
 */


///////////
// Старт //
///////////
	function basketStart($tpl_dir)
	{
		global $AVE_DB, $AVE_Template, $AVE_Globals;

		$home = true;

		$payment = array();
		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_basket_payment
			ORDER BY payment_position ASC
		");
		while ($row = $sql->FetchRow()) array_push($payment,$row);

		$delivery = array();
		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_basket_delivery
			ORDER BY delivery_position ASC
		");
		while ($row = $sql->FetchRow()) array_push($delivery,$row);

		if ($home == true){
			$AVE_Template->assign('payment', $payment);
			$AVE_Template->assign('delivery', $delivery);
			$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'basket_start.tpl'));
		}
	}

////////////////
// Вид оплаты //
////////////////

	function basketDelPaymentMethod($id)
	{
		global $AVE_DB;

		if ($id != 1)
		{
			$AVE_DB->Query("
				DELETE
				FROM " . PREFIX . "_modul_basket_payment
				WHERE id = '" . $id . "'
			");
		}

		header("Location:index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_payment&cp=" . SESSION);
		exit;
	}

	function basketNewPaymentMethod()
	{
		global $AVE_DB;

		$AVE_DB->Query("
			INSERT " . PREFIX . "_modul_basket_payment
			SET payment_title = '" . $_POST['payment_title'] . "'
		");

		header("Location:index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_payment&cp=" . SESSION);
		exit;
	}

	function basketDisplayMethods()
	{
		global $AVE_DB;

		$methods = array();
		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_basket_payment
			ORDER BY payment_position ASC
		");
		while ($row = $sql->FetchRow()) array_push($methods,$row);

		return $methods;
	}

	function basketPaymentMethods($tpl_dir)
	{
		global $AVE_DB, $AVE_Template;

		if (isset($_REQUEST['sub']) && $_REQUEST['sub'] == 'save')
		{
			foreach ($_POST['payment_title'] as $id => $payment_title)
			{
				if (!empty($payment_title))
				{
					$AVE_DB->Query("
						UPDATE " . PREFIX . "_modul_basket_payment
						SET
							payment_title     = '" . $payment_title . "',
							payment_activ   = '" . $_POST['payment_activ'][$id] . "',
							payment_position = '" . $_POST['payment_position'][$id] . "'
						WHERE
							id = '" . $id . "'
					");
				}
			}
		}

		$AVE_Template->assign('methods', $this->basketDisplayMethods());
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'basket_payment.tpl'));
	}


	function basketEditPaymentMethod($tpl_dir,$id)
	{
		global $AVE_DB, $AVE_Template;

		if (isset($_REQUEST['sub']) && $_REQUEST['sub'] == 'save')
		{
			$AVE_DB->Query("
				UPDATE " . PREFIX . "_modul_basket_payment
				SET
					payment_title = '" . $_POST['payment_title'] . "',
					payment_description = '" . $_POST['payment_description'] . "',
					payment_activ = '" . $_POST['payment_activ'] . "',
					payment_price = '" . $_POST['payment_price'] . "',
					payment_price_operands = '" . $_POST['payment_price_operands'] . "',
					payment_delivery   = '" . ((isset($_POST['payment_delivery']) && is_array($_POST['payment_delivery'])) ? implode(',', $_POST['payment_delivery']) : '') . "'
				WHERE
					id = '" . $_REQUEST['id'] . "'
			");

			echo '<script>window.opener.location.reload(); window.close();</script>';
		}

		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_basket_payment
			WHERE id = '" . $id . "'
		");
		
		$row = $sql->FetchRow();
		$row->payment_delivery = explode(',', $row->payment_delivery);

		$oFCKeditor = new FCKeditor('payment_description') ;
		$oFCKeditor->Height = '200';
		$oFCKeditor->ToolbarSet = 'Basic';
		$oFCKeditor->Value	= $row->payment_description;
		$Edi = $oFCKeditor->Create();

		$AVE_Template->assign('Edi', $Edi);
		$AVE_Template->assign('basket_delivery', $this->basketDisplayDelivery());
		$AVE_Template->assign('payment', $row);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'basket_payment_edit.tpl'));
	}

	function basketDisplayDelivery()
	{
		global $AVE_DB;

		$basket_delivery = array();
		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_basket_delivery
			ORDER BY delivery_position ASC
		");
		while ($row = $sql->FetchRow()) array_push($basket_delivery,$row);

		return $basket_delivery;
	}




//------------------------------------------------------
	function basketDeliveryMethods($tpl_dir)
	{
		global $AVE_DB, $AVE_Template;

		if (isset($_REQUEST['sub']) && $_REQUEST['sub'] == 'save')
		{
			foreach ($_POST['delivery_title'] as $id => $delivery_title)
			{
				if (!empty($delivery_title))
				{
					$AVE_DB->Query("
						UPDATE " . PREFIX . "_modul_basket_delivery
						SET
							delivery_title     = '" . $delivery_title . "',
							delivery_activ   = '" . $_POST['delivery_activ'][$id] . "',
							delivery_position = '" . $_POST['delivery_position'][$id] . "'
						WHERE
							id = '" . $id . "'
					");
				}
			}
		}

		$AVE_Template->assign('methods', $this->basketDisplayDelivery());
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'basket_delivery.tpl'));
	}

	function basketNewDeliveryMethod()
	{
		global $AVE_DB;

		$AVE_DB->Query("
			INSERT " . PREFIX . "_modul_basket_delivery
			SET delivery_title = '" . $_POST['delivery_title'] . "'
		");

		header("Location:index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_delivery&cp=" . SESSION);
		exit;
	}

	function basketDelDeliveryMethod($id)
	{
		global $AVE_DB;

		if ($id != 1)
		{
			$AVE_DB->Query("
				DELETE
				FROM " . PREFIX . "_modul_basket_delivery
				WHERE id = '" . $id . "'
			");
		}
		header("Location:index.php?do=modules&action=modedit&mod=basket&moduleaction=basket_delivery&cp=" . SESSION);
		exit;
	}

	function basketEditDeliveryMethod($tpl_dir,$id)
	{
		global $AVE_DB, $AVE_Template;

		if (isset($_REQUEST['sub']) && $_REQUEST['sub'] == 'save')
		{
			$AVE_DB->Query("
				UPDATE " . PREFIX . "_modul_basket_delivery
				SET
					delivery_title = '" . $_POST['delivery_title'] . "',
					delivery_description = '" . $_POST['delivery_description'] . "',
					delivery_activ = '" . $_POST['delivery_activ'] . "',
					delivery_price = '" . $_POST['delivery_price'] . "',
					delivery_price_operands = '" . $_POST['delivery_price_operands'] . "'
				WHERE
					id = '" . $_REQUEST['id'] . "'
			");

			echo '<script>window.opener.location.reload(); window.close();</script>';
		}
		
		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_basket_delivery
			WHERE id = '" . $id . "'
		");

		$row = $sql->FetchRow();

		$oFCKeditor = new FCKeditor('delivery_description') ;
		$oFCKeditor->Height = '200';
		$oFCKeditor->ToolbarSet = 'Basic';
		$oFCKeditor->Value	= $row->delivery_description;
		$Edi = $oFCKeditor->Create();

		$AVE_Template->assign('Edi', $Edi);
		$AVE_Template->assign('delivery', $row);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'basket_delivery_edit.tpl'));
	}



}
/**
 */
?>