<div class="title"><h5>{#UploadProg#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#UploadInfo#}
    </div>
</div>

<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><a href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=1&cp={$sess}">{#ModName#}</a></li>
	        <li>{#UploadProg#}</li>
	        <li><strong class="code">{$gallery_title|escape}</strong></li>
	    </ul>
	</div>
</div>

<div class="widget">
      <div class="head">
            <h5>{#UploadProgT#}</h5>
            <div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=add&id={$smarty.request.id|escape}&cp={$sess}">{#AddnewImages#}</a></div>
			<div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=showimages&id={$smarty.request.id|escape}&cp={$sess}&compile=1">{#ImageView#}</a></div>
			<div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=editgallery&id={$smarty.request.id|escape}&cp={$sess}">{#EditGallery#}</a></div>
      </div>

	<div class="rowElem">
        <div style="padding:12px;height:200px;overflow:auto;border:1px solid #ccc">
        	{foreach from=$images item=image}<img src="{$image}" align="left" style="margin:5px" />{/foreach}
        </div>
	</div>

	<div class="fix"></div>
</div>

