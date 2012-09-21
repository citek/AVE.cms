<?php

/**
 * Класс работы с рассылками
 *
 * @package AVE.cms
 * @subpackage module_mailer
 * @author Arcanum, val005
 * @filesource
 */
class mailer
{
/**
 *	Внутренние методы класса
 */
	/**
	 * Метод проверки на синтаксис и уникальность e-mail-а внутри списка рассылки
	 *
	 * @param string $email	e-mail
	 * @return int
	 *    0:неверный синтаксис или пустой запрос
	 *    1:всё отлично
	 *    2:email уже есть в базе
	*/
	function _mailerCheckEmail($email="",$list_id=null)
	{
		$email = trim($email);

		if (!$email || !preg_match("/^[^ <>@,\\\\\/]+@[^ <>@,\\\\\/]+\.[^ <>@,\\\\\/]+$/i",$email))
		{
			return 0;
			exit;
		}

		$list_id = (int)trim($list_id);
		if ($list_id)
		{
			global $AVE_DB;
			$check = (int)$AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_mailer_receivers
				WHERE email = '" . $email . "' AND list_id=" . $list_id
			)->NumRows();
			return (($check==0) ? 1 : 2);
		}
		else return 1;
	}

	/**
	 * Метод сохранения вложений
	 *
	 * @return array $attach	массив путей к файлам
	 */
	function _mailerFileUpload()
	{
		if ($_FILES["attach"]) $files = $_FILES["attach"];
		else return false;

	//	$maxsize = 5000 * 1024;// 5mb
		$attach = array();
		$attach_dir = BASE_DIR . "/" . ATTACH_DIR . "/";

		foreach ($files['tmp_name'] as $i => $file)
		{
			if ($file)
			{
				if ($maxsize && filesize($file) > $maxsize) continue;
				
				$file_name = str_replace(" ","",mb_strtolower(trim($files['name'][$i])));
				if (file_exists($attach_dir . $file_name))
				{
					$file_name = rand(1000, 9999) . "_" . $file_name;
				}
				$file_path = BASE_DIR . "/" . ATTACH_DIR . "/" . $file_name;
				@move_uploaded_file($file, $file_path);
				$attach[] = $file_path;
			}
		}
		return $attach;
	}

	/**
	 * Метод получения прикреплённого файла
	 *
	 * @param string $file	имя файла
	 */
	function _mailerGetFile()
	{
		$file = $_REQUEST["file"];
		if ($_REQUEST["check"])
		{
			if (file_exists($file)) echo 1;
			else echo basename($file) . ";" . str_replace("/","/ ",$file);
		}
		elseif (file_exists($file))
		{
			@ob_start();
			header("Pragma: public");
			header("Expires: 0");
			header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
			header("Cache-Control: private",false);
			header("Content-Type: application/octet-stream");
			header("Content-Disposition: attachment; filename=" . basename($file));
			header("Content-Transfer-Encoding: binary");
			header("Content-Length: " . @filesize($file));
			@set_time_limit(0);
			@readfile($file);
		}
		exit;
	}

/**
 *	Внешние методы класса
 */

	/**
	 * Вывод списка рассылок
	 *
	 * @param string $tpl_dir	путь к директории с шаблонами модуля
	 */
	function mailerShowMails($tpl_dir)
	{
		global $AVE_DB, $AVE_Template;

		$limit = 20;
		$num = $AVE_DB->Query("
			SELECT COUNT(*)
			FROM " . PREFIX . "_modul_mailer_mails
			WHERE sent='1'
			ORDER BY date DESC
		")->GetCell();
		$pages = @ceil($num / $limit);
		$start = get_current_page() * $limit - $limit;

		if ($_POST["search"])
		{
			$AVE_Template->assign('search', $_POST["search"]);
			$AVE_Template->assign('search_words', $_POST["search_words"]);
			foreach ($_POST["search"] as $field => $true)
			{
				if ($true) $where[] = $field .  " LIKE '%" . $_POST["search_words"] . "%'";
			}
			$where = implode(" OR ",$where);
			$mails_var = array("tpl","sent","find");
		}
		else $mails_var = array("tpl","sent");

		// Создаём три переменные с письмами
		foreach ($mails_var as $mail_var)
		{
			switch ($mail_var)
			{
				case "tpl":
					$sql = $AVE_DB->Query("
						SELECT *
						FROM " . PREFIX . "_modul_mailer_mails
						WHERE sent='0'
						ORDER BY id DESC
					");
					break;

				case "sent":
					$sql = $AVE_DB->Query("
						SELECT *
						FROM " . PREFIX . "_modul_mailer_mails
						WHERE sent='1'
						ORDER BY date DESC
					");
					break;

				case "find":
					$sql = $AVE_DB->Query("
						SELECT *
						FROM " . PREFIX . "_modul_mailer_mails
						WHERE sent='1' AND (" . $where . ")
					");
					break;
			}

			while ($row = $sql->FetchRow())
			{
				$row -> body = "";
				$s = $AVE_DB->Query("
					SELECT user_group_name
					FROM " . PREFIX . "_user_groups
					WHERE user_group = " . implode(' OR user_group = ', explode(';', $row->to_groups))
				);
				$e = array();
				while ($r = $s->FetchRow())
				{
					array_push($e, $r);
				}
				$row->to_groups = $e;
		
				$s = $AVE_DB->Query("
					SELECT id, title
					FROM " . PREFIX . "_modul_mailer_lists
					WHERE id = " . implode(' OR id = ', explode(';', $row->to_lists))
				);
				$e = array();
				while ($r = $s->FetchRow())
				{
					array_push($e, $r);
				}
				$row->to_lists = $e;
		
				if ($row->to_add) $row->to_add = explode(";",$row->to_add);

				$attach = explode(";",$row->attach);
				$row->attach = array();
				foreach ($attach as $attachment)
				{
					array_push($row->attach,array("name" => basename($attachment),"path"=>$attachment));
				}

				$row->author_name = get_username_by_id($row->author_id);
				$mails[$mail_var][] = $row;
			}
		}

		if ($num > $limit)
		{
			$page_nav = " <a class=\"pnav\" href=\"index.php?do=modules&action=modedit&mod=mailer&moduleaction=1&page={s}&cp=" . SESSION . "\">{t}</a> ";
			$page_nav = get_pagination($pages, 'page', $page_nav);
			$AVE_Template->assign('page_nav', $page_nav);
		}
		$AVE_Template->assign('mails', $mails);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_show_mails.tpl'));
	}

	/**
	 * Метод создания новой рассылки
	 *
	 * @param string $tpl_dir	путь к директории с шаблонами модуля
	 */
	function mailerEditMail($tpl_dir)
	{
		global $AVE_DB, $AVE_Template, $AVE_User;

		if (!$_REQUEST["id"] && !$_REQUEST["copy_id"])
		{
			$mail -> from_name = get_settings("mail_from_name");
			$mail -> from_email = get_settings("mail_from");
			$mail -> type = "text";
			$mail -> body = $AVE_Template->get_config_vars('MAILER_MAILS_TEXT_D') . "\r\n\r\n\r\n\r\n" . get_settings("mail_signature");
			$mail -> appeal = $AVE_Template->get_config_vars('MAILER_MAILS_APPEAL_D');
			$mail -> saveattach = 1;
		}
		else
		{
			$mail = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_mailer_mails
				WHERE id=" . (($_REQUEST["id"]) ? $_REQUEST["id"] : $_REQUEST["copy_id"])
			) -> FetchRow();
			
			if ($_REQUEST["copy_id"])
			{
				$mail->id = null;
				$mail->sent = 0;
			}
			$mail -> to_groups = explode(";",$mail -> to_groups);
			$mail -> to_lists = explode(";",$mail -> to_lists);
		}

		$mail -> site_name = get_settings("site_name");
		$mail -> usergroups = $AVE_User->userGroupListGet(2);
		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_mailer_lists
			ORDER BY id DESC
		");
		$lists = array();
		while ($row = $sql -> FetchRow())
		{
			$lists[$row->id] = $row->title;
		}
		$mail -> lists = $lists;

		$AVE_Template->assign('mail', $mail);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . "admin_edit_mail.tpl"));
	}

	/**
	 * Метод сохранения/удаления/подготовки к отправке рассылки
	 *
	 * @param string $tpl_dir	путь к директории с шаблонами модуля
	 */
	function mailerSaveMail($tpl_dir)
	{
		global $AVE_DB, $AVE_Template, $AVE_User;

		if ($_REQUEST["delete"] && $_REQUEST["id"])
		{
			$AVE_DB->Query("
				DELETE
				FROM " . PREFIX . "_modul_mailer_mails
				WHERE id=". $_REQUEST["id"]
			);
			header("Location:index.php?do=modules&action=modedit&mod=mailer&moduleaction=1&cp=" . SESSION);
			exit;
		}
		
		// записываем вложения
		$attach = array();
		if ($_REQUEST["send"]) $attach = $this->_mailerFileUpload();

		if (!$_REQUEST["id"])
		{
			$AVE_DB->Query("
				INSERT
				INTO " . PREFIX . "_modul_mailer_mails
				SET
					id			= '',
					author_id	= '" . (int)$_SESSION['user_id'] . "',
					date		= '" . time() . "',
					from_name	= '" . trim($_POST["from_name"]) . "',
					from_email	= '" . trim($_POST["from_email"]) . "',
					from_copy	= '" . $_POST["from_copy"] . "',
					to_groups	= '" . implode(";",$_POST["to_groups"]) . "',
					to_lists	= '" . implode(";",$_POST["to_lists"]) . "',
					to_add		= '" . $_POST["to_add"] . "',
					subject		= '" . trim($_POST["subject"]) . "',
					type		= '" . $_POST["type"] . "',
					appeal		= '" . trim($_POST["appeal"]) . "',
					body		= '" . trim($_POST["body"]) . "',
					saveattach	= '" . $_POST["saveattach"] . "',
					attach		= '" . @implode(";",$attach) . "'
			");
			$mail_id = $AVE_DB->Query("
				SELECT MAX(id) 
				FROM " . PREFIX . "_modul_mailer_mails"
			)->GetCell();
			//mysql_insert_id() ???
		}
		else
		{
			$mail_id = $_REQUEST["id"];
			$AVE_DB->Query("
				UPDATE " . PREFIX . "_modul_mailer_mails
				SET
					from_name	= '" . trim($_POST["from_name"]) . "',
					from_email	= '" . trim($_POST["from_email"]) . "',
					from_copy	= '" . $_POST["from_copy"] . "',
					to_groups	= '" . implode(";",$_POST["to_groups"]) . "',
					to_lists	= '" . implode(";",$_POST["to_lists"]) . "',
					to_add		= '" . $_POST["to_add"] . "',
					subject		= '" . trim($_POST["subject"]) . "',
					type		= '" . $_POST["type"] . "',
					appeal		= '" . trim($_POST["appeal"]) . "',
					body		= '" . trim($_POST["body"]) . "',
					saveattach	= '" . $_POST["saveattach"] . "',
					attach		= '" . @implode(";",$attach) . "'
				WHERE id=" . $mail_id
			);
		}
		
		// Отправляем письмо
		if ($_REQUEST["send"]) {

			// Сохраняем все данные в одну переменную
			unset($_SESSION["mailer"][$mail_id]);
			$mailer = $_POST;

			// номер рассылки
			$mailer["id"] = $mail_id;

			// сохраняем вложения
			$mailer["attach"] = $attach;

			// создаём массив получателей
			$mailer["receivers"] = array();
			$receivers = array();

			// получатели из списков
			$rec_lists = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_mailer_receivers
				WHERE list_id = " . implode(' OR list_id = ',$_POST["to_lists"])
			);
			while ($rec = $rec_lists->FetchRow())
			{
				if(!in_array($rec->email,$receivers) && (int)$rec->status == 1)
				{
					$rec -> id = "L" . $rec -> id;
					array_push($mailer["receivers"], $rec);
					array_push($receivers, $rec->email);
				}
			}

			// получатели из групп
			$rec_groups = $AVE_DB->Query("
				SELECT id,email,lastname,firstname,user_group
				FROM " . PREFIX . "_users
				WHERE user_group = " . implode(' OR user_group = ',$_POST["to_groups"])
			);
			while ($rec = $rec_groups->FetchRow())
			{
				if(!in_array($rec->email,$receivers))
				{
					$rec -> id = "G" . $rec -> id;
					array_push($mailer["receivers"], $rec);
					array_push($receivers, $rec->email);
				}
			}

			// дополнительные получатели
			$rec_add = explode(";",$mailer["to_add"]);
			foreach ($rec_add as $rec_add_num => $rec_add_1)
			{
				$rec_add_1 = trim($rec_add_1);
				if($rec_add_1 && !in_array($rec_add_1,$receivers) && $this->_mailerCheckEmail($rec_add_1) == 1)
				{
					$rec = array();
					$rec["id"] = "A" . $rec_add_num;
					$rec["email"] = $rec_add_1;
					$rec = array2object($rec);
					array_push($mailer["receivers"], $rec);
					array_push($receivers, $rec->email);
				}
			}

			// отправитель в копию, если просили
			if ($mailer["from_copy"] && !in_array($mailer["from_email"],$receivers))
			{
				$rec = array();
				$rec["id"] = "C" . $mailer["author_id"];
				$rec["email"] = trim($mailer["from_email"]);
				$rec = array2object($rec);
				array_push($mailer["receivers"], $rec);
			}
			
			// считаем получателей
			$mailer["number"] = count($mailer["receivers"]);
			$mailer["count"] = 1;
	
			// записываем все данные в сессию
			$_SESSION["mailer"][$mail_id] = $mailer;
		}
		
		// если это заявка на сохранить и продолжить и первое сохранение или отправка письма, возвращаем id
		if ($_REQUEST["return"] || $_REQUEST["send"])
		{
			echo $mail_id;
		}
		// или возвращаемся на базу)))
		else header("Location:index.php?do=modules&action=modedit&mod=mailer&moduleaction=1&cp=" . SESSION);

		exit;
	}

	/**
	 * Метод отправки рассылки
	 */
	function mailerSendMail() {
		global $AVE_DB;

		// получаем id рассылки
		$mail_id = $_REQUEST["mail_id"];
		
		// шлём письмо, используя данные сессии
		if ($_SESSION["mailer"][$mail_id]["count"] <= $_SESSION["mailer"][$mail_id]["number"])
		{
			//берём следующего получателя
			$rec = array_shift($_SESSION["mailer"][$mail_id]["receivers"]);

			// Уникальный id письма: %номер рассылки%-%id получателя%
			$id = $_SESSION["mailer"][$mail_id]["id"] . "-" . $rec -> id;
			
			// Обращение к получателю
			$name = trim($rec->lastname . " " . $rec->firstname . " " . $rec->middlename);
			if (!$name)
			{
				$name = $_SESSION["mailer"][$mail_id]["appeal"];
			}
			$body = str_replace("%NAME%",$name,$_SESSION["mailer"][$mail_id]["body"]);
			$body = str_replace("%ID%",$id,$body);
			$body = str_replace(
				"%REFUSE%",
				(($rec -> id{0} == "L") ? "http://" . $_SERVER['SERVER_NAME'] . "/index.php?module=mailer&action=refuse&id=" . substr($rec->id, 1) : ""),
				$body
			);

			// Посылаем письмо
			send_mail(
				$rec->email,
				$body,
				trim($_SESSION["mailer"][$mail_id]["subject"]),
				trim($_SESSION["mailer"][$mail_id]["from_email"]),
				trim($_SESSION["mailer"][$mail_id]["from_name"]),
				trim($_SESSION["mailer"][$mail_id]["type"]),
				$_SESSION["mailer"][$mail_id]["attach"],
				false
			);

			// записываем отправленных в базу, чтобы если что знать, кому уже отправились письма
			$_SESSION["mailer"][$mail_id]["done"][] = $rec->email;

			$AVE_DB->Query("
				UPDATE " . PREFIX . "_modul_mailer_mails
				SET
					done		= '" . implode(";",$_SESSION["mailer"][$mail_id]["done"]) . "',
					sent		= '1'
				WHERE id=" . $mail_id
			);

			// округлённый процент выполнения
			$procent = floor($_SESSION["mailer"][$mail_id]["count"]/$_SESSION["mailer"][$mail_id]["number"]*100);

			// считаем
			$_SESSION["mailer"][$mail_id]["count"]++;

			// возвращаем в AJAX число
			echo $procent;
		}
		else
		{
			// Удаяем вложения, если просили
			if ($_SESSION["mailer"][$mail_id]["attach"] && !(int)$_SESSION["mailer"][$mail_id]["saveattach"])
			{
				foreach ($_SESSION["mailer"][$mail_id]["attach"] as $file)
				{
					@unlink($file);
				}
			}
			// Записываем дату отправки письма
			$AVE_DB->Query("
				UPDATE " . PREFIX . "_modul_mailer_mails
				SET
					date		= '" . time() . "'
				WHERE id=" . $mail_id
			);
			unset ($_SESSION["mailer"][$mail_id]);
			echo "finish";
		}
		exit;
	}

	/**
	 * Метод отображения рассылки
	 *
	 * @param string $tpl_dir	путь к директории с шаблонами модуля
	 * @param int $id			идентификатор рассылки
	 * @param string $format	формат рассылаемых писем {text|html}
	 */
	function mailerShow($tpl_dir, $id, $format = 'text')
	{
		global $AVE_DB, $AVE_Template;

		$row = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_mailer
			WHERE id = '" . $id . "'
		")->FetchRow();

		if ($format=='html')
		{
			$AVE_Template->assign('Editor', $this->_mailerFckObjectCreate($row->mailer_message,'550','text','cpengine'));
		}

		$AVE_Template->assign('row', $row);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_show_text.tpl'));
	}

	/**
	 * Вывод списков рассылок
	 *
	 * @param string $tpl_dir	путь к директории с шаблонами модуля
	 */
	function mailerShowLists($tpl_dir)
	{
		global $AVE_DB, $AVE_Template;

		if ($_POST["del"])
		{
			foreach ($_POST['del'] as $id => $del)
			{
				$AVE_DB->Query("
					DELETE
					FROM " . PREFIX . "_modul_mailer_lists
					WHERE id = '". $id ."'
				");
			}
		}

		$limit = 20;
		$num = $AVE_DB->Query("
			SELECT COUNT(*)
			FROM " . PREFIX . "_modul_mailer_lists
			ORDER BY id DESC
		")->GetCell();
		$pages = @ceil($num / $limit);
		$start = get_current_page() * $limit - $limit;

		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_mailer_lists
			ORDER BY id DESC
			LIMIT " . $start . "," . $limit . "
		");

		$lists = array();
		while ($row = $sql->FetchRow())
		{
			$count = $AVE_DB->Query("
				SELECT COUNT(*)
				FROM " . PREFIX . "_modul_mailer_receivers
				WHERE list_id=" . $row->id
			)->GetCell();
			$row -> number = (($count) ? $count : 0);
			$row -> author_name = get_username_by_id($row->author_id);
			array_push($lists, $row);
		}
		if ($num > $limit)
		{
			$page_nav = " <a class=\"pnav\" href=\"index.php?do=modules&action=modedit&mod=mailer&moduleaction=showlists&page={s}&cp=" . SESSION . "\">{t}</a> ";
			$page_nav = get_pagination($pages, 'page', $page_nav);
			$AVE_Template->assign('page_nav', $page_nav);
		}
		$AVE_Template->assign('lists',$lists);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . "admin_show_lists.tpl"));
	}

	/**
	 * Метод загрузки/удаления/создания/редактирования списка рассылки
	 *
	 * @param string $tpl_dir	путь к директории с шаблонами модуля
	 */
	function mailerEditList($tpl_dir)
	{
		global $AVE_DB, $AVE_Template;

		if ($_REQUEST["wipe"] && $_REQUEST["id"])
		{
			$AVE_DB->Query("
				DELETE
				FROM " . PREFIX . "_modul_mailer_receivers
				WHERE list_id=" . $_REQUEST["id"]
			);
			header("Location:index.php?do=modules&action=modedit&mod=mailer&moduleaction=showlists&cp=" . SESSION);
			exit;
		}
		elseif ($_REQUEST["download"] && $_REQUEST["id"])
		{
			$listname = $AVE_DB->Query("
				SELECT title
				FROM " . PREFIX . "_modul_mailer_lists
				WHERE id=" . $_REQUEST["id"]
			)->FetchRow()->title;
			$file = "";

			$receivers = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_mailer_receivers
				WHERE list_id=" . $_REQUEST["id"]
			);
			while ($rec = $receivers->FetchRow())
			{
				$file .= $rec->id . ";" . $rec->email . ";" . $rec->lastname . ";" . $rec->firstname . ";" . $rec->middlename . ";" . $rec->comments . "\r\n";
			}

			header('Content-Type: text/plain');
			header('Expires: ' . gmdate('D, d M Y H:i:s') . ' GMT');
			header('Content-Disposition: attachment; filename=' . $listname . '.csv');
			header('Content-Length: ' . strlen($file));
			header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
			header('Pragma: public');
			echo $file;
			exit;
		}
		elseif ($_REQUEST["delete"] && $_REQUEST["id"])
		{
			$AVE_DB->Query("
				DELETE
				FROM " . PREFIX . "_modul_mailer_lists
				WHERE id=" . $_REQUEST["id"]
			);
			header("Location:index.php?do=modules&action=modedit&mod=mailer&moduleaction=showlists&cp=" . SESSION);
			exit;
		}

		if ($_REQUEST["id"])
		{
			$list = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_mailer_lists
				WHERE id=" . $_REQUEST["id"]
			)->FetchRow();

			$limit = 20;
			$num = $AVE_DB->Query("
				SELECT COUNT(*)
				FROM " . PREFIX . "_modul_mailer_receivers
				WHERE list_id=" . $_REQUEST["id"] . "
				ORDER BY id DESC
			")->GetCell();
			$pages = @ceil($num / $limit);
			$start = get_current_page() * $limit - $limit;

			$sql = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_mailer_receivers
				WHERE list_id=" . $_REQUEST["id"] . "
				ORDER BY id DESC
				LIMIT " . $start . "," . $limit . "
			");

			$receivers = array();
			while ($row = $sql->FetchRow())
			{
				array_push($receivers,$row);
			}

			if ($num > $limit)
			{
				$page_nav = " <a class=\"pnav\" href=\"index.php?do=modules&action=modedit&mod=mailer&moduleaction=editlist&id=" . $_REQUEST["id"] . "&page={s}&cp=" . SESSION . "\">{t}</a> ";
				$page_nav = get_pagination($pages, 'page', $page_nav);
				$AVE_Template->assign('page_nav', $page_nav);
			}

			$AVE_Template->assign("list",$list);
			$AVE_Template->assign("receivers",$receivers);
		}
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . "admin_edit_list.tpl"));
	}

	/**
	 * Метод сохранения списка рассылки
	 *
	 * @param string $tpl_dir	путь к директории с шаблонами модуля
	 */
	function mailerSaveList()
	{
		global $AVE_DB,$AVE_Template;
		if (!$_REQUEST["id"])
		{
			$AVE_DB->Query("
				INSERT
				INTO " . PREFIX . "_modul_mailer_lists
				SET
					id			= '',
					title		= '" . trim($_POST["title"]) . "',
					descr		= '" . $_POST["descr"] . "',
					author_id	= '" . (int)$_SESSION['user_id'] . "',
					date		= '" . time() . "'
			");
			$list_id = $AVE_DB->Query("
				SELECT MAX(id) 
				FROM " . PREFIX . "_modul_mailer_lists"
			)->GetCell();
		}
		else
		{
			$list_id = $_REQUEST["id"];
			$AVE_DB->Query("
				UPDATE " . PREFIX . "_modul_mailer_lists
				SET
					title		= '" . trim($_POST["title"]) . "',
					descr		= '" . $_POST["descr"] . "'
				WHERE id=" . $list_id
			);
		}
		if ($_POST["status"])
		{
			foreach ($_POST["status"] as $rec_id => $status)
			{
				$AVE_DB->Query("
					UPDATE " . PREFIX . "_modul_mailer_receivers
					SET
						status		= '" . $status . "'
					WHERE id=" . $rec_id
				);
			}
		}
		if ($_POST["new"])
		{
			foreach ($_POST["new"] as $rec_id => $rec_row)
			{
				$rec_row["email"] = trim($rec_row["email"]);
				if ($this->_mailerCheckEmail($rec_row["email"],$list_id) == 1) {
					$AVE_DB->Query("
					INSERT
					INTO " . PREFIX . "_modul_mailer_receivers
					SET
						id				= '',
						status			= '" . $rec_row["status"] . "',
						email			= '" . $rec_row["email"] . "',
						lastname		= '" . $rec_row["lastn"] . "',
						firstname		= '" . $rec_row["firstn"] . "',
						middlename		= '" . $rec_row["midn"] . "',
						comments		= '" . $rec_row["comments"] . "',
						list_id			= '" . $list_id . "'
					");
				}
			}
		}
		if ($_POST["edit"])
		{
			foreach ($_POST["edit"] as $rec_id => $rec_row)
			{
				$AVE_DB->Query("
					UPDATE " . PREFIX . "_modul_mailer_receivers
					SET
						lastname		= '" . $rec_row["lastn"] . "',
						firstname		= '" . $rec_row["firstn"] . "',
						middlename		= '" . $rec_row["midn"] . "',
						comments		= '" . $rec_row["comments"] . "'
					WHERE id=" . $rec_id
				);
			}
		}
		if ($_POST["import"] && $_POST["import_delim_1"] && $_POST["import_delim_2"] && $_POST["import_delim_1"] != $_POST["import_delim_2"])
		{
			$delim_1 = stripslashes($_POST["import_delim_1"]);
			$delim_2 = stripslashes($_POST["import_delim_2"]);
			if($delim_1 == "\\r\\n") $delim_1 = "\r\n";
			if($delim_2 == "\\r\\n") $delim_2 = "\r\n";

			$import = explode($delim_1,$_POST["import"]);

			foreach ($import as $receiver)
			{
				$receiver = explode($delim_2,$receiver);
				if ($this->_mailerCheckEmail(trim($receiver[0]),$list_id) == 1) {
					$AVE_DB->Query("
					INSERT
					INTO " . PREFIX . "_modul_mailer_receivers
					SET
						id				= '',
						status			= '1',
						email			= '" . trim($receiver[0]) . "',
						lastname		= '" . trim($receiver[1]) . "',
						firstname		= '" . trim($receiver[2]) . "',
						middlename		= '" . trim($receiver[3]) . "',
						comments		= '" . trim($receiver[4]) . "',
						list_id			= '" . $list_id . "'
					");
				}
			}
		}

		if ($_FILES["import_file"])
		{
			$file_type = end(explode(".",$_FILES["import_file"]["name"]));

			if ($file_type == "csv")
			{
				$import = file_get_contents($_FILES["import_file"]["tmp_name"]);
				$file_ok = true;
				if (mb_check_encoding($import,"UTF-8") || mb_check_encoding($import,"cp1251"))
				{
					if (mb_check_encoding($import,"cp1251"))
					{
						$import = @iconv('cp1251','UTF-8',$import);
					}
					else $file_ok = false;
				}
				if ($file_ok)
				{
					$import = explode("\r\n",$import);
					foreach ($import as $receiver)
					{
						$receiver = explode(($_POST["import_file_delim"]) ? $_POST["import_file_delim"] : ";",$receiver);
						$receiver[0] = trim($receiver[0]);
						if ($this->_mailerCheckEmail($receiver[0],$list_id) == 1) {
							$AVE_DB->Query("
							INSERT
							INTO " . PREFIX . "_modul_mailer_receivers
							SET
								id				= '',
								email			= '" . trim($receiver[0]) . "',
								lastname		= '" . trim($receiver[1]) . "',
								firstname		= '" . trim($receiver[2]) . "',
								middlename		= '" . trim($receiver[3]) . "',
								comments		= '" . trim($receiver[4]) . "',
								list_id			= '" . $list_id . "'
							");
						}
					}
				}
			}
		}
		header("Location:index.php?do=modules&action=modedit&mod=mailer&moduleaction=" . (($_REQUEST["return"] == 1) ? "editlist&id=" . $list_id : "showlists") . "&cp=" . SESSION);
		exit;
	}
	
	/**
	 * Метод удаления получателя
	 *
	 */
	function mailerDelReceiver($id=null,$public=false)
	{
		global $AVE_DB;
		if ($public)
		{
			$email = $AVE_DB->Query("
				SELECT email
				FROM " . PREFIX . "_modul_mailer_receivers
				WHERE id = ". $id
			)->FetchRow()->email;
		}
		$AVE_DB->Query("
			DELETE
			FROM " . PREFIX . "_modul_mailer_receivers
			WHERE id = ". $id
		);
		if ($public) return $email;
		else exit;
	}
	
	/**
	 * Метод "отписки"
	 *
	 */
	function mailerRefuseReceiver($id=null)
	{
		global $AVE_DB;
		$rec = $AVE_DB->Query("
			SELECT status, email
			FROM " . PREFIX . "_modul_mailer_receivers
			WHERE id = ". $id
		)->FetchRow();
		$AVE_DB->Query("
			UPDATE ". PREFIX . "_modul_mailer_receivers
			SET
				status = '2'
			WHERE id = ". $id
		);
		return $rec;
	}
}
?>