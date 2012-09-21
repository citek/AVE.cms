<?php
// выясняем номер текущей ревизии
define('BILD_VERSION',file_get_contents(BASE_DIR . '/inc/current_revision.txt'));
if (SVN_ACTIVE == true) {
	include_once("phpsvnclient.php");
	$svn =  new phpsvnclient(SVN_URL);
	$svn -> setAuth(SVN_LOGIN,SVN_PASSWORD);
	// выясняем номер последней ревизии
	$last_rev = $svn -> getVersion();
	if ($last_rev > BILD_VERSION) {
		$log_svn_orig = $svn -> getRepositoryLogs("",(int)BILD_VERSION+1,$last_rev);
		$log_svn = array();
		foreach ($log_svn_orig as $revision)
		{
			if (preg_match("/%num%/i",SVN_LINK))
			{
				$revision["url"] = @str_replace("%num%",$revision["version"],SVN_LINK);
			}
			else
			{
				$revision["url"] = SVN_LINK . $revision["version"];
			}
			$log_svn[] = $revision;
		}
		// переворачиваем массив, чтобы последние ревизии были сверху
		$log_svn = array_reverse($log_svn);
		$AVE_Template->assign('log_svn',$log_svn);
		$AVE_Template->assign('svn_url',SVN_URL);
	}
}
?>