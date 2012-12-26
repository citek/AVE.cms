<?php

/**
 * Класс работы с галереями
 *
 * @package AVE.cms
 * @subpackage module_Gallery
 * @since 1.4
 * @filesource
 */
class Gallery
{

/**
 *	СВОЙСТВА
 */

	/**
	 * Количество галерей в списке
	 *
	 * @var int
	 */
	var $_limit_galleries = 10;

	/**
	 * Количество изображений при просмотре в админке
	 *
	 * @var int
	 */
	var $_admin_limit_images = 15;

	/**
	 * Количество изображений по умолчанию при выводе галереи в публичной части
	 *
	 * @var int
	 */
	var $_default_limit_images = 15;

	/**
	 * Разрешенные типы файлов
	 *
	 * @var array
	 */
	var $_allowed_type = array('.jpg','jpeg','.jpe','.gif','.png','.avi','.mov','.wmv','.wmf','.mp4');

	/**
	 * Размер и тип формирования миниатюр
	 *
	 * @var string
	 */
	var	$_size = '%1$s%2$ux%3$u';
	//var	$_size = 'c%1$ux%1$u';

	/**
	 * Размер и тип формирования миниатюр в админке
	 *
	 * @var string
	 */
	var	$admin_size = 'c100x100';
	//var	$_size = 'c%1$ux%1$u';

/**
 *	ВНЕШНИЕ МЕТОДЫ
 */

	/**
	 * ФУНКЦИИ ПУБЛИЧНОЙ ЧАСТИ
	 */

	/**
	 * Вывод галереи
	 *
	 * @param string $tpl_dir - путь к папке с шаблонами модуля
	 * @param int $gallery_id - идентификатор галереи
	 * @param int $lim - количество изображений на странице
	 * @param int $ext - признак вывода всех изображений галереи
	 */
	function galleryShow($tpl_dir, $gallery_id, $lim, $ext = 0)
	{
		global $AVE_DB, $AVE_Template, $AVE_Core;

		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_gallery
			WHERE id = '" . $gallery_id . "'
		");
		$row_gs = $sql->FetchRow();

		$limit = ($row_gs->gallery_image_on_page > 0)
			? $row_gs->gallery_image_on_page
			: $this->_default_limit_images;
		$limit = empty($lim) ? $limit : $lim;
		$limit = ($ext != 1) ? $limit : 10000;
		$start = get_current_page() * $limit - $limit;

		switch ($row_gs->gallery_orderby)
		{
			case 'position':  $order_by = "image_position ASC"; break;
			case 'titleasc':  $order_by = "image_title ASC";    break;
			case 'titledesc': $order_by = "image_title DESC";   break;
			case 'dateasc':   $order_by = "image_date ASC";     break;
			default:          $order_by = "image_date DESC";    break;
		}

		$sql = $AVE_DB->Query("
			SELECT COUNT(*)
			FROM " . PREFIX . "_modul_gallery_images
			WHERE gallery_id = '" . $gallery_id . "'
		");
		$num = $sql->GetCell();

		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_gallery_images
			WHERE gallery_id = '" . $gallery_id . "'
			ORDER BY " . $order_by . "
			LIMIT " . $start . "," . $limit . "
		");

		$folder = trim(UPLOAD_GALLERY_DIR . '/' . $row_gs->gallery_folder, '/');
		$size = sprintf($this->_size, $row_gs->gallery_thumb_method, $row_gs->gallery_thumb_width, $row_gs->gallery_thumb_height);

		$search = array('[tag:gal:id]', '[tag:gal:folder]', '[tag:path]','[tag:gal:title]','[tag:gal:description]');
		$replace = array($row_gs->id, ABS_PATH . $folder . '/', ABS_PATH,$row_gs->gallery_title,$row_gs->gallery_description);
		$main_template = str_replace($search, $replace, $row_gs->gallery_script);

		// Постраничная навигация
		if ($num > $limit)
		{
			$page_nav = ' <a class="pnav" href="index.php?id=' . $AVE_Core->curentdoc->Id
				. '&amp;doc=' . (empty($AVE_Core->curentdoc->document_alias) ? prepare_url($AVE_Core->curentdoc->document_title) : $AVE_Core->curentdoc->document_alias)
				. ((isset($_REQUEST['artpage']) && is_numeric($_REQUEST['artpage'])) ? '&amp;artpage=' . $_REQUEST['artpage'] : '')
				. ((isset($_REQUEST['apage']) && is_numeric($_REQUEST['apage'])) ? '&amp;apage=' . $_REQUEST['apage'] : '')
				. '&amp;page={s}">{t}</a> ';
			$page_nav = get_pagination(ceil($num / $limit), 'page', $page_nav, get_settings('navi_box'));
			$page_nav = rewrite_link($page_nav);
			$GLOBALS['page_id'][$_REQUEST['id']]['page']=($GLOBALS['page_id'][$_REQUEST['id']]['page']>ceil($num / $limit) ? $GLOBALS['page_id'][$_REQUEST['id']]['page'] : ceil($num / $limit));
		}
		else
		{
			$page_nav = '';
		}

		$rows = array();
		while ($row = $sql->FetchRow())
		{


				$row->image_filename = rawurlencode($row->image_filename);
	   			$row->image_size = round(filesize(BASE_DIR . '/' . $folder . '/' . $row->image_filename) / 1024, 0);

			array_push($rows, $row);
		}
		$images = '';
		$i = 0;
		foreach ($rows as $row)
		{

				$search = array(
					'[tag:img:id]',
					'[tag:img:original]',
					'[tag:img:thumbnail]',
					'[tag:img:title]',
					'[tag:img:description]',
					'[tag:img:size]',
					'[tag:gal:id]',
					'[tag:gal:folder]',
					'[tag:path]',
					'[tag:link]'
				);
				$replace = array(
					$row->id,
					ABS_PATH . $folder . '/' . $row->image_filename,
					make_thumbnail(array('link' => ABS_PATH . $folder . '/' . $row->image_filename, 'size' => $size)),
					htmlspecialchars(empty($row->image_title)? $AVE_Template->get_config_vars('NoTitle') : $row->image_title, ENT_QUOTES),
					htmlspecialchars(empty($row->image_description) ? $AVE_Template->get_config_vars('NoDescr') : $row->image_description, ENT_QUOTES),
					$row->image_size,
					$row_gs->id,
					ABS_PATH . $folder . '/',
					ABS_PATH,
					str_ireplace('"//"','"/"',str_ireplace('///','/',rewrite_link($row->image_link. '&amp;doc=' . (empty($row->image_link_alias) ? prepare_url($row->image_title) : $row->image_link_alias))))
				);
				$image = str_replace($search, $replace, $row_gs->gallery_image_template);
					if(($i+1)%$row_gs->gallery_image_on_line==0){
						 $image = $image.$row_gs->gallery_sepp_line;
					}
				$images .= $image;
				$i++;
		}
		$main_template = str_replace('[tag:gal:pages]', $page_nav, $main_template);

		$return = str_replace('[tag:gal:content]', $images, $main_template);
		$return = str_replace('[tag:path]', ABS_PATH, $return);
		$return = str_replace('[tag:mediapath]', ABS_PATH . 'templates/' . THEME_FOLDER . '/', $return);

		echo $return;
	}


	/**
	 * Вывод одиночного изображения
	 *
	 * @param string $tpl_dir - путь к папке с шаблонами модуля
	 * @param int $image_id - идентификатор изображения
	 */
	function galleryImageShow($tpl_dir, $image_id)
	{
		global $AVE_DB, $AVE_Template;

		$sql = $AVE_DB->Query("
			SELECT
				image_filename,
				image_file_ext,
				image_title,
				gallery_folder
			FROM
				" . PREFIX . "_modul_gallery_images AS img
			LEFT JOIN
				" . PREFIX . "_modul_gallery AS gal
					ON gal.id = gallery_id
			WHERE
				img.id = '" . $image_id . "'
		");
		$row = $sql->FetchRow();

		$folder = trim(UPLOAD_GALLERY_DIR . '/' . $row->gallery_folder, '/');
//		$thumb_dir = trim(THUMBNAIL_DIR . '/' . sprintf($this->_size, $row->gallery_thumb_width), '/');
		$source = ABS_PATH . $folder . '/' . rawurlencode($row->image_filename);

		switch ($this->_galleryFileTypeGet($row->image_file_ext))
		{
			case 'gif':
			case 'jpg':
			case 'png':
				list($width, $height) = getimagesize(BASE_DIR . '/' . $folder . '/' . $row->image_filename);
				$AVE_Template->assign('w', ($width < 350 ? 350 : ($width > 950 ? 950 : $width+8)));
				$AVE_Template->assign('h', ($height < 350 ? 350 : ($height > 700 ? 700 : $height+85)));
				$AVE_Template->assign('scrollbars', ($width > 950 || $height > 700 ? 1 : '') );
				$AVE_Template->assign('source', $source);
				$AVE_Template->assign('image_title', $row->image_title);
				break;

			case 'video':
				$AVE_Template->assign('w', 350);
				$AVE_Template->assign('notresizable', 1);
				$AVE_Template->assign('h', 400);
				$AVE_Template->assign('source', $source);
				$AVE_Template->assign('mediatype', $this->_galleryMediaTypeGet($row->image_file_ext));
				break;
		}

		$AVE_Template->display($tpl_dir . 'image.tpl');
	}

	/**
	 * ФУНКЦИИ АДМИНИСТРАТИВНОЙ ЧАСТИ
	 */

	/**
	 * Просмотр изображений галереи в админке
	 *
	 * @param string $tpl_dir - путь к папке с шаблонами модуля
	 * @param int $gallery_id - идентификатор галереи
	 */
	function galleryImageListShow($tpl_dir, $gallery_id)
	{
		global $AVE_DB, $AVE_Template;

		$sql = $AVE_DB->Query("
			SELECT
				gallery_thumb_width,
				gallery_thumb_height,
				gallery_thumb_method,
                gallery_title,
				gallery_folder
			FROM " . PREFIX . "_modul_gallery
			WHERE id = '" . $gallery_id . "'
		");
		$row_gs = $sql->FetchRow();

		$folder = trim(UPLOAD_GALLERY_DIR . '/' . $row_gs->gallery_folder, '/');
		$size = sprintf($this->_size, $row_gs->gallery_thumb_method, $row_gs->gallery_thumb_width, $row_gs->gallery_thumb_height);

		if (isset($_REQUEST['sub']) && $_REQUEST['sub'] == 'save')
		{
			if (isset($_POST['del']) && sizeof($_POST['del']) > 0)
			{
				while (list($image_id) = each($_POST['del']))
				{
					$file = BASE_DIR . '/' . $folder . '/' . $_POST['datei'][$image_id];
					@unlink($file);
					@unlink(make_thumbnail(array('link' => $file, 'size' => $size)));

					$AVE_DB->Query("
						DELETE
						FROM " . PREFIX . "_modul_gallery_images
						WHERE id = '" . (int)$image_id . "'
					");
				}
			}

			foreach ($_POST['gimg'] as $image_id)
			{
				$AVE_DB->Query("
					UPDATE " . PREFIX . "_modul_gallery_images
					SET
						image_title = '" . $_POST['image_title'][$image_id] . "',
						image_description = '" . $_POST['image_description'][$image_id] . "',
						image_position = '" . intval($_POST['image_position'][$image_id]) . "',
						image_link = '" . $_POST['image_link'][$image_id] . "',
						image_link_alias = '" . $_POST['image_link_alias'][$image_id] . "'
					WHERE
						id = '" . (int)$image_id . "'
					AND
						gallery_id = '" . $gallery_id . "'
				");
			}

			header('Location:' . get_redirect_link('sub'));
			exit;
		}

		$limit = $this->_admin_limit_images;
		$start = get_current_page() * $limit - $limit;

		$sql = $AVE_DB->Query("
			SELECT SQL_CALC_FOUND_ROWS *
			FROM " . PREFIX . "_modul_gallery_images
			WHERE gallery_id = '" . $gallery_id . "'
			ORDER BY id DESC
			LIMIT " . $start . "," . $limit . "
		");

		$sql_num = $AVE_DB->Query("SELECT FOUND_ROWS()");
		$num = $sql_num->GetCell();

		if (!$num)
		{
			header('Location:index.php?do=modules&action=modedit&mod=gallery&moduleaction=1');
			exit;
		}

		$images = array();
		while ($row = $sql->FetchAssocArray())
		{
			$row['image_type'] = $this->_galleryFileTypeGet($row['image_file_ext']);
			$row['image_author'] = get_username_by_id($row['image_author_id']);
			$row['image_size'] = @filesize(BASE_DIR . '/' . $folder . '/' . $row['image_filename']);
			$row['image_size'] = @round($row['image_size'] / 1024, 2);
			$row['image_filename'] = rawurlencode($row['image_filename']);
			$row['original'] = ABS_PATH . $folder . '/' . $row['image_filename'];
			$row['thumbnail'] = make_thumbnail(array('link' => $row['original'], 'size' => $size));
			array_push($images, $row);
		}

		if ($num > $limit)
		{
			$page_nav = ' <a class="pnav" href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=showimages&id=' . $gallery_id . '&page={s}">{t}</a> ';
			$page_nav = get_pagination(ceil($num / $limit), 'page', $page_nav);
		}
		else
		{
			$page_nav = '';
		}
		$AVE_Template->assign('page_nav', $page_nav);
        $AVE_Template->assign('gallery_title', $row_gs->gallery_title);
		$AVE_Template->assign('gallery_thumb_width', $row_gs->gallery_thumb_width);
		$AVE_Template->assign('images', $images);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_gallery_image.tpl'));
	}

	/**
	 * Загрузка изображений в галерею
	 *
	 * @param string $tpl_dir - путь к папке с шаблонами модуля
	 * @param int $gallery_id - идентификатор галереи
	 */
	function galleryImageUploadForm($tpl_dir, $gallery_id)
	{
		global $AVE_DB, $AVE_Template;

		$sql = $AVE_DB->Query("
			SELECT
				gallery_watermark,
				gallery_thumb_width,
                gallery_title,
				gallery_folder
			FROM " . PREFIX . "_modul_gallery
			WHERE id = '" . $gallery_id . "'
		");
		$row = $sql->FetchRow();

		$dst_dir = BASE_DIR . '/' . trim(UPLOAD_GALLERY_DIR . '/' . $row->gallery_folder, '/');

		if (isset($_REQUEST['sub']) && $_REQUEST['sub'] == 'save')
		{
			$images = array();

			$path = ABS_PATH . trim(UPLOAD_GALLERY_DIR . '/' . $row->gallery_folder, '/');
			$size = sprintf($this->_size, $row_gs->gallery_thumb_method, $row_gs->gallery_thumb_width, $row_gs->gallery_thumb_height);
			$admin_size = sprintf($this->admin_size, $row_gs->gallery_thumb_method, $row_gs->gallery_thumb_width, $row_gs->gallery_thumb_height);

			if (!empty($_REQUEST['fromfolder']) && $_REQUEST['fromfolder'] == 1)
			{
				$src_dir = BASE_DIR . '/' . UPLOAD_GALLERY_DIR . '/.temp/';
				if (!file_exists($src_dir . '/') && !rmkdir($src_dir . '/', 0777))
				{
					header('Location:index.php?do=modules&action=modedit&mod=gallery&moduleaction=1');
					exit;
				}

				$htaccess_file = $src_dir . '/' . '.htaccess';
				if (!file_exists($htaccess_file))
				{
					$fp = @fopen($htaccess_file, 'w+');
					if ($fp)
					{
						fputs($fp, 'Deny from all');
						fclose($fp);
					}
				}

				if ($handle = opendir($src_dir . '/'))
				{
					while (false !== ($file = readdir($handle)))
					{
						if ($file != '.' && $file != '..')
						{
							$image_title = substr($file, 0, -4);
							$upload_file_ext = strtolower(substr($file, -4));
							$upload_filename = prepare_fname($image_title) . $upload_file_ext;

							while (file_exists($dst_dir . '/' . $upload_filename))
							{
								$upload_filename = $this->_galleryImageRename($upload_filename);
							}

							if (!empty($upload_filename) && in_array($upload_file_ext, $this->_allowed_type))
							{
								@copy($src_dir . '/' . $file, $dst_dir . '/' . $upload_filename);
								@unlink($src_dir . '/' . $file);

								$oldumask = umask(0);
								@chmod($dst_dir . '/' . $upload_filename, 0777);
								umask($oldumask);

								if ($upload_file_ext != 'video')
								{
									$this->_galleryImageRebuild($dst_dir, $upload_filename, $row->gallery_watermark);
								}

								$images[] = make_thumbnail(array('link' => $path . '/' . $upload_filename, 'size' => $size));

								$AVE_DB->Query("
									INSERT
									INTO " . PREFIX . "_modul_gallery_images
									SET
										id = '',
										gallery_id = '" . $gallery_id . "',
										image_filename = '" . addslashes($upload_filename) . "',
										image_author_id = '" . (int)$_SESSION['user_id'] . "',
										image_title = '" . addslashes($image_title) . "',
										image_file_ext = '" . addslashes($upload_file_ext) . "',
										image_description = '',
										image_date = '" . time() . "'
								");
							}
						}
					}
					closedir($handle);
				}
			}else if (!empty($_REQUEST['fromuploader']) && $_REQUEST['fromuploader'] == 1)
			{
				$src_dir = BASE_DIR . '/' . UPLOAD_GALLERY_DIR . '/.uploader/';
				if (!file_exists($src_dir . '/') && !rmkdir($src_dir . '/', 0777))
				{
					header('Location:index.php?do=modules&action=modedit&mod=gallery&moduleaction=1');
					exit;
				}

				$htaccess_file = $src_dir . '/' . '.htaccess';
				if (!file_exists($htaccess_file))
				{
					$fp = @fopen($htaccess_file, 'w+');
					if ($fp)
					{
						fputs($fp, 'Deny from all');
						fclose($fp);
					}
				}

				if ($handle = opendir($src_dir . '/'))
				{
					while (false !== ($file = readdir($handle)))
					{
						if ($file != '.' && $file != '..')
						{
							$image_title = substr($file, 0, -4);
							$upload_file_ext = strtolower(substr($file, -4));
							$upload_filename = prepare_fname($image_title) . $upload_file_ext;

							while (file_exists($dst_dir . '/' . $upload_filename))
							{
								$upload_filename = $this->_galleryImageRename($upload_filename);
							}

							if (!empty($upload_filename) && in_array($upload_file_ext, $this->_allowed_type))
							{
								@copy($src_dir . '/' . $file, $dst_dir . '/' . $upload_filename);
								@unlink($src_dir . '/' . $file);

								$oldumask = umask(0);
								@chmod($dst_dir . '/' . $upload_filename, 0777);
								umask($oldumask);

								if ($upload_file_ext != 'video')
								{
									$this->_galleryImageRebuild($dst_dir, $upload_filename, $row->gallery_watermark);
								}

								//$images[] = make_thumbnail(array('link' => $path . '/' . $upload_filename, 'size' => $_size));
								$images[] = make_thumbnail(array('size' => $admin_size, 'link' => $path . '/' . $upload_filename));

								$AVE_DB->Query("
									INSERT
									INTO " . PREFIX . "_modul_gallery_images
									SET
										id = '',
										gallery_id = '" . $gallery_id . "',
										image_filename = '" . addslashes($upload_filename) . "',
										image_author_id = '" . (int)$_SESSION['user_id'] . "',
										image_title = '" . addslashes($image_title) . "',
										image_file_ext = '" . addslashes($upload_file_ext) . "',
										image_description = '',
										image_date = '" . time() . "'
								");
							}
						}
					}
					closedir($handle);
				}
			}

			$count_files = sizeof(@$_FILES['file']['tmp_name']);
			for ($i=0;$i<$count_files;$i++)
			{
				$upload_file_ext = strtolower(substr($_FILES['file']['name'][$i], -4));
				$upload_filename = prepare_fname(substr($_FILES['file']['name'][$i], 0, -4)) . $upload_file_ext;

				if (!empty($upload_filename))
				{
					while (file_exists($dst_dir . '/' . $upload_filename))
					{
						$upload_filename = $this->_galleryImageRename($upload_filename);
					}

					if (in_array($upload_file_ext, $this->_allowed_type) )
					{
						move_uploaded_file($_FILES['file']['tmp_name'][$i], $dst_dir . '/' . $upload_filename);

						$oldumask = umask(0);
						@chmod($dst_dir . '/' . $upload_filename, 0777);
						umask($oldumask);

						if ($upload_file_ext != 'video')
						{
							$this->_galleryImageRebuild($dst_dir, $upload_filename, $row->gallery_watermark);
						}

						//$images[] = make_thumbnail(array('link' => $path . '/' . $upload_filename, 'size' => $size));
						$images[] = make_thumbnail(array('size' => $admin_size, 'link' => $path . '/' . $upload_filename));

						$AVE_DB->Query("
							INSERT
							INTO " . PREFIX . "_modul_gallery_images
							SET
								id = '',
								gallery_id = '" . $gallery_id . "',
								image_filename = '" . addslashes($upload_filename) . "',
								image_author_id = '" . (int)$_SESSION['user_id'] . "',
								image_title = '" . (isset($_POST['image_title'][$i]) ? $_POST['image_title'][$i] : '') . "',
								image_file_ext = '" . addslashes($upload_file_ext) . "',
								image_description = '" . (isset($_POST['image_description'][$i]) ? $_POST['image_description'][$i] : '') . "',
								image_date = '" . time() . "'
						");
					}
				}
			}
			$AVE_Template->assign('gallery_title', $row->gallery_title);
			$AVE_Template->assign('images', $images);
			$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_gallery_upload_form_finish.tpl'));
		}
		else
		{
			if (!is_writable($dst_dir . '/'))
			{
				$AVE_Template->assign('not_writeable', 1);
				$AVE_Template->assign('upload_dir', '/' . trim(UPLOAD_GALLERY_DIR . '/' . $row->gallery_folder, '/') . '/');
			}
			$AVE_Template->assign('gallery_title', $row->gallery_title);
			$AVE_Template->assign('allowed', $this->_allowed_type);
			$AVE_Template->assign('formaction', 'index.php?do=modules&action=modedit&mod=gallery&moduleaction=add&sub=save&id=' . $gallery_id);
			$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_gallery_upload_form.tpl'));
		}
	}

	/**
	 * Вывод списка галерей
	 *
	 * @param string $tpl_dir - путь к папке с шаблонами модуля
	 */
	function galleryListShow($tpl_dir)
	{
		global $AVE_DB, $AVE_Template;

		if (!empty($_POST['create']))
		{
			foreach ($_POST['create'] as $gallery_id)
			{
				$this->_galleryImageMove((int)$gallery_id);
			}
		}

		$limit = $this->_limit_galleries;
		$start = get_current_page() * $limit - $limit;
		$galleries = array();

		$sql = $AVE_DB->Query("
			SELECT SQL_CALC_FOUND_ROWS
				gal.*,
				COUNT(img.id) AS image_count
			FROM
				" . PREFIX . "_modul_gallery AS gal
			LEFT JOIN
				" . PREFIX . "_modul_gallery_images AS img
					ON img.gallery_id = gal.id
			GROUP BY gal.id
			ORDER BY gal.gallery_created DESC
			LIMIT " . $start . "," . $limit . "
		");

		$sql_num = $AVE_DB->Query("SELECT FOUND_ROWS()");
		$num = $sql_num->GetCell();

		while($row = $sql->FetchAssocArray())
		{
			$row['username'] = get_username_by_id($row['gallery_author_id']);
			array_push($galleries, $row);
		}

		if ($num > $limit)
		{
			$page_nav = "<li><a href=\"index.php?do=modules&action=modedit&mod=gallery&moduleaction=1&page={s}\">{t}</a></li>";
			$page_nav = get_pagination(ceil($num / $limit), 'page', $page_nav);
		}
		else
		{
			$page_nav = '';
		}
		$AVE_Template->assign('page_nav', $page_nav);

		if (!empty($_REQUEST['alert']))
		{
			$AVE_Template->assign('alert', htmlspecialchars(stripslashes($_REQUEST['alert'])));
		}
		$AVE_Template->assign('galleries', $galleries);
		$AVE_Template->assign('formaction', 'index.php?do=modules&action=modedit&mod=gallery&moduleaction=new&sub=save');
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_gallery_list.tpl'));
	}

	/**
	 * Создание галереи
	 *
	 */
	function galleryNew()
	{
		if (isset($_REQUEST['sub']) && $_REQUEST['sub'] == 'save')
		{
			global $AVE_DB;

			$cont = true;
			$alert = '';

			if (empty($_POST['gallery_title']))
			{
				$alert = '&alert=empty_gallery_title';
				$cont = false;
			}
			else
			{
				$gallery_folder = prepare_fname(stripslashes($_POST['gallery_folder']));

				if (!empty($gallery_folder))
				{
					$sql = $AVE_DB->Query("
						SELECT 1
						FROM " . PREFIX . "_modul_gallery
						WHERE gallery_folder = '" . $gallery_folder . "'
					");
					$folder_exists = $sql->GetCell();

					if ($folder_exists)
					{
						$alert = '&alert=folder_exists';
						$cont = false;

					}
				}
			}

			if ($cont)
			{
				$AVE_DB->Query("
					INSERT
					INTO " . PREFIX . "_modul_gallery
					SET
						id = '',
						gallery_folder = '" . $gallery_folder . "',
						gallery_title = '" . $_POST['gallery_title'] . "',
						gallery_description = '" . $_POST['gallery_description'] . "',
						gallery_author_id = '" . (int)$_SESSION['user_id'] . "',
						gallery_created = '" . time() . "'
				");

				if (!empty($gallery_folder))
				{
					$oldumask = umask(0);
					@mkdir(BASE_DIR . '/' . UPLOAD_GALLERY_DIR . '/' . $gallery_folder . '/', 0777);
					umask($oldumask);

				}
			}

			header('Location:index.php?do=modules&action=modedit&mod=gallery&moduleaction=1' . $alert);
			exit;
		}
	}

	/**
	 * Редактирование галереи
	 *
	 * @param string $tpl_dir - путь к папке с шаблонами модуля
	 * @param int $gallery_id - идентификатор галереи
	 */
	function galleryEdit($tpl_dir, $gallery_id)
	{
		global $AVE_DB, $AVE_Template;

		if (isset($_REQUEST['sub']) && $_REQUEST['sub'] == 'save')
		{
			$old_dir = prepare_fname(stripslashes($_REQUEST['gallery_folder_old']));
			$new_dir = prepare_fname(stripslashes($_REQUEST['gallery_folder']));

			if ($_REQUEST['gallery_title'] == '')
			{ // не указано имя галереи
				$AVE_Template->assign('empty_gallery_title', 1);
				$_REQUEST['gallery_title'] = $_REQUEST['gallery_title_old'];
			}

			if ($_REQUEST['thumb_width_old'] != $_REQUEST['gallery_thumb_width'])
			{ // изменён размер миниатюр - удаляем миниатюры
				$folder = BASE_DIR . '/' . trim(UPLOAD_GALLERY_DIR . '/' . $old_dir, '/');

				if ($old_dir != '')
				{
					rrmdir($folder . '/' . THUMBNAIL_DIR);
				}
				else
				{
					$sql = $AVE_DB->Query("
						SELECT gallery_thumb_width,gallery_thumb_method,gallery_thumb_height
						FROM " . PREFIX . "_modul_gallery
						WHERE id = '" . $gallery_id . "'
					");
					$row_gs = $sql->FetchRow();

					$size = sprintf($this->_size, $row_gs->gallery_thumb_method, $row_gs->gallery_thumb_width, $row_gs->gallery_thumb_height);

					$sql = $AVE_DB->Query("
						SELECT image_filename
						FROM " . PREFIX . "_modul_gallery_images
						WHERE gallery_id = '" . $gallery_id . "'
					");
					while ($row = $sql->FetchRow())
					{
						@unlink(make_thumbnail(array('link' => $folder . '/' . $row->image_filename, 'size' => $size)));
					}

					@rmdir($folder . '/' . THUMBNAIL_DIR);
				}
			}

			if ($old_dir != $new_dir)
			{ // изменен путь к файлам галереи - перемещаем в новое место
				$this->_galleryImageMove($gallery_id, $old_dir, $new_dir);
			}

			$AVE_DB->Query("
				UPDATE " . PREFIX . "_modul_gallery
				SET
					gallery_title = '" . $_REQUEST['gallery_title'] . "',
					gallery_description = '" . $_REQUEST['gallery_description'] . "',
					gallery_thumb_width = '" . (int)$_REQUEST['gallery_thumb_width'] . "',
					gallery_thumb_height = '" . (int)$_REQUEST['gallery_thumb_height'] . "',
					gallery_thumb_method = '" . $_REQUEST['gallery_thumb_method'] . "',
					gallery_image_on_line = '" . (int)$_REQUEST['gallery_image_on_line'] . "',
					gallery_image_on_page = '" . (int)$_REQUEST['gallery_image_on_page'] . "',
					gallery_watermark = '" . $_REQUEST['gallery_watermark'] . "',
					gallery_folder = '" . $new_dir . "',
					gallery_orderby = '" . $_REQUEST['gallery_orderby'] . "',
					gallery_script = '" . $_REQUEST['gallery_script'] . "',
					gallery_image_template = '" . $_REQUEST['gallery_image_template'] . "',
					gallery_sepp_line = '" . $_REQUEST['gallery_sepp_line'] . "'
				WHERE
					id = '" . $gallery_id . "'
			");

//			header('Location:index.php?do=modules&action=modedit&mod=gallery&moduleaction=editgallery&id=' . $gallery_id);
			header('Location:' . get_redirect_link('sub'));
			exit;
		}

		$sql = $AVE_DB->Query("
			SELECT *
			FROM " . PREFIX . "_modul_gallery
			WHERE id = '" . $gallery_id . "'
		");
		$row = $sql->FetchAssocArray();
		$blanc = 'templates/' . $_SESSION['admin_theme'] . '/images/blanc.gif';

		$AVE_Template->assign('blank', $blanc);
		$AVE_Template->assign('gallery', $row);
		$AVE_Template->assign('content', $AVE_Template->fetch($tpl_dir . 'admin_gallery_edit.tpl'));
	}

	/**
	 * Удаление галереи
	 *
	 * @param int $gallery_id - идентификатор галереи
	 */
	function galleryDelete($gallery_id)
	{
		global $AVE_DB;

		$sql = $AVE_DB->Query("
			SELECT
				gallery_folder,
				gallery_thumb_width
			FROM " . PREFIX . "_modul_gallery
			WHERE id = '" . $gallery_id . "'
		");
		$row = $sql->fetchRow();

		if ($row == false) return;

		if (! empty($row->gallery_folder))
		{
			rrmdir(BASE_DIR . '/' . UPLOAD_GALLERY_DIR . '/' . $row->gallery_folder . '/');
		}
		else
		{
			$size = sprintf($this->_size, $row->gallery_thumb_method, $row->gallery_thumb_width, $row->gallery_thumb_height);

			$sql = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_gallery_images
				WHERE gallery_id = '" . $gallery_id . "'
			");
			while ($row = $sql->FetchRow())
			{
				$file = BASE_DIR . '/' . UPLOAD_GALLERY_DIR . '/' . $row->image_filename;
				@unlink($file);
				@unlink(make_thumbnail(array('link' => $file, 'size' => $size)));
			}
		}
		$AVE_DB->Query("DELETE FROM " . PREFIX . "_modul_gallery WHERE id = '" . $gallery_id . "'");
		$AVE_DB->Query("DELETE FROM " . PREFIX . "_modul_gallery_images WHERE gallery_id = '" . $gallery_id . "'");

		header('Location:index.php?do=modules&action=modedit&mod=gallery&moduleaction=1');
		exit;
	}

/**
 *	ВНУТРЕННИЕ МЕТОДЫ
 */

	/**
	 * тип видео-файла по расширению
	 *
	 * @param string $ext
	 * @return string
	 */
	function _galleryMediaTypeGet($ext)
	{
		switch($ext)
		{
			case '.avi':
			case '.wmv':
			case '.wmf':
			case '.mpg': $type = 'avi'; break;
			case '.mov': $type = 'mov'; break;
		}

		return $type;
	}

	/**
	 * тип файла по расширению
	 *
	 * @param string $ext
	 * @return string
	 */
	function _galleryFileTypeGet($ext)
	{
		switch($ext)
		{
			case '.avi':
			case '.mov':
			case '.wmv':
			case '.wmf':
			case '.mpg': $type = 'video'; break;
			case '.jpg':
			case 'jpeg':
			case '.jpe': $type = 'jpg'; break;
			case '.png': $type = 'png'; break;
			case '.gif': $type = 'gif'; break;
		}

		return $type;
	}

	/**
	 * Формирование уникального имени файла
	 *
	 * @param string $file_name - имя файла
	 * @return string
	 */
	function _galleryImageRename($file_name)
	{
		mt_rand();
		$pref = rand(1, 999);

		return $pref . '_' . $file_name;
	}

	/**
	 * Изменение размеров и наложение водяного знака при загрузке изображений
	 *
	 * @param string $dst_dir - путь к папке для загрузки
	 * @param string $upload_filename - имя загружаемого файла
	 * @param string $watermark - водяной знак
	 */
	function _galleryImageRebuild($dst_dir, $upload_filename, $watermark = '')
	{
		global $Image_Toolbox;

		if (!list($width, $height) = @getimagesize($dst_dir . '/' . $upload_filename)) return;

		$need_resize = false;
		$need_save = false;

		if (isset($_REQUEST['shrink']) && is_numeric($_REQUEST['shrink']) && $_REQUEST['shrink'] < 100)
		{
			$width = round($width * $_REQUEST['shrink'] / 100);
			$height = round($height * $_REQUEST['shrink'] / 100);

			$need_resize = true;
		}

		if (isset($_REQUEST['maxsize']) && is_numeric($_REQUEST['maxsize']) && $_REQUEST['maxsize'] > 10
			&& max(array($width, $height)) > $_REQUEST['maxsize'])
		{
			$width = ($width > $height) ? round($_REQUEST['maxsize']) : 0;
			$height = ($width > $height) ? 0 : round($_REQUEST['maxsize']);

			$need_resize = true;
		}

		$Image_Toolbox->newImage($dst_dir . '/' . $upload_filename);

		// Изменяем размер
		if ($need_resize)
		{
			$Image_Toolbox->newOutputSize((int)$width, (int)$height);

			$need_save = true;
		}

		// Добавляем водяной знак
		if (!empty($watermark))
		{
			if (is_file(BASE_DIR . '/' . $watermark))
			{
				$Image_Toolbox->addImage(BASE_DIR . '/' . $watermark);
				$Image_Toolbox->blend('right -10', 'bottom -10', IMAGE_TOOLBOX_BLEND_COPY, 70);
			}
			else
			{
				$Image_Toolbox->addText($watermark, BASE_DIR . '/inc/fonts/ft16.ttf', 16, '#709536', 'right -10', 'bottom -10');
			}

			$need_save = true;
		}

		if ($need_save) $Image_Toolbox->save($dst_dir . '/' . $upload_filename);

	    $oldumask = umask(0);
		chmod($dst_dir . '/' . $upload_filename, 0777);
	    umask($oldumask);
	}

	/**
	 * Перемещение изображений галереи
	 *
	 * @param int $gallery_id - идентификатор галереи
	 * @param string $src_dir - директория источник
	 * @param string $dst_dir - директория назначения
	 */
	function _galleryImageMove($gallery_id, $src_dir = '', $dst_dir = '')
	{
		global $AVE_DB;

		$sql = $AVE_DB->Query("
			SELECT
				gallery_title,
				gallery_folder,
				gallery_thumb_method,
				gallery_thumb_width,
				gallery_thumb_height
			FROM " . PREFIX . "_modul_gallery
			WHERE id = '" . $gallery_id . "'
		");
		$row = $sql->FetchRow();

		if ($row == false) return;

		$size = sprintf($this->_size, $row->gallery_thumb_method, $row->gallery_thumb_width, $row->gallery_thumb_height);

		if (empty($src_dir) && empty($dst_dir))
		{
			$src_dir = prepare_fname($row->gallery_folder);
			$dst_dir = $row->gallery_title == '' ? 'gal_' . $gallery_id : prepare_fname($row->gallery_title);
		}
		$src_path = rtrim(BASE_DIR . '/' . trim(UPLOAD_GALLERY_DIR . '/' . $src_dir, '/')) . '/';

		if (! file_exists($src_path . '/')) return;

		$dst_path = rtrim(BASE_DIR . '/' . trim(UPLOAD_GALLERY_DIR . '/' . $dst_dir, '/')) . '/';

		if ($src_dir != '')
		{
			if (rename($src_path, $dst_path))
			{
				$AVE_DB->Query("
					UPDATE " . PREFIX . "_modul_gallery
					SET gallery_folder = '" . addslashes($dst_dir) . "'
					WHERE id = '" . $gallery_id . "'
				");

				return;
			}
		}

		if (! file_exists($dst_path . '/') && ! mkdir($dst_path . '/', 0777)) return;

		if (! is_writable($dst_path . '/')) return;

		$AVE_DB->Query("
			UPDATE " . PREFIX . "_modul_gallery
			SET gallery_folder = '" . addslashes($dst_dir) . "'
			WHERE id = '" . $gallery_id . "'
		");

		$sql = $AVE_DB->Query("
			SELECT image_filename
			FROM " . PREFIX . "_modul_gallery_images
			WHERE gallery_id = '" . $gallery_id . "'
		");
		while ($row = $sql->FetchRow())
		{
		    $file = $src_path . '/' . $row->image_filename;
			@copy($file, $dst_path . '/' . $row->image_filename);

			$oldumask = umask(0);
			chmod($dst_path . '/' . $row->image_filename, 0777);
		    umask($oldumask);

		    @unlink($file);
			@unlink(make_thumbnail(array('link' => $file, 'size' => $size)));
		}

		@rmdir($src_path . '/' . THUMBNAIL_DIR);
	}

	/**
	 * Метод, предназначенный для создания копии Галереи
	 *
	 * @param int $gallery_id идентификатор Галереи
	 */
		function galleryCopy($gallery_id)
		{
		global $AVE_DB;
			// Выполняем запрос к БД на получение информации о копиремой галереи
			$sql = $AVE_DB->Query("
				SELECT *
				FROM " . PREFIX . "_modul_gallery
				WHERE id = '" . $gallery_id . "'
			");
			$row = $sql->fetchRow();

			//if ($row == false) return;

			$gallery_title = (empty($_REQUEST['gallery_title'])) ? '' . addslashes($row->gallery_title) . '' : $_REQUEST['gallery_title'];

			// Выполняем запрос к БД на добавление новой галереи на основании полученных ранее данных
			$AVE_DB->Query("
			INSERT " . PREFIX . "_modul_gallery
			SET
				gallery_title           = '" . $gallery_title . "',
				gallery_description  	= '" . $row->gallery_description . "',
				gallery_author_id       = '" . (int)$_SESSION['user_id'] . "',
				gallery_created   		= '" . time() . "',
				gallery_thumb_width		= '" . $row->gallery_thumb_width . "',
				gallery_thumb_height		= '" . $row->gallery_thumb_height . "',
				gallery_thumb_method		= '" . $row->gallery_thumb_method . "',
				gallery_image_on_line	= '" . $row->gallery_image_on_line . "',
				gallery_image_on_page	= '" . $row->gallery_image_on_page . "',
				gallery_watermark		= '" . $row->gallery_watermark . "',
				gallery_folder			= '',
				gallery_orderby			= '" . addslashes($row->gallery_orderby) . "',
				gallery_script	   		= '" . addslashes($row->gallery_script) . "',
				gallery_image_template 	= '" . addslashes($row->gallery_image_template) . "',
				gallery_sepp_line		= '" . addslashes($row->gallery_sepp_line) . "'
			");

			// Сохраняем системное сообщение в журнал
			reportLog((int)$_SESSION['user_id'] . ' - создал копию галерии (' . $row->gallery_title . ')', 2, 2);
			// Выполянем переход к списку галерей
			header('Location:index.php?do=modules&action=modedit&mod=gallery&moduleaction=1&cp=' . SESSION);
			exit;
		}

}

?>