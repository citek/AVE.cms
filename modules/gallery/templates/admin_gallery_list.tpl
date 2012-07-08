<script type="text/javascript" language="JavaScript">
$(document).ready(function(){ldelim}

	$(".CopyGallery").click( function(e) {ldelim}
		e.preventDefault();
		var href = $(this).attr('href');
		var title = '{#GalleryCopy#}';
		var text = '{#GalleryCopyT#}';
		jPrompt(text, '', title, function(b){ldelim}
					if (b){ldelim}
						$.alerts._overlay('show');
        				window.location = href + '&gallery_title=' + b;
					{rdelim}
				{rdelim}
			);
	{rdelim});

		$(".AddGallery").click( function(e) {ldelim}
			e.preventDefault();
			var user_group = $('#add_gallery #gallery_title').fieldValue();
			var title = '{#NewGallery#}';
			var text = '{#EmptyGalleryTitle#}';
			if (user_group == ""){ldelim}
				jAlert(text,title);
			{rdelim}else{ldelim}
				$.alerts._overlay('show');
				$("#add_gallery").submit();
			{rdelim}
		{rdelim});

{rdelim});
</script>
<div class="title"><h5>{#ModName#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#ModTitle#}
    </div>
</div>


<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li>{#ModName#}</li>
	    </ul>
	</div>
</div>


<div class="widget first">
	<ul class="tabs">
	    <li class="activeTab"><a href="#tab1">{#GalleryList#}</a></li>
	    <li class=""><a href="#tab2">{#NewGallery#}</a></li>
	</ul>

		<div class="tab_container">
			<div id="tab1" class="tab_content" style="display: block;">
<form action="" method="post" class="mainForm">
<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
	<col width="20">
    <col>
    <col width="150">
    <col width="150">
    <col width="200">
    <col width="150">
    <col width="100">
	<col width="20">
	<col width="20">
    <col width="20">
	<col width="20">
	<col width="20">
    <thead>
    <tr>
        <td><div align="center"><a href="javascript:void(0);" class="toprightDir icon_sprite ico_info" title="{#CheckboxCreate#}"></a></div></td>
    	<td>{#GalleryTitle#}</td>
    	<td>{#CpTag#}</td>
    	<td>{#GalleryAuthor#}</td>
    	<td>{#Folder#}</td>
    	<td>{#Gcreated#}</td>
    	<td>{#IncImages#}</td>
    	<td colspan="5">{#Actions#}</td>
    </tr>
    </thead>
    <tbody>
			<form action="" method="post" class="mainForm">
            {foreach from=$galleries item=gallery}
                <tr>
					<td>
						<input type="checkbox" name="create[]" value="{$gallery.id}" {if $gallery.gallery_folder != ''}disabled="disabled"{/if} />
  					</td>
					<td>
						{if $gallery.image_count > 0}
							<strong class="docname"><a class="topDir" title="{#ImageView#}" href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=showimages&id={$gallery.id}&cp={$sess}&compile=1">{$gallery.gallery_title|escape}</a></strong>
						{else}
							<strong>{$gallery.gallery_title|escape}</strong>
						{/if}
					</td>
					<td>
						<div class="pr12"><input name="textfield" type="text" readonly value="[mod_gallery:{$gallery.id}]" size="17" /></div>
					</td>
					<td align="center">
						<a class="topDir" title="{#UserProfile#}" href="index.php?do=user&action=edit&id={$gallery.gallery_author_id}&cp={$sess}">{$gallery.username|escape}</a>
					</td>
					<td align="center">{$gallery.gallery_folder|escape}</td>
					<td align="center"><span class="date_text dgrey">{$gallery.gallery_created|date_format:$TIME_FORMAT|pretty_date}</span></td>
					<td>
						<div align="center">
							{if $gallery.image_count > 0}
								<strong><a class="topDir" title="{#ImageView#}" href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=showimages&id={$gallery.id}&cp={$sess}">{$gallery.image_count}</a></strong>
							{else}-{/if}
						</div>
					</td>
					<td>
						<a class="topleftDir icon_sprite ico_look" title="{#ImageView#}" href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=showimages&id={$gallery.id}&cp={$sess}&compile=1"></a>
					</td>
					<td>
						<a class="topleftDir icon_sprite ico_add" title="{#AddnewImages#}" href="index.php?do=modules&amp;action=modedit&amp;mod=gallery&amp;moduleaction=add&amp;id={$gallery.id}&amp;cp={$sess}"></a>
					</td>
					<td>
						<a class="topleftDir icon_sprite ico_setting" title="{#EditGallery#}" href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=editgallery&id={$gallery.id}&cp={$sess}"></a>
					</td>
					<td>
						<a class="topleftDir icon_sprite ico_copy CopyGallery" title="{#CopyGallery#}" href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=copygallery&id={$gallery.id}&cp={$sess}"></a>
					</td>
					<td>
						<a class="topleftDir ConfirmDelete icon_sprite ico_delete" title="{#DeleteGallery#}" dir="{#DeleteGallery#}" name="{#DeleteGalleryC#}" href="index.php?do=modules&action=modedit&mod=gallery&moduleaction=delgallery&id={$gallery.id}&cp={$sess}"></a>
					</td>
				</tr>
            {/foreach}
				{if !$galleries}
				<tr>
					<td colspan="9">
					<ul class="messages">
						<li class="highlight yellow">{#GallerryNoItems#}</li>
					</ul>
					</td>
				</tr>
				{/if}
			</form>
    </tbody>
</table>
</form>
{if $galleries}
<div class="rowElem">
	<input class="basicBtn" type="submit" value="{#CreateFolder#}" />
</div>
{/if}
            </div>

            <div id="tab2" class="tab_content" style="display: none;">
			    <form id="add_gallery" action="{$formaction}" method="post" class="mainForm">
                	<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic mainForm">
                		<tr class="noborder">
                			<td width="180">{#GalleryTitle#}</td>
                			<td>
                				<input placeholder="{#GalleryTitle#}" name="gallery_title" type="text" id="gallery_title" value="" style="width:300px" />
                			</td>
                		</tr>

                		<tr>
                			<td width="180">{#GalleryDesc#}</td>
                			<td>
                				<textarea placeholder="{#GalleryDesc#}" name="gallery_description" cols="50" rows="4" id="gallery_description" style="width:300px"></textarea>
                			</td>
                		</tr>
                		<tr>
                			<td width="180">{#GalleryFolder#}</td>
                			<td>
                				<input placeholder="{#GalleryFolderP#}" name="gallery_folder" type="text" id="gallery_folder" size="40" value="" style="width:300px" />
                			</td>
                		</tr>

                		<tr>
                			<td colspan="2">
                				<input type="submit" class="basicBtn AddGallery" value="{#ButtonAdd#}" />
                			</td>
                		</tr>
                	</table>
			    </form>
			</div>

        </div>
<div class="fix"></div>
</div>


{if $page_nav}
	<div class="pagination">
	<ul class="pages">
		{$page_nav}
	</ul>
	</div>
{/if}



{if $alert == "folder_exists"}
	<script type="text/javascript" language="JavaScript">
		$.jGrowl("{#FolderExists#}");
	</script>
{/if}