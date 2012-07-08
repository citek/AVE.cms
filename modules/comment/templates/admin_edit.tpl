<script type="text/javascript" language="JavaScript">
{literal}
$(document).ready(function(){

    var left = {/literal}{$comment_max_chars}{literal}
    $('#text_counter').text(left);

        $('#in_message').keyup(function () {

        left = {/literal}{$comment_max_chars}{literal} - $(this).val().length;

        if(left < 0){
            $('#text_counter').addClass("overlimit");
        }
        if(left >= 0){
            $('#text_counter').removeClass("overlimit");
        }

        $('#text_counter').text(left);
    });

});
{/literal}
</script>

<div class="widget first"></div>

<div class="title"><h5>{#COMMENT_MODULE_NAME#}</h5></div>

<div class="widget" style="margin-top: 0px;">
    <div class="body">
		{#COMMENT_EDIT_TITLE#}
    </div>
</div>

<div class="breadCrumbHolder module">
	<div class="breadCrumb module">
	    <ul>
	        <li class="firstB"><a href="index.php" title="{#MAIN_PAGE#}">{#MAIN_PAGE#}</a></li>
	        <li>{#COMMENT_MODULE_NAME#}</li>
			<li>{#COMMENT_EDIT_TITLE#}</li>
	    </ul>
	</div>
</div>

<div class="widget first">
	{if $closed == 1 && $smarty.const.UGROUP != 1}

		{#COMMENT_IS_CLOSED#}

		<p><input onclick="window.close();" type="button" class="basicBtn" value="{#COMMENT_CLOSE_BUTTON#}" /></p>
	{else}
		{if $editfalse==1}
			{#COMMENT_EDIT_FALSE#}
		{else}
			<form method="post" action="index.php" class="mainForm">
				<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
                    <col width="150">
					{if $smarty.const.UGROUP == 1}
						<tr>
							<td>{#COMMENT_YOUR_NAME#}</td>
							<td><input name="comment_author_name" type="text" id="in_author_name" style="width:250px" value="{$row.comment_author_name|stripslashes|escape}" /></td>
						</tr>

						<tr>
							<td>{#COMMENT_YOUR_EMAIL#}</td>
							<td><input name="comment_author_email" type="text" id="in_author_email" style="width:250px" value="{$row.comment_author_email|stripslashes|escape}" /></td>
						</tr>
					{else}
						<input type="hidden" name="comment_author_name" value="{$row.comment_author_name|stripslashes|escape}" />
						<input type="hidden" name="comment_author_email" value="{$row.comment_author_email|stripslashes|escape}" />
					{/if}
					<tr>
						<td>{#COMMENT_YOUR_SITE#}</td>
						<td><input name="comment_author_website" type="text" id="in_author_website" style="width:250px" value="{$row.comment_author_website|stripslashes|escape}" /></td>
					</tr>

					<tr>
						<td>{#COMMENT_YOUR_FROM#}</td>
						<td><input name="comment_author_city" type="text" id="in_author_city" style="width:250px" value="{$row.comment_author_city|stripslashes|escape}" /></td>
					</tr>

					<tr>
						<td>{#COMMENT_YOUR_TEXT#}</td>
						<td>
							<div class="pr12"><textarea style="width:100%; height:170px" name="comment_text" id="in_message">{$row.comment_text}</textarea></div>
							<span id="text_counter"></span>&nbsp;{#COMMENT_CHARS_LEFT#}
						</td>
					</tr>

                    <input type="hidden" name="do" value="modules" />
                    <input type="hidden" name="action" value="modedit" />
					<input type="hidden" name="mod" value="comment" />
					<input type="hidden" name="moduleaction" value="admin_edit" />
					<input type="hidden" name="sub" value="send" />
					<input type="hidden" name="Id" value="{$smarty.request.Id|escape}" />

					<tr>
						<td colspan="3">
				<input type="submit" class="basicBtn" value="{#COMMENT_BUTTON_EDIT#}" />&nbsp;
				<input type="reset" class="basicBtn" value="{#COMMENT_BUTTON_RESET#}" />
						</td>
					</tr>

				</table>


			</form>
		{/if}
	{/if}

</div>