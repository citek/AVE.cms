<li>
	<a {if $smarty.request.do=='docs'}class="active"{/if}href="index.php?do=docs&cp={$sess}"><span>{#MAIN_NAVI_DOCUMENTS#}</span></a>
	{if $smarty.request.do=='docs'}
	<ul class="sub" style="display: block; ">
	{foreach from=$rubrics item=rubric}
		{if $rubric->Show==1}
			<li>
				<a href="index.php?do=docs&rubric_id={$rubric->Id}&cp={$sess}" title="">{$rubric->rubric_title|escape}</a>
				<a class="numberLeft" href="index.php?&do=docs&action=new&rubric_id={$rubric->Id}&cp={$sess}" title="">+</a>
			</li>
		{/if}
	{/foreach}
	</ul>
	{/if}
</li>