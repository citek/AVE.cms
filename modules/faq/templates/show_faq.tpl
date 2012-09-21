<h3>{$faq_title}</h3>

{if $questions}
<dl>
{foreach from=$questions item=question}
	<dt><p><a href="javascript:void(0);">{$question->faq_quest}</a></p></dt>
	<dd>
		<h2>{$question->faq_quest}</h2>
		{$question->faq_answer}
	</dd>
{/foreach}
</dl>
{literal}
<script>
$(document).ready(function() {
	$("dd").hide();
	$("dt").unbind('click');
	$("dt").click(function() {
		$(this).toggleClass("highligh").next("dd").slideToggle();
	});
});
</script>
{/literal}
{/if}
