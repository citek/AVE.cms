<?php

/**
 * AVE.cms - Модуль Корзина
 *
 * @package AVE.cms
 * @subpackage module_Basket
 * @filesource
 */

/**
 * mySQL-запросы для установки, обновления и удаления модуля
 */

$modul_sql_install = array();
$modul_sql_deinstall = array();
$modul_sql_update = array();

$modul_sql_deinstall[] = "DROP TABLE IF EXISTS `CPPREFIX_modul_basket`;";
$modul_sql_deinstall[] = "DROP TABLE IF EXISTS `CPPREFIX_modul_basket_payment`;";
$modul_sql_deinstall[] = "DROP TABLE IF EXISTS `CPPREFIX_modul_basket_delivery`;";
$modul_sql_deinstall[] = "DROP TABLE IF EXISTS `CPPREFIX_modul_basket_processing`;";

//Основная таблица
$modul_sql_install[] = "CREATE TABLE `CPPREFIX_modul_basket` (
  `id` int(11) NOT NULL auto_increment,
  `basket_session_id` varchar(50) default NULL,
  `basket_product_id` int(11) default NULL,
  `basket_product_name_id` int(11) default NULL,
  `basket_product_price_id` int(11) default NULL,
  `basket_product_article_id` int(22) default NULL,
  `basket_product_size_id` int(22) default NULL,
  `basket_product_quantity` smallint(5) default NULL,
  `basket_product_amount` float(10,2) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";

//Метод оплаты
$modul_sql_install[] = "CREATE TABLE `CPPREFIX_modul_basket_payment` (
  `id` int(11) NOT NULL auto_increment,
  `payment_title` varchar(255) NOT NULL,
  `payment_price` text NOT NULL,
  `payment_price_operands` enum('Money','%','Text') NOT NULL default 'Money',
  `payment_description` text default NULL,
  `payment_delivery` tinytext default NULL,
  `payment_activ` tinyint(1) unsigned NOT NULL default '0',
  `payment_position` tinyint(2) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";

//Выбор доставки
$modul_sql_install[] = "CREATE TABLE `CPPREFIX_modul_basket_delivery` (
  `id` int(11) NOT NULL auto_increment,
  `delivery_title` varchar(255) NOT NULL,
  `delivery_price` text NOT NULL,
  `delivery_price_operands` enum('Money','%','Text') NOT NULL default 'Money',
  `delivery_description` text default NULL,
  `delivery_activ` tinyint(1) unsigned NOT NULL default '0',
  `delivery_position` tinyint(2) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";


//Тестовые данные
$modul_sql_install[] = "INSERT INTO `CPPREFIX_modul_basket_delivery` VALUES ('1', 'Курьером по москве', '0', 'Money', '', '1', '1');";
$modul_sql_install[] = "INSERT INTO `CPPREFIX_modul_basket_delivery` VALUES ('2', 'Курьером в подмосковье', '0', 'Money', '', '1', '2');";
$modul_sql_install[] = "INSERT INTO `CPPREFIX_modul_basket_delivery` VALUES ('3', 'Почта России', '0', 'Money', '', '1', '3');";
$modul_sql_install[] = "INSERT INTO `CPPREFIX_modul_basket_delivery` VALUES ('4', 'Самовывоз', '0', 'Money', '', '1', '4');";


$modul_sql_install[] = "INSERT INTO `CPPREFIX_modul_basket_payment` VALUES (1, 'Наличными курьеру', 'Отдать бабло Курьеру', 'Text', 'Наличные при получении (по Москве) - оплата осуществляется наличными деньгами курьеру в момент доставки. После комплектации заказа наш менеджер свяжется с Вами по контактному телефону и еще раз уточнит параметры заказа и Ваш адрес. Если Вы, подтвердив заказ, в дальнейшем отказываетесь от его получения, то Вам необходимо оплатить стоимость доставки + 50 руб за каждую возвращенную позицию. В случае необходимости возврата или обмена изделия свяжитесь с нашим менеджером.', '1,2', 1, 1);";

$modul_sql_install[] = "INSERT INTO `CPPREFIX_modul_basket_payment` VALUES (2, 'Наличными в офисе', '0.00', 'Money', 'Наличные при получении  - оплата осуществляется наличными деньгами в офисе компании. После комплектации заказа наш менеджер свяжется с Вами по контактному телефону и еще раз уточнит параметры заказа. Если Вы, подтвердив заказ, в дальнейшем отказываетесь от его получения, то Вам необходимо оплатить стоимость доставки + 50 руб за каждую возвращенную позицию. В случае необходимости возврата или обмена изделия свяжитесь с нашим менеджером.', '4', 1, 2);";

$modul_sql_install[] = "INSERT INTO `CPPREFIX_modul_basket_payment` VALUES (3, 'Безналичная оплата', '10.00', '%', 'Банковский платеж - после оформления заказа Вы сразу же можете распечатать квитанцию для оплаты через банк. Большая просьба - после осуществления перевода сразу уведомить нас об отправке денег по адресу e-mail. Мы сформируем и отправим Ваш заказ в течение 3-5 рабочих дней с момента поступления денег на наш расчетный счет. Если заказанного товара не окажется на складе, наш менеджер обязательно свяжется с Вами для разрешения возникшей ситуации.', '3,4', 1, 3);";


$modul_sql_update[] = "UPDATE CPPREFIX_module SET CpEngineTag = '" . $modul['CpEngineTag'] . "', CpPHPTag = '" . $modul['CpPHPTag'] . "', Version = '" . $modul['ModulVersion'] . "' WHERE ModulPfad = 'basket' LIMIT 1;";
?>