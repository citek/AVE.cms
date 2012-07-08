<script type="text/javascript" src="http://bp.yahooapis.com/2.4.21/browserplus-min.js"></script>
<script type="text/javascript" src="{$tpl_dir}/js/uploader/jquery.plupload.queue.js"></script>
<script type="text/javascript" src="{$tpl_dir}/js/uploader/plupload.full.js"></script>

<script language="javascript">
{literal}
$(document).ready(function(){
	//===== File uploader =====//

	$("#uploader").pluploadQueue({
		runtimes : 'html5,flash',
		url : ave_path+'modules/gallery/upload.php',
		max_file_size : '20mb',
		unique_names : true,
		filters : [
			{title : "Image files", extensions : "jpg,jpeg,jpe,gif,png"},
			{title : "Video files", extensions : "avi,mov,wmv,wmf"}
		],
        // Flash settings
        flash_swf_url : ave_admintpl+'/js/uploader/plupload.flash.swf',


	});

	// Client side form validation
	$('form').submit(function(e) {
        var uploader = $('#uploader').pluploadQueue();
        // Files in queue upload them first

            // When all files are uploaded submit form
            uploader.bind('StateChanged', function() {
                if (uploader.files.length === (uploader.total.uploaded + uploader.total.failed)) {
                    $('form')[0].submit();
                }
            });
            uploader.start();

        return false;
    });

});
{/literal}
</script>

<div class="title"><h5>{#Upload#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#UploadInfo#} <strong>{foreach from=$allowed item=a}{$a|escape} {/foreach}</strong>
    </div>
</div>

<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><a href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=1&cp={$sess}">{#ModName#}</a></li>
	        <li>{#Upload#}</li>
	        <li><strong class="code">{$gallery_title|escape}</strong></li>
	    </ul>
	</div>
</div>


{if $not_writeable == 1}
		<ul class="messages">
			<li class="highlight red">{#ErrorFolderStart#}{$upload_dir|escape}{#ErrorFolderEnd#}</li>
		</ul>
{else}


<form class="mainForm" method="post" action="{$formaction}" enctype="multipart/form-data">
<input name="fromuploader" type="hidden" id="fromuploader" value="1" />
<fieldset>
<div class="widget">
      <div class="head">
        <h5>{#Upload#}</h5>
        <div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=editgallery&id={$smarty.request.id|escape}&cp={$sess}">{#EditGallery#}</a></div>
        <div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=showimages&id={$smarty.request.id|escape}&cp={$sess}&compile=1">{#ImageView#}</a></div>
      </div>
      <div id="uploader" style="position: relative;"></div>
</div>
</fieldset>

<div class="widget">
      <div class="head">
            <h5>{#Upload#}</h5>
      </div>

		<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
			<tr class="noborder">
				<td width="200"><strong>{#Shrink#}</strong></td>
				<td>
					<select name="shrink" id="shrink">
						<option value="100">{#To100#}</option>
						<option value="75">{#To75#}</option>
						<option value="50">{#To50#}</option>
						<option value="25">{#To25#}</option>
					</select>
				</td>
			</tr>

			<tr>
				<td width="200"><strong>{#MaxSize#}</strong></td>
				<td>
					<input name="maxsize" type="text" value="2000" maxlength="4" size="4" style="width: 50px;" />&nbsp;px
				</td>
			</tr>

			<tr>
				<td width="200"><strong>{#LoadFromFolder#}</strong></td>
				<td>
					<input name="fromfolder" type="checkbox" id="fromfolder" value="1" />
				</td>
			</tr>

			<tr>
				<td colspan="2">
					<input type="submit" class="basicBtn" value="{#ButtonSave#}" />
				</td>
			</tr>
		</table>
    <div class="fix"></div>
</div>
	</form>
{/if}