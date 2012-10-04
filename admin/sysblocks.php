<?php

/**
 * AVE.cms
 *
 * @package AVE.cms
 * @subpackage admin
 * @filesource
 */

if (!defined('ACP'))
{
	header('Location:index.php');
	exit;
}

global $AVE_DB, $AVE_Template;

require(BASE_DIR . '/class/class.sysblocks.php');
$AVE_SysBlock = new AVE_SysBlock;

$AVE_Template->config_load(BASE_DIR . '/admin/lang/' . $_SESSION['admin_language'] . '/sysblocks.txt', 'sysblocks');

switch ($_REQUEST['action'])
{
	case '':
		if (check_permission_acp('sysblocks'))
		{
			$AVE_SysBlock->sys_blockList();
		}
		break;

	case 'new':
		if (check_permission_acp('sysblocks'))
		{
			$AVE_SysBlock->sys_blockNew();
		}
		break;

	case 'edit':
		if (check_permission_acp('sysblocks'))
		{
			$AVE_SysBlock->sys_blockEdit(isset($_REQUEST['id']) ? $_REQUEST['id'] : null);
			if(isset($_REQUEST['id'])) unlink(BASE_DIR.'/cache/sql/sysblock-'.$_REQUEST['id'].'.cache');
		}
		break;

	case 'save':
		if (check_permission_acp('sysblocks'))
		{
			$AVE_SysBlock->sys_blockSave(isset($_REQUEST['id']) ? $_REQUEST['id'] : null);
			if(isset($_REQUEST['id'])) unlink(BASE_DIR.'/cache/sql/sysblock-'.$_REQUEST['id'].'.cache');
		}
		break;

	case 'del':
		if (check_permission_acp('sysblocks'))
		{
			$AVE_SysBlock->sys_blockDelete($_REQUEST['id']);
			if(isset($_REQUEST['id'])) unlink(BASE_DIR.'/cache/sql/sysblock-'.$_REQUEST['id'].'.cache');
		}
		break;
}
?>