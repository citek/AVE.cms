<form id="product" class="product" method="get" action="[tag:path]index.php">

	<input type="hidden" name="module" value="basket" />
	<input type="hidden" name="action" value="add" />

	<input type="hidden" name="p_id" value="[tag:docid]" />
	<input type="hidden" name="p_name" value="ID ���� ������������" />
	<input type="hidden" name="p_price" value="ID ���� ����" />
	<input type="hidden" name="p_article" value="ID ���� ��������" />
	<input type="hidden" name="p_size" value="ID ���� �������" />

	<div class="product-to-basket">
		<input type="text" name="quantity" value="1" size="1" maxlength="2" />
		<input type="submit" class="button" value="Add" />
	</div>

</form>