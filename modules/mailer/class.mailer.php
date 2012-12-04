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
 *	Данные
 */
	// Путь к директории с шаблонами модуля
	var $tpl_dir;

/**
 *	Внутренние методы класса
 */
	/**
	 * Метод проверки на синтаксис и уникальность email-а внутри списка рассылки
	 *
	 * @param string $email	e-mail
	 * @param int $list_id	id списка рассылки
	 *
	 * @return int
	 *    0: неверный синтаксис или пустой запрос
	 *    1: всё отлично
	 *    2: email уже есть в базе
	*/
	function _mailerCheckEmail($email='',$list_id=null)
	{
		if (!$email || !preg_match('/^[^ <>@,\\\\\/]+@[^ <>@,\\\\\/]+\.[^ <>@,\\\\\/]+$/i',$email))
		{
			return 0;
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
	 * Метод сохранения вложений из $_FILES['attach']
	 *
	 * @return array $attach	массив путей к файлам
	 */
	function _mailerAttach()
	{
		// проверяем наличие файлов в форме
		if ($_FILES['attach']) $files = $_FILES['attach'];
		else return false;
		//$maxsize = 5000 * 1024; // 5mb
		$attach = array();
		$attach_dir = BASE_DIR . '/' . ATTACH_DIR . '/';

		foreach ($files['tmp_name'] as $i => $file)
		{
			if ($file)
			{
				// проверяем ограничение на размер
				if ($maxsize && filesize($file) > $maxsize) continue;
				// преобразуем имя файла
				$file_name = str_replace(' ','',mb_strtolower(trim($files['name'][$i])));
				// проверяем на наличие файла с таким же именем в папке назначения
				if (file_exists($attach_dir . $file_name))
				{
					$file_name = rand(1000, 9999) . '_' . $file_name;
				}
				// перекидываем файл из врем. дир. в папку назначения
				$file_path = $attach_dir . $file_name;
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
	function _mailerGetFile($file)
	{
		@ob_start();
		header('Pragma: public');
		header('Expires: 0');
		header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
		header('Cache-Control: private',false);
		header('Content-Type: application/octet-stream');
		header('Content-Disposition: attachment; filename=' . basename($file));
		header('Content-Transfer-Encoding: binary');
		header('Content-Length: ' . @filesize($file));
		@set_time_limit(0);
		@readfile($file);
	}
	
	/**
	 * Метод удаления получателя
	 *
	 * @param string $id	id получателя
	 */
	function _mailerDelReceiver($id=null,$public=false)
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
	 * Метод добавления получателя в список
	 */
	function _mailerAddReceiver($list_id,$status,$email,$lname=null,$fname=null,$mname=null,$com=null,$update=false)
	{
		global $AVE_DB;
		$check = $this->_mailerCheckEmail(trim($email),$list_id);
		if($check == 1)
		{
			$AVE_DB->Query("
			INSERT
			INTO " . PREFIX . "_modul_mailer_receivers
			SET
				list_id			= '" . (int)$list_id . "',
				status			= '" . (int)$status . "',
				email			= '" . trim($email) . "',
				lastname		= '" . trim($lname) . "',
				firstname		= '" . trim($fname) . "',
				middlename		= '" . trim($mname) . "',
				comments		= '" . trim($com) . "',
				date			= '" . time() . "'
			");
		}
		elseif($check == 2 && $update)
		{
			$AVE_DB->Query("
			UPDATE " . PREFIX . "_modul_mailer_receivers
			SET
				status			= '" . (int)$status . "',
				lastname		= '" . trim($lname) . "',
				firstname		= '" . trim($fname) . "',
				middlename		= '" . trim($mname) . "',
				comments		= '" . trim($com) . "',
				date			= '" . time() . "'
			WHERE list_id=" . $list_id . " AND email='" . trim($email) . "'
			");
		}
		return $check;
	}

/**
 *	Внешние методы класса
 */

	/**
	 * Вывод списка рассылок
	 */
	function mailerShowMails()
	{
		global $AVE_DB, $AVE_Template;

		// Постраничная навигация
		$limit = 20;
		$num = $AVE_DB->Query("
			SELECT COUNT(*)
			FROM " . PREFIX . "_modul_mailer_mails
			WHERE sent='1'
			ORDER BY date DESC
		")->GetCell();
		$pages = @ceil($num / $limit);
		$start = get_current_page() * $limit - $limit;

		// Поиск
		if ($_POST['search'])
		{
			$AVE_Template->assign('search', $_POST['search']);
			$AVE_Template->assign('search_words', $_POST['search_words']);
			foreach ($_POST['search'] as $field => $true)
			{
				if ($true) $where[] = $field .  " LIKE '%" . $_POST['search_words'] . "%'";
			}
			$where = implode(' OR ',$where);
			$mails_var = array('tpl','sent','find');
		}
		else $mails_var = array('tpl','sent');

		// Создаём три переменные с письмами
		foreach ($mails_var as $mail_var)
		{
			// Запросы к бд
			switch ($mail_var)
			{
				// Черновики
				case 'tpl':
					$sql = $AVE_DB->Query("
						SELECT *
						FROM " . PREFIX . "_modul_mailer_mails
						WHERE sent='0'
						ORDER BY id DESC
					");
					break;

				// Отправленные
				case 'sent':
					$sql = $AVE_DB->Query("
						SELECT *
						FROM " . PREFIX . "_modul_mailer_mails
						WHERE sent='1'
						ORDER BY date DESC
						LIMIT " . $start . "," . $limit
					);
					break;

				// Поиск
				case 'find':
					$sql = $AVE_DB->Query("
						SELECT *
						FROM " . PREFIX . "_modul_mailer_mails
						WHERE sent='1' AND (" . $where . ")
					");
					break;
			}

			while ($row = $sql->FetchRow())
			{
				// получатели из групп
				$s = $AVE_DB->Query("
					SELECT user_group_name
					FROM " . PREFIX . "_user_groups
					WHERE user_group = '" . implode(' OR user_group = ', explode(';', $row->to_groups)) . "'
				");
				$e = array();
				while ($r = $s->FetchRow())
				{
					array_push($e, $r);
				}
				$row->to_groups = $e;
				// получатели из списков
				$s = $AVE_DB->Query("
					SELECT id, title
					FROM " . PREFIX . "_modul_mailer_lists
					WHERE id = '" . implode(' OR id = ', explode(';', $row->to_lists)) . "'
				");
				$e = array();
				while ($r = $s->FetchRow())
				{
					array_push($e, $r);
				}
				$row->to_lists = $e;
				// доп. получатели
				if ($row->to_add) $row->to_add = explode(';',$row->to_add);
				// вложения
				$attach = explode(';',$row->attach);
				$row->attach = array();
				foreach ($attach as $attachment)
				{
					array_push($row->attach,array('name' => basename($attachment),'path'=>$attachment));
				}
				// имя автора рассылки
				$row->author_name = get_username_by_id($row->author_id);
				$mails[$mail_var][] = $row;
			}
		}

		if ($num > $limit)
		{
			$page_nav = '<a class="pnav" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=1&amp;page={s}&amp;cp=' . SESSION . '">{t}</a>';
			$page_nav = get_pagination($pages, 'page', $page_nav);
			$AVE_Template->assign('page_nav', $page_nav);
		}
		$AVE_Template->assign('mails', $mails);
		$AVE_Template->assign('content', $AVE_Template->fetch($this->tpl_dir . 'admin_show_mails.tpl'));
	}

	/**
	 * Метод создания новой рассылки
	 */
	function mailerEditMail()
	{
		global $AVE_DB, $AVE_Template, $AVE_User;

		if (!$_REQUEST['id'] && !$_REQUEST['copy_id'])
		{
			$mail -> from_name = get_settings('mail_from_name');
			$mail -> from_email = get_settings('mail_from');
			$mail -> type = 'text';
			$mail -> body = $AVE_Template->get_config_vars('MAILER_MAILS_TEXT_D') . "\r\n\r\n\r\n\r\n" . get_settings('mail_signature');
			$mail -> appeal = $AVE_Template->get_config_vars('MAILER_MAILS_APPEAL_D');
			$mail -> saveattach = 1;
		}
		else
		{
			$mail = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_mailer_mails
				WHERE id=" . (($_REQUEST['id']) ? $_REQUEST['id'] : $_REQUEST['copy_id'])
			) -> FetchRow();
			
			if ($_REQUEST['copy_id'])
			{
				$mail->id = null;
				$mail->sent = 0;
			}
			$mail -> to_groups = explode(';',$mail -> to_groups);
			$mail -> to_lists = explode(';',$mail -> to_lists);
		}

		$mail -> site_name = get_settings('site_name');
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

		$_SESSION['use_editor'] = get_settings('use_editor');
		$AVE_Template->assign('mail', $mail);
		$AVE_Template->assign('test_email', get_user_rec_by_id($_SESSION['user_id'])->email);
		$AVE_Template->assign('content', $AVE_Template->fetch($this->tpl_dir . 'admin_edit_mail.tpl'));
	}

	/**
	 * Метод сохранения/удаления/подготовки к отправке рассылки
	 */
	function mailerSaveMail($mail_id=null, $act='')
	{
		global $AVE_DB, $AVE_Template, $AVE_User;

		if ($act=='delete' && $mail_id)
		{
			$AVE_DB->Query("
				DELETE
				FROM " . PREFIX . "_modul_mailer_mails
				WHERE id=" . $mail_id
			);
			header('Location:index.php?do=modules&action=modedit&mod=mailer&moduleaction=1&cp=' . SESSION . ($_REQUEST['page']?'&page='.$_REQUEST['page']:''));
			exit;
		}
		
		// записываем вложения
		if ($act == 'send') $attach = $this->_mailerAttach();

		if (!$mail_id)
		{
			$AVE_DB->Query("
				INSERT
				INTO " . PREFIX . "_modul_mailer_mails
				SET
					id			= '',
					author_id	= '" . $_SESSION['user_id'] . "',
					date		= '" . time() . "',
					from_name	= '" . trim($_POST['from_name']) . "',
					from_email	= '" . trim($_POST['from_email']) . "',
					from_copy	= '" . $_POST['from_copy'] . "',
					to_groups	= '" . implode(';',$_POST['to_groups']) . "',
					to_lists	= '" . implode(';',$_POST['to_lists']) . "',
					to_add		= '" . $_POST['to_add'] . "',
					subject		= '" . trim($_POST['subject']) . "',
					type		= '" . $_POST['type'] . "',
					appeal		= '" . trim($_POST['appeal']) . "',
					body		= '" . trim($_POST['body']) . "',
					saveattach	= '" . $_POST['saveattach'] . "',
					attach		= '" . @implode(';',$attach) . "',
					sent		= '0'
			");
			$mail_id = $AVE_DB->Query("
				SELECT MAX(id) 
				FROM " . PREFIX . "_modul_mailer_mails"
			)->GetCell();
		}
		else
		{
			$AVE_DB->Query("
				UPDATE " . PREFIX . "_modul_mailer_mails
				SET
					from_name	= '" . trim($_POST['from_name']) . "',
					from_email	= '" . trim($_POST['from_email']) . "',
					from_copy	= '" . $_POST['from_copy'] . "',
					to_groups	= '" . implode(';',$_POST['to_groups']) . "',
					to_lists	= '" . implode(';',$_POST['to_lists']) . "',
					to_add		= '" . $_POST['to_add'] . "',
					subject		= '" . trim($_POST['subject']) . "',
					type		= '" . $_POST['type'] . "',
					appeal		= '" . trim($_POST['appeal']) . "',
					body		= '" . trim($_POST['body']) . "',
					saveattach	= '" . $_POST['saveattach'] . "',
					attach		= '" . @implode(';',$attach) . "',
					sent		= '0'
				WHERE id=" . $mail_id
			);
		}

		// Отправляем письмо
		if ($act == 'send') {

			// Сохраняем все данные в одну переменную
			unset($_SESSION['mailer'][$mail_id]);
			$mailer = $_POST;

			// номер рассылки
			$mailer['id'] = $mail_id;

			// сохраняем вложения
			$mailer['attach'] = $attach;

			// создаём массив получателей
			$mailer['receivers'] = array();
			$receivers = array();

			// получатели из списков
			if($mailer['to_lists'])
			{
				$rec_lists = $AVE_DB->Query("
					SELECT *
					FROM " . PREFIX . "_modul_mailer_receivers
					WHERE list_id = " . implode(' OR list_id = ',$mailer['to_lists'])
				);
				while ($rec = $rec_lists->FetchRow())
				{
					if(!in_array($rec->email,$receivers) && (int)$rec->status == 1)
					{
						$rec -> id = 'L' . $rec -> id;
						array_push($mailer['receivers'], $rec);
						array_push($receivers, $rec->email);
					}
				}
				unset($rec);
			}

			// получатели из групп
			if($mailer['to_groups'])
			{
				$rec_groups = $AVE_DB->Query("
					SELECT id,email,lastname,firstname,user_group
					FROM " . PREFIX . "_users
					WHERE user_group = " . implode(' OR user_group = ',$mailer['to_groups'])
				);
	
				while ($rec = $rec_groups->FetchRow())
				{
					if(!in_array($rec->email,$receivers))
					{
						$rec -> id = 'G' . $rec -> id;
						array_push($mailer['receivers'], $rec);
						array_push($receivers, $rec->email);
					}
				}
				unset($rec);
			}

			// дополнительные получатели
			$rec_add = explode(';',$mailer['to_add']);
			foreach ($rec_add as $rec_add_num => $rec_add_1)
			{
				$rec_add_1 = trim($rec_add_1);
				if($rec_add_1 && !in_array($rec_add_1,$receivers) && $this->_mailerCheckEmail($rec_add_1) == 1)
				{
					$rec = array();
					$rec['id'] = 'A' . $rec_add_num;
					$rec['email'] = $rec_add_1;
					$rec = array2object($rec);
					array_push($mailer['receivers'], $rec);
					array_push($receivers, $rec->email);
				}
			}
			unset($rec);

			// отправитель в копию, если просили
			if ($mailer['from_copy'] && !in_array($mailer['from_email'],$receivers))
			{
				$rec = array();
				$rec['id'] = 'C' . $mailer['author_id'];
				$rec['email'] = trim($mailer['from_email']);
				$rec = array2object($rec);
				array_push($mailer['receivers'], $rec);
			}
			
			// считаем получателей
			$mailer['number'] = count($mailer['receivers']);
			$mailer['count'] = 1;
	
			// записываем все данные в сессию
			$_SESSION['mailer'][$mail_id] = $mailer;
		}
		// если сохранение через ajax, выходим
		if ($act == 'ajaxsave' || $act == 'send')
		{
			echo $mail_id;
			exit;
		}
		elseif ($act == 'go' || $act == 'delete')
		{
			header('Location:index.php?do=modules&action=modedit&mod=mailer&moduleaction=1&cp='.SESSION);
		}
	}

	/**
	 * Метод отправки рассылки
	 */
	function mailerSendMail() {
		global $AVE_DB;

		// получаем id рассылки
		$mail_id = $_REQUEST['mail_id'];
		
		// шлём письмо, используя данные сессии
		if ($_SESSION['mailer'][$mail_id]['count'] <= $_SESSION['mailer'][$mail_id]['number'])
		{
			//берём следующего получателя
			$rec = array_shift($_SESSION['mailer'][$mail_id]['receivers']);

			// Уникальный id письма: %номер рассылки%-%id получателя%
			$id = $_SESSION['mailer'][$mail_id]['id'] . '-' . $rec -> id;
			
			// Обращение к получателю
			$name = trim($rec->lastname . ' ' . $rec->firstname . ' ' . $rec->middlename);
			if (!$name)
			{
				$name = $_SESSION['mailer'][$mail_id]['appeal'];
			}
			$body = str_replace(
				array('%NAME%'	,'%ID%'	,'%SHOW%'),
				array($name		,$id	,'http://'.$_SERVER['SERVER_NAME'].'/index.php?module=mailer&action=show&id='.$mail_id.'&onlycontent=1'),
				$_SESSION['mailer'][$mail_id]['body']);

			// Посылаем письмо
			send_mail(
				$rec->email,
				$body,
				trim($_SESSION['mailer'][$mail_id]['subject']),
				trim($_SESSION['mailer'][$mail_id]['from_email']),
				trim($_SESSION['mailer'][$mail_id]['from_name']),
				trim($_SESSION['mailer'][$mail_id]['type']),
				$_SESSION['mailer'][$mail_id]['attach'],
				false,false
			);

			// записываем отправленных в базу, чтобы если что знать, кому уже отправились письма
			$_SESSION['mailer'][$mail_id]['done'][] = $rec->email;

			$AVE_DB->Query("
				UPDATE " . PREFIX . "_modul_mailer_mails
				SET
					date		= '" . time() . "',
					done		= '" . implode(';',$_SESSION['mailer'][$mail_id]['done']) . "',
					sent		= '1'
				WHERE id=" . $mail_id
			);

			// округлённый процент выполнения
			$procent = floor($_SESSION['mailer'][$mail_id]['count']/$_SESSION['mailer'][$mail_id]['number']*100);

			// считаем
			$_SESSION['mailer'][$mail_id]['count']++;

			// возвращаем в AJAX число
			echo $procent;
		}
		else
		{
			// Удаяем вложения, если просили
			if ($_SESSION['mailer'][$mail_id]['attach'] && !(int)$_SESSION['mailer'][$mail_id]['saveattach'])
			{
				foreach ($_SESSION['mailer'][$mail_id]['attach'] as $file)
				{
					@unlink($file);
				}
			}
			unset ($_SESSION['mailer'][$mail_id]);
			echo 'finish';
		}
		exit;
	}

	/**
	 * Вывод списков рассылок
	 */
	function mailerShowLists()
	{
		global $AVE_DB, $AVE_Template;

		if ($_POST['del'])
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
			$page_nav = '<a class="pnav" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=showlists&amp;page={s}&amp;cp=' . SESSION . '">{t}</a>';
			$page_nav = get_pagination($pages, 'page', $page_nav);
			$AVE_Template->assign('page_nav', $page_nav);
		}
		$AVE_Template->assign('lists',$lists);
		$AVE_Template->assign('content', $AVE_Template->fetch($this->tpl_dir . 'admin_show_lists.tpl'));
	}

	/**
	 * Метод загрузки/удаления/создания/редактирования списка рассылки
	 */
	function mailerEditList()
	{
		global $AVE_DB, $AVE_Template;

		if ($_REQUEST['wipe'] && $_REQUEST['id'])
		{
			$AVE_DB->Query("
				DELETE
				FROM " . PREFIX . "_modul_mailer_receivers
				WHERE list_id=" . $_REQUEST['id']
			);
			header('Location:index.php?do=modules&action=modedit&mod=mailer&moduleaction=showlists&cp=' . SESSION . ($_REQUEST['page']?'&page='.$_REQUEST['page']:''));
			exit;
		}
		elseif ($_REQUEST['download'] && $_REQUEST['id'])
		{
			$listname = $AVE_DB->Query("
				SELECT title
				FROM " . PREFIX . "_modul_mailer_lists
				WHERE id=" . $_REQUEST['id']
			)->GetCell();
			$file = '';

			$receivers = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_mailer_receivers
				WHERE list_id=" . $_REQUEST['id']
			);
			while ($rec = $receivers->FetchRow())
			{
				$file .= $rec->email . ';' . $rec->lastname . ';' . $rec->firstname . ';' . $rec->middlename . ';' . $rec->comments . "\r\n";
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
		elseif ($_REQUEST['delete'] && $_REQUEST['id'])
		{
			$AVE_DB->Query("
				DELETE
				FROM " . PREFIX . "_modul_mailer_lists
				WHERE id=" . $_REQUEST['id']
			);
			header('Location:index.php?do=modules&action=modedit&mod=mailer&moduleaction=showlists&cp=' . SESSION . ($_REQUEST['page']?'&page='.$_REQUEST['page']:''));
			exit;
		}

		if ($_REQUEST['id'])
		{
			$list = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_mailer_lists
				WHERE id=" . $_REQUEST['id']
			)->FetchRow();

			$limit = 20;
			$num = $AVE_DB->Query("
				SELECT COUNT(*)
				FROM " . PREFIX . "_modul_mailer_receivers
				WHERE list_id=" . $_REQUEST['id'] . "
				ORDER BY id DESC
			")->GetCell();
			$pages = @ceil($num / $limit);
			$start = get_current_page() * $limit - $limit;

			$sql = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_mailer_receivers
				WHERE list_id=" . $_REQUEST['id'] . "
				ORDER BY id DESC
				LIMIT " . $start . ',' . $limit . "
			");

			$receivers = array();
			while ($row = $sql->FetchRow())
			{
				array_push($receivers,$row);
			}

			if ($num > $limit)
			{
				$page_nav = '<a class="pnav" href="index.php?do=modules&amp;action=modedit&amp;mod=mailer&amp;moduleaction=editlist&amp;id=' . $_REQUEST['id'] . '&amp;page={s}&amp;cp=' . SESSION . '">{t}</a>';
				$page_nav = get_pagination($pages, 'page', $page_nav);
				$AVE_Template->assign('page_nav', $page_nav);
			}

			$AVE_Template->assign('list',$list);
			$AVE_Template->assign('receivers',$receivers);
		}
		$AVE_Template->assign('content', $AVE_Template->fetch($this->tpl_dir . 'admin_edit_list.tpl'));
	}

	/**
	 * Метод сохранения списка рассылки
	 */
	function mailerSaveList()
	{
		global $AVE_DB,$AVE_Template;
		if (!$_REQUEST['id'])
		{
			$AVE_DB->Query("
				INSERT
				INTO " . PREFIX . "_modul_mailer_lists
				SET
					id			= '',
					title		= '" . trim($_POST['title']) . "',
					descr		= '" . $_POST['descr'] . "',
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
			$list_id = $_REQUEST['id'];
			$AVE_DB->Query("
				UPDATE " . PREFIX . "_modul_mailer_lists
				SET
					title		= '" . trim($_POST['title']) . "',
					descr		= '" . $_POST['descr'] . "'
				WHERE id=" . $list_id
			);
		}
		if ($_POST['status'])
		{
			foreach ($_POST['status'] as $rec_id => $status)
			{
				$AVE_DB->Query("
					UPDATE " . PREFIX . "_modul_mailer_receivers
					SET
						status		= '" . $status . "'
					WHERE id=" . $rec_id
				);
			}
		}
		if ($_POST['new'])
		{
			foreach ($_POST['new'] as $rec_id => $rec_row)
			{
				$rec_row['email'] = trim($rec_row['email']);
				$this -> _mailerAddReceiver($list_id,$rec_row['status'],$rec_row['email'],$rec_row['lastn'],$rec_row['firstn'],$rec_row['midn'],$rec_row['comments']);
			}
		}
		if ($_POST['edit'])
		{
			foreach ($_POST['edit'] as $rec_id => $rec_row)
			{
				$AVE_DB->Query("
					UPDATE " . PREFIX . "_modul_mailer_receivers
					SET
						lastname		= '" . $rec_row['lastn'] . "',
						firstname		= '" . $rec_row['firstn'] . "',
						middlename		= '" . $rec_row['midn'] . "',
						comments		= '" . $rec_row['comments'] . "'
					WHERE id=" . $rec_id
				);
			}
		}
		if ($_POST['import'] && $_POST['import_delim_1'] && $_POST['import_delim_2'] && $_POST['import_delim_1'] != $_POST['import_delim_2'])
		{
			$delim_1 = stripslashes($_POST['import_delim_1']);
			$delim_2 = stripslashes($_POST['import_delim_2']);

			if ($delim_1 == "\\r\\n") $delim_1 = "\r\n";
			if ($delim_2 == "\\r\\n") $delim_2 = "\r\n";

			$import = explode($delim_1,$_POST['import']);
			foreach ($import as $receiver)
			{
				$receiver = explode($delim_2,$receiver);
				$this->_mailerAddReceiver($list_id,1,$receiver[0],$receiver[1],$receiver[2],$receiver[3],$receiver[4]);
			}
		}

		if ($_FILES['import_file'])
		{
			$file_type = end(explode('.',$_FILES['import_file']['name']));

			if ($file_type == 'csv')
			{
				$import = file_get_contents($_FILES['import_file']['tmp_name']);
				$file_ok = true;
				if (mb_check_encoding($import,'UTF-8') || mb_check_encoding($import,'cp1251'))
				{
					if (mb_check_encoding($import,'cp1251'))
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
						$receiver = explode(($_POST['import_file_delim']) ? $_POST['import_file_delim'] : ';',$receiver);
						$this->_mailerAddReceiver($list_id,1,$receiver[0],$receiver[1],$receiver[2],$receiver[3],$receiver[4]);
					}
				}
			}
		}
		$_SESSION['mailer']['list_import_delim_1'] = $_POST['import_delim_1'];
		$_SESSION['mailer']['list_import_delim_2'] = $_POST['import_delim_2'];
		$_SESSION['mailer']['list_import_delim_csv'] = $_POST['import_file_delim'];
		header('Location:index.php?do=modules&action=modedit&mod=mailer&moduleaction=' . (($_REQUEST['return'] == 1) ? 'editlist&id=' . $list_id : 'showlists') . ($_POST['page']?'&page='.$_POST['page']:'') . '&cp=' . SESSION);
		exit;
	}

	/**
	 * Метод подписки
	 */
	function mailerSubscribe()
	{
		global $AVE_DB,$AVE_Template;

		$result = $this->_mailerAddReceiver($_POST['list_id'],1,$_POST['email'],$_POST['lname'],$_POST['fname'],$_POST['mname']);
		
		if ($result == 2)
		{
			$rec = $AVE_DB->Query("
				SELECT id, status
				FROM " . PREFIX . "_modul_mailer_receivers
				WHERE list_id=" . $_POST['list_id'] . " AND email = '" . trim($_POST['email']) . "'
			")->FetchRow();
			if ((int)$rec->status == 2) $result = 1;
			
			$this->_mailerAddReceiver($_POST['list_id'],1,$_POST['email'],$_POST['lname'],$_POST['fname'],$_POST['mname'],'',true);	
		}
		return $result;
	}

	/**
	 * Метод "отписки"
	 */
	function mailerUnsubscribe()
	{
		global $AVE_DB,$AVE_Template;

		$list_id = trim($_POST['list_id']);
		$email = trim($_POST['email']);

		$sql = $AVE_DB->Query("
			SELECT id, status
			FROM " . PREFIX . "_modul_mailer_receivers
			WHERE list_id = ". $list_id . " AND email = '" . $email . "'
		")->FetchRow();
		
		if (!$sql || (int)$sql->status == 2)
		{
			return 0;
		}
		else
		{
			$AVE_DB->Query("
				UPDATE ". PREFIX . "_modul_mailer_receivers
				SET
					status = '2'
				WHERE id = ". $sql->id
			);
			return 1;
		}
	}

	/**
	 * Метод тестовой отправки
	 */
	function mailerTestSend($id,$emails)
	{
		global $AVE_DB,$AVE_Template;
		
		// Сохраняем письмо перед отправкой
		$this->mailerSaveMail($id);
		
		// Отправляем каждому адресату, если правильный email
		foreach (explode(';',$emails) as $email)
		{
			$email = trim($email);
			if ($this->_mailerCheckEmail($email) == 1)
			{
				// Формируем тело
				$body = str_replace(
					array('%NAME%'			,'%SHOW%'),
					array($_POST['appeal']	,'http://'.$_SERVER['SERVER_NAME'].'/index.php?module=mailer&action=show&id='.$id.'&onlycontent=1'),
					$_POST['body']);
				
				// Отправляем с вложениями
				send_mail(
					$email,
					$body,
					trim($_POST['subject']),
					trim($_POST['from_email']),
					trim($_POST['from_name']),
					trim($_POST['type']),
					$this->_mailerAttach(),
					false,false
				);
				$emails_new[] = $email;
			}
		}
		return $emails_new;
	}

	/**
	 * Метод мульти-добавления получателей
	 */
	function mailerMultiAdd()
	{
		global $AVE_DB, $AVE_Template;
		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_mailer_lists
			ORDER BY id DESC
		");
		while ($row = $sql->FetchRow())
		{
			$lists[] = $row;
		}

		$AVE_Template->assign('lists', $lists);
		$AVE_Template->assign('content', $AVE_Template->fetch($this->tpl_dir . 'admin_multi_add.tpl'));
	}

	/**
	 * Метод сохранения получателей из мульти-добавления
	 */
	function mailerMultiSave()
	{
		global $AVE_DB;
		foreach ($_POST['lists'] as $list_id)
		{	
			foreach ($_POST['new'] as $rec)
			{
				$this->_mailerAddReceiver($list_id,$rec['status'],$rec['email'],$rec['lastn'],$rec['firstn'],$rec['midn'],$rec['comments'],false);
			}
		}
		$_SESSION['mailer']['multi_add'] = $_POST['lists'];
		header('Location:index.php?do=modules&action=modedit&mod=mailer&moduleaction=' . ($_REQUEST['return'] ? 'multiadd' : 'showlists') . '&cp=' . SESSION);
	}

	/**
	 * Метод подсчёта получателей при создании рассылки
	 */
	function mailerCountMail()
	{
		global $AVE_DB;

		// получатели из списков
		foreach ($_POST['to_lists'] as $list_id)
		{
			$list_name = $AVE_DB->Query("
				SELECT title
				FROM " . PREFIX . "_modul_mailer_lists
				WHERE id = " . $list_id
			)->GetCell();
			$rec_lists = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_mailer_receivers
				WHERE list_id = " . $list_id
			);
			while ($rec = $rec_lists->FetchRow())
			{
				if(!in_array($rec->email,$rec_clean) && (int)$rec->status == 1)
				{
					$rec_clean[] = $rec->email;
				}
				else
				{
					$rec->s = true;
				}
				$rec_all['lists'][$list_name][] = $rec;
			}
		}
		unset($rec);

		// получатели из групп
		foreach ($_POST['to_groups'] as $group_id)
		{
			$group_name = $AVE_DB->Query("
				SELECT user_group_name
				FROM " . PREFIX . "_user_groups
				WHERE user_group = " . $group_id
			)->GetCell();
			$rec_groups = $AVE_DB->Query("
				SELECT id,email,lastname,firstname,user_group,user_name
				FROM " . PREFIX . "_users
				WHERE user_group = " . $group_id
			);
			while ($rec = $rec_groups->FetchRow())
			{
				if(!in_array($rec->email,$rec_clean))
				{
					$rec_clean[] = $rec->email;
				}
				else
				{
					$rec->s = true;
				}
				$rec_all['groups'][$group_name][] = $rec;
			}
		}
		unset($rec);

		// дополнительные получатели
		$rec_add = explode(';',$_POST['to_add']);
		foreach ($rec_add as $email)
		{
			$rec = array();
			$email = trim($email);
			if ($email)
			{
				if(!in_array($email,$rec_clean) && $this->_mailerCheckEmail($email) == 1)
				{
					$rec_clean[] = $email;
				}
				elseif($this->_mailerCheckEmail($email) != 1)
				{
					$rec['s'] = 2;
				}
				else
				{
					$rec['s'] = 1;
				}
				$rec['email'] = $email;
				$rec_all['add'][] = $rec;
			}
		}
		unset($rec);

		// отправитель
		$_POST['from_email'] = trim($_POST['from_email']);
		if ($_POST['from_copy'])
		{
			if(in_array($_POST['from_email'],$rec_clean)) $rec['s'] = 1;
			if($this->_mailerCheckEmail($_POST['from_email']) != 1) $rec['s'] = 2;
			$rec['email'] = $_POST['from_email'];
			$rec['from'] = true;
			$rec_all['add'][] = $rec;
		}

		unset($_SESSION['mailer'][$_REQUEST['id']]);
		$_SESSION['mailer'][$_REQUEST['id']] = $rec_all;
		$_SESSION['mailer'][$_REQUEST['id']]['title'] = $_POST['subject'];
		$_SESSION['mailer'][$_REQUEST['id']]['number'] = count($rec_clean);
		return count($rec_clean);
	}
}
?>