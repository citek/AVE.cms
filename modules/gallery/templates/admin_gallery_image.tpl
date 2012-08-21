<script language="Javascript" type="text/javascript">
$(document).ready(function(){ldelim}

	$("#selall").click(function(){ldelim}
		if ($("#selall").is(":checked")){ldelim}
			$(".checkbox").removeAttr("checked");
			$("#Fields a.jqTransformCheckbox").removeClass("jqTransformChecked");
		{rdelim}else{ldelim}
	   		$(".checkbox").attr("checked","checked");
			$("#Fields a.jqTransformCheckbox").addClass("jqTransformChecked");
		{rdelim}
	{rdelim});

    $(".ConfirmDelete").click(function(e){ldelim}
		e.preventDefault();
		var href = $(this).attr('href');
		var title = '{#DOC_FINAL_DELETE#}';
		var confirm = '{#DOC_FINAL_CONFIRM#}';
		jConfirm(
				confirm,
				title,
				function(b){ldelim}
					if (b){ldelim}
						$.alerts._overlay('show');
						window.location = href;
					{rdelim}
				{rdelim}
			);
	{rdelim});

    $(".galleryimages a").hover( function(){ldelim}
        $(this).children("img").animate({ldelim} opacity: 0.5 {rdelim}, "fast");
    {rdelim}, function(){ldelim}
        $(this).children("img").animate({ldelim} opacity: 1.0 {rdelim}, "fast");
    {rdelim});

{rdelim});
</script>

<div class="title"><h5>{#Overview#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#OverviewT#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li><a href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=1&cp={$sess}">{#ModName#}</a></li>
	        <li>{#Overview#}</li>
	        <li><strong class="code">{$gallery_title}</strong></li>
	    </ul>
	</div>
</div>


{if $page_nav}
	<div class="pagination">
	<ul class="pages">
		{$page_nav}
	</ul>
	</div>
{/if}

<div class="widget first">
<div class="head">
<h5 class="iFrames">{#Overview#}</h5>
    <div class="num"><a class="basicNum" href="index.php?do=modules&amp;action=modedit&amp;mod=gallery&amp;moduleaction=add&amp;id={$smarty.request.id|escape}&amp;cp={$sess}">{#AddnewImages#}</a></div>
    <div class="num"><a class="basicNum" href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=editgallery&id={$smarty.request.id|escape}&cp={$sess}">{#EditGallery#}</a></div>
</div>

<form name="kform" class="mainForm" method="post" action="index.php?do=modules&action=modedit&mod=gallery&moduleaction=showimages&id={$smarty.request.id|escape}&cp={$sess}&sub=save&page={$smarty.request.page|escape}">
	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic" id="Fields">
		<col width="20">
		<col width="50">
		<col width="120">
		<col width="366">
        <thead>
		<tr>
			<td align="center"><div align="center"><input title="{#MarAllDel#}" type="checkbox" id="selall" value="1" /></div></td>
            <td align="center">{#Position#}</td>
			<td>{#FilePrev#}</td>
			<td>{#FileTitle#} / {#FileDesc#}</td>
			<td>{#MoreInfos#}</td>
		</tr>
        </thead>
		{foreach from=$images item=image}
			<tr>

				<td valign="top">
					<input type="hidden" value="{$image.id}" name="gimg[]" />
					<input type="hidden" value="{$image.image_filename|escape}" name="datei[{$image.id}]" />
					<input title="{#MarDel#}" name="del[{$image.id}]" class="checkbox" type="checkbox" id="del[{$image.id}]" value="1" />
				</td>

				<td valign="top">
					<div class="pr12"><input name="image_position[{$image.id}]" type="text" style="width:30px" id="image_position[{$image.id}]" value="{$image.image_position}"></div>
				</td>

				<td valign="top" class="galleryimages">
					<a href="{$image.original}" target="_blank">
						<img src="{$image.thumbnail}" width="100" alt="" border="0" />
					</a>
				</td>

				<td valign="top">
					<input placeholder="{#FileTitle#}" name="image_title[{$image.id}]" type="text" style="width:350px" id="image_title[{$image.id}]" value="{$image.image_title|escape}">
                    <br /><br />
					<textarea placeholder="{#FileDesc#}" name="image_description[{$image.id}]" cols="40" rows="4" style="width:350px" id="image_description[{$image.id}]">{$image.image_description|escape}</textarea>
				</td>

				<td valign="top">
					<strong>{#Uploader#}</strong>: {$image.image_author|escape}<br />
					<strong>{#UploadOn#}</strong>: {$image.image_date|date_format:$TIME_FORMAT|pretty_date}<br />
                    <strong>{#Filename#}</strong>: {$image.image_filename|escape}<br />
					<strong>{#Filesize#}</strong>: {$image.image_size} kb
				</td>
			</tr>
		{/foreach}

		<tr>
			<td colspan="5">
				<input class="basicBtn" type="submit" value="{#ButtonSave#}" />
			</td>
		</tr>
	</table>
</form>

</div>

{if $page_nav}
	<div class="pagination">
	<ul class="pages">
		{$page_nav}
	</ul>
	</div>
{/if}
