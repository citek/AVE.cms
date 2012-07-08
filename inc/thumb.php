<?php

/**
 * Creates directory
 *
 * @param  string  $path Path to create
 * @param  integer $mode Optional permissions
 * @return boolean Success
 */
function _mkdir($path, $mode = 0777)
{
	$old = umask(0);
	$res = @mkdir($path, $mode);
	umask($old);

	return $res;
}

/**
 * Creates directories recursively
 *
 * @param  string  $path Path to create
 * @param  integer $mode Optional permissions
 * @return boolean Success
 */
function rmkdir($path, $mode = 0777)
{
	return is_dir($path) || (mkdir(dirname($path), $mode) && _mkdir($path, $mode));
}

require('config.inc.php');

define('MAX_SIZE', 600);

$allowedExt = array('jpg', 'jpeg', 'png', 'gif');

list(, $thumbPath) = explode('/' . UPLOAD_DIR . '/', dirname($_SERVER['REQUEST_URI']), 2);

$lenThumbDir = strlen(THUMBNAIL_DIR);
if ($lenThumbDir && substr($thumbPath, -$lenThumbDir) != THUMBNAIL_DIR) exit(0);

$baseDir = str_replace("\\", "/", dirname(dirname(__FILE__)));
$thumbPath = $baseDir . '/' . UPLOAD_DIR . '/' . $thumbPath;
$imagePath = $lenThumbDir ? dirname($thumbPath) : $thumbPath;

$thumbName = basename($_SERVER['REQUEST_URI']);
$nameParts = explode('.', $thumbName);
$countParts = count($nameParts);

if ($countParts < 2 || !in_array(strtolower(end($nameParts)), $allowedExt)) exit(0);

$matches = array();
preg_match('/-(r|c|f)(\d+)x(\d+)(r)*$/i', $nameParts[$countParts-2], $matches);

if (!isset($matches[0]))
{
	header($_SERVER['SERVER_PROTOCOL'] . ' 404 Not Found');
	exit(0);
}

if (isset($matches[4]))
{
	list($size, $method, $width, $height, $rotate) = $matches;
}
else
{
	list($size, $method, $width, $height) = $matches;
	$rotate = false;
}

$nameParts[$countParts-2] = substr($nameParts[$countParts-2], 0, -strlen($size));
$imageName = implode('.', $nameParts);

$save = true;
if (!file_exists("$imagePath/$imageName"))
{
	header($_SERVER['SERVER_PROTOCOL'] . ' 404 Not Found');

	$imageName = 'noimage.gif';
	if (!file_exists("$imagePath/$imageName"))
	{
		$imagePath = $baseDir . '/' . UPLOAD_DIR . '/images';
	}
	if (!file_exists("$imagePath/$imageName")) exit(0);

	$save = false;
}

if ($width > MAX_SIZE) $width = MAX_SIZE;
if ($height > MAX_SIZE) $height = MAX_SIZE;

require '../class/class.thumbnail.php';

$thumb = new Image_Toolbox("$imagePath/$imageName");

switch ($method)
{
	case 'r':
		$thumb->newOutputSize((int)$width, (int)$height, 0, (boolean)$rotate);
		break;

	case 'c':
		$thumb->newOutputSize((int)$width, (int)$height, 1, (boolean)$rotate);
		break;

	case 'f':
		$thumb->newOutputSize((int)$width, (int)$height, 2, false, '#ffffff');
		break;
}

$thumb->output();

if ($save)
{
	if (!file_exists($thumbPath) && !mkdir($thumbPath, 0777)) exit(0);

	if ($thumb->save("$thumbPath/$thumbName"))
	{
		$old = umask(0);
		chmod("$thumbPath/$thumbName", 0777);
		umask($old);
	}
}

?>