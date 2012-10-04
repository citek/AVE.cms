<script language="javascript">
$(document).ready(function(){ldelim}

    $(".ConfirmClear").click(function(e){ldelim}
		e.preventDefault();
		var href = $(this).attr('href');
		var title = '{#SEARCH_DELETE_ITEMS#}';
		var confirm = '{#SEARCH_DELETE_CONFIRM#}';
		jConfirm(
				confirm,
				title,
				function(b){ldelim}
					if (b){ldelim}
						window.location = href;
					{rdelim}
				{rdelim}
			);
	{rdelim});

{rdelim});

</script>

<div class="title"><h5>{#SEARCH_MODULE_NAME#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#SEARCH_MODULE_DESCRIPTION#}
    </div>
</div>

<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li><a href="index.php?do=modules&amp;cp={$sess}">{#MODULES_SUB_TITLE#}</a></li>
	        <li>{#SEARCH_MODULE_NAME#}</li>
	    </ul>
	</div>
</div>

<div class="widget first">
        	<div class="head"><h5 class="iFrames">{#SEARCH_MODULE_NAME#}</h5></div>
            <table cellpadding="0" cellspacing="0" width="100%" class="display" id="dinamTable">
            	<thead>
                	<tr>
                        <th width="60%">{#SEARCH_WORD#}</th>
                        <th width="20%">{#SEARCH_QUERIES#}</th>
                        <th width="20%">{#SEARCH_FOUND_DOCS#}</th>
                    </tr>
                </thead>
                <tbody>
        {foreach from=$items item=item}
					<tr class="gradeA">
                        <td align="center"><strong>{$item->search_query|escape}</strong></td>
                        <td align="center">{$item->search_count}</td>
                        <td align="center">{$item->search_found}</td>
					</tr>
         {/foreach}
                </tbody>
            </table>
</div>
<div class="widget" style="margin-top: 0px;">
    <div class="body aligncenter">
		<form id="#form_submit" method="post" action="index.php?do=modules&action=modedit&mod=search&moduleaction=delwords&cp={$sess}">
			<input href="index.php?do=modules&action=modedit&mod=search&moduleaction=delwords&cp={$sess}" type="button" class="basicBtn ConfirmClear" value="{#SEARCH_DELETE_ITEMS#}" />
		</form>
    </div>
</div>


