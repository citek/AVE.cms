<?php

/**
 * Класс работы с Корзиной
 *
 * @package AVE.cms
 * @subpackage module_Basket
 * @filesource
 */
class ModulBasket
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

	/**
	 * Получить список товаров в корзине
	 *
	 */
	function getBasket()
	{
		global $AVE_DB;

		$sql = $AVE_DB->Query("
			SELECT
				b.basket_product_id AS id,
				f.field_value AS name,
				d.field_value AS article,
				e.field_value AS size,
				b.basket_product_quantity AS quantity,
				b.basket_product_amount AS amount
			FROM
				" . PREFIX . "_modul_basket AS b
			LEFT JOIN
				" . PREFIX . "_document_fields AS f
					ON f.Id = b.basket_product_name_id
			LEFT JOIN
				" . PREFIX . "_document_fields AS d		
					ON d.Id = b.basket_product_article_id
			LEFT JOIN
				" . PREFIX . "_document_fields AS e		
					ON e.Id = b.basket_product_size_id
			WHERE b.basket_session_id = '" . session_id() . "'
			ORDER BY b.id ASC
		");

		$total = 0;
		$total_send = 0;
		
		$products = array();
		while($row = $sql->FetchRow())
		{
			$total += $row->amount;
			$total_send += $row->amount;
			$quantity += $row->quantity;
			$row->price = $row->amount / $row->quantity;
			array_push($products, $row);
		}

		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_basket_delivery
			WHERE delivery_activ = '1'
			ORDER BY delivery_position ASC
		");
		
		$delivery = array();
		while($row = $sql->FetchRow())
		{
			array_push($delivery, $row);
		}

		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_basket_payment
			WHERE payment_activ = '1'
			ORDER BY payment_position ASC
		");
		
		$payment = array();
		while ($row = $sql->FetchRow())
		{
			$payment_delivery = explode(',', $row->payment_delivery);
			if (in_array($_SESSION['delivery_id'], $payment_delivery)) array_push($payment, $row);
		}

		if (isset($_SESSION['delivery_id'])) {
			$row = $AVE_DB->Query("
			SELECT
				delivery_price,
				delivery_price_operands
			FROM " . PREFIX . "_modul_basket_delivery
			WHERE id = ".$_SESSION['delivery_id']." AND delivery_activ = '1'
			LIMIT 1
			")
			->FetchRow();
			
				if ($row->delivery_price_operands == "Money"){
					
					$total = $total + $row->delivery_price;
					
					}else if ($row->delivery_price_operands == "%"){
					
					$total = ($row->deliveryt_price_operands == '%') ? $total+$total/100*$row->delivery_price : $total - $row->delivery_price;
					
				}
			
			$total = $total + $delivery_price;
			
		 if  (isset($_SESSION['payment_id'])){
			$row = $AVE_DB->Query("
			SELECT
				payment_price,
				payment_price_operands
			FROM " . PREFIX . "_modul_basket_payment
			WHERE id = ".$_SESSION['payment_id']." AND payment_activ = '1'
			LIMIT 1
			")
			->FetchRow();
			
				if ($row->payment_price_operands == "Money"){
					
					$total = $total + $row->payment_price;
					
					}else if ($row->payment_price_operands == "%"){
					
					$total = ($row->payment_price_operands == '%') ? $total+$total/100*$row->payment_price : $total - $row->payment_price;
					
				}
			}
		}
		return array('products' => $products, 'total' => $total, 'delivery' => $delivery, 'payment' => $payment, 'total_cart' => $total_cart, 'total_send' => $total_send, 'quantity' => $quantity);
	}

	/**
	 * Добавить товар в корзину
	 *
	 * @param int $product_id	идентификатор товара
	 * 							(идентификатор документа с атрибутами товара)
	 * @param int $name_id		идентификатор наименования товара
	 * 							(идентификатор поля рубрики для наименования)
	 * @param int $price_id		идентификатор цены товара
	 * 							(идентификатор поля рубрики для цены)
	 * @param int $article_id	идентификатор артикула товара
	 * 							(идентификатор поля рубрики для артикула)
	 * @param int $size_id	    идентификатор размера товара
	 * 							(идентификатор поля рубрики для размера)
	 * @param int $quantity		количество добавляемых в корзину товаров
	 */

	function basketProductAdd($product_id = 0, $name_id = 0, $price_id = 0, $article_id = 0, $size_id = 0, $quantity = 1)
	{
		global $AVE_DB;

		$product_id	= (int)$product_id;
		$name_id	= (int)$name_id;
		$price_id	= (int)$price_id;
		$article_id	= (int)$article_id;
		$size_id	= (int)$size_id;
		$quantity	= (int)$quantity;

		if ($product_id === 0 || $name_id === 0 || $price_id === 0 || $article_id === 0 || $size_id === 0 || $quantity === 0) return;

		$session_id	= session_id();

		$sql = $AVE_DB->Query("
			SELECT
				Id,
				rubric_field_id,
				field_value
			FROM " . PREFIX . "_document_fields
			WHERE document_id = '" . $product_id . "'
			AND (rubric_field_id = '" . $name_id . "' OR rubric_field_id = '" . $price_id . "' OR rubric_field_id = '" . $article_id . "' OR rubric_field_id = '" . $size_id . "')
		");

		$product = array();
		while ($row = $sql->FetchRow())
		{
			$product[$row->rubric_field_id] = array('id'  => $row->Id,
													'val' => $row->field_value);
		}

		if (!empty($product))
		{
			$exists = $AVE_DB->Query("
				SELECT 1
				FROM " . PREFIX . "_modul_basket
				WHERE basket_product_id = '" . $product_id . "'
				AND basket_session_id   = '" . $session_id . "'
			")->GetCell();

			if ($exists)
			{
				$AVE_DB->Query("
					UPDATE " . PREFIX . "_modul_basket
					SET
						basket_product_quantity = basket_product_quantity + " . $quantity . ",
						basket_product_amount   = basket_product_amount + " . $quantity * $product[$price_id]['val'] . "
					WHERE basket_product_id = '" . $product_id . "'
					AND basket_session_id   = '" . $session_id . "'
				");
			}
			else
			{
				$AVE_DB->Query("
					INSERT
					INTO " . PREFIX . "_modul_basket
					SET
						basket_session_id       = '" . $session_id . "',
						basket_product_id       = '" . $product_id . "',
						basket_product_name_id  = '" . $product[$name_id]['id'] . "',
						basket_product_price_id = '" . $product[$price_id]['id'] . "',
						basket_product_article_id = '" . $product[$article_id]['id'] . "',
						basket_product_size_id    = '" . $product[$size_id]['id'] . "',
						basket_product_quantity = '" . $quantity . "',
						basket_product_amount   = '" . $quantity * $product[$price_id]['val'] . "'
				");
			}
		}
	}

	/**
	 * Удалить товар из корзины
	 *
	 * @param int $product_id
	 */
	function basketProductDelete($product_id)
	{
		global $AVE_DB;

		$AVE_DB->Query("
			DELETE
			FROM " . PREFIX . "_modul_basket
			WHERE basket_product_id = '" . (int)$product_id . "'
			AND basket_session_id = '" . session_id() . "'
		");
	}

	/**
	 * Пересчет корзины
	 *
	 * @param array $quantity
	 * @param array $delete
	 */
	function basketOrderUpdate($quantity = array(), $delete = array(), $delivery_id, $payment_id)
	{
		global $AVE_DB;

		unset ($_SESSION['delivery_id']);
		unset ($_SESSION['payment_id']);

		if (!(isset($delete) && is_array($delete))) $delete = array();
		
		$session_id = session_id();
		
		if (isset($delivery_id) && !isset($payment_id)){
			$_SESSION['delivery_id'] = $delivery_id;
		}else if (isset($delivery_id) && isset($payment_id)){
			$_SESSION['delivery_id'] = $delivery_id;
			$_SESSION['payment_id'] = $payment_id;
		}

		// Изменяем в корзине количества товаров
		if (isset($quantity) && is_array($quantity))
		{
			foreach ($quantity as $product_id => $product_quantity)
			{
				$product_id = (int)$product_id;
				if (!is_numeric($product_quantity)) continue;
				$product_quantity = (int)$product_quantity;
				// если количество равно 0 - удаляем товар из корзины
				if ($product_quantity === 0) $delete[$product_id] = 1;
				if (isset($delete[$product_id])) continue;

				$AVE_DB->Query("
					UPDATE " . PREFIX . "_modul_basket
					SET
						basket_product_amount = basket_product_amount / basket_product_quantity * " . $product_quantity . ",
						basket_product_quantity = '" . $product_quantity . "'
					WHERE basket_product_id = '" . $product_id . "'
					AND basket_session_id   = '" . $session_id . "'
				");
			}
		}

		// Удаляем помеченные товары
		foreach ($delete as $product_id => $val)
		{
			$AVE_DB->Query("
				DELETE
				FROM " . PREFIX . "_modul_basket
				WHERE basket_product_id = '" . (int)$product_id . "'
				AND basket_session_id = '" . $session_id . "'
			");
		}
	}


	/**
	 * Отправка заказа
	 *
	 */
	function basketOrderSend()
	{
		global $AVE_DB, $AVE_Template;

		$customer = array();

		$customer['name'] = isset($_REQUEST['name']) ? trim(stripslashes($_REQUEST['name'])) : '';
		if ($customer['name'] !== '') $customer['name'] = preg_replace('/[^\x20-\xFF]|[><]/', '', $customer['name']);

		$customer['email'] = isset($_REQUEST['email']) ? trim(stripslashes($_REQUEST['email'])) : '';
		if ($customer['email'] !== '')
		{
			$regex_email = '/^[\w.-]+@[a-z0-9.-]+\.(?:[a-z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum)$/i';
			if (!preg_match($regex_email, $customer['email'])) $customer['email'] = '';
		}

		$customer['phone'] = isset($_REQUEST['phone']) ? trim(stripslashes($_REQUEST['phone'])) : '';
		if ($customer['phone'] !== '') $customer['phone'] = preg_replace('/[^\x20-\xFF]|[><]/', '', $customer['phone']);

		$customer['address'] = isset($_REQUEST['address']) ? trim(stripslashes($_REQUEST['address'])) : '';
		if ($customer['address'] !== '') $customer['address'] = preg_replace('/[^\x20-\xFF]|[><]/', '', $customer['address']);

		$customer['description'] = isset($_REQUEST['description']) ? trim(stripslashes($_REQUEST['description'])) : '';
		if ($customer['description'] !== '') $customer['description'] = preg_replace('/[^\x20-\xFF]|[><]/', '', $customer['description']);

		$delivery_method = $AVE_DB->Query("
			SELECT delivery_price, delivery_title, delivery_price_operands
			FROM " . PREFIX . "_modul_basket_delivery
			WHERE id = ".$_SESSION['delivery_id']." AND delivery_activ = '1'
			LIMIT 1
		")->FetchRow();
		
		$delivery_method_titel = $delivery_method->delivery_title;
		$delivery_method_price = $delivery_method->delivery_price;
		$delivery_method_operands = $delivery_method->delivery_price_operands;
		
		$AVE_Template->assign('delivery_method_titel', $delivery_method_titel);
		$AVE_Template->assign('delivery_method_price', $delivery_method_price);
		$AVE_Template->assign('delivery_method_operands', $delivery_method_operands);

		$payment_method = $AVE_DB->Query("
			SELECT payment_price, payment_title, payment_price_operands
			FROM " . PREFIX . "_modul_basket_payment
			WHERE id = ".$_SESSION['payment_id']." AND payment_activ = '1'
			LIMIT 1
		")->FetchRow();
		$payment_method_titel = $payment_method->payment_title;
		$payment_method_price = $payment_method->payment_price;
		$payment_method_operands = $payment_method->payment_price_operands;
		
		$AVE_Template->assign('payment_method_titel', $payment_method_titel);
		$AVE_Template->assign('payment_method_price', $payment_method_price);
		$AVE_Template->assign('payment_method_operands', $payment_method_operands);

		// Передаем в шаблон информацию о заказчике
		$AVE_Template->assign('customer', $customer);

		// Формируем тело письма
		$mail_body = $AVE_Template->fetch(BASE_DIR . '/modules/basket/templates/mail_text.tpl');

		// Если заказчик указал E-mail - отправляем письмо заказчику
		if ($customer['email'])
		{
			send_mail(
				$customer['email'],
				$mail_body,
				$AVE_Template->get_config_vars('BASKET_SHOP_NAME') . ' '
					. $AVE_Template->get_config_vars('BASKET_ORDER_TITLE'),
				get_settings('mail_from'),
				$AVE_Template->get_config_vars('BASKET_SHOP_NAME'),
				'html'
			);
		}

		// Письмо администратору
		send_mail(
			get_settings('mail_from'),
			$mail_body,
			$AVE_Template->get_config_vars('BASKET_SHOP_NAME') . ' '
				. $AVE_Template->get_config_vars('BASKET_ORDER_TITLE'),
			get_settings('mail_from'),
			$AVE_Template->get_config_vars('BASKET_SHOP_NAME'),
			'html'
		);

		// Удаляем заказ из корзины
		$AVE_DB->Query("
			DELETE
			FROM " . PREFIX . "_modul_basket
			WHERE basket_session_id = '" . session_id() . "'
		");
	}
}

?>