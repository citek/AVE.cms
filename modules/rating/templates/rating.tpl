<!--itemRatingBlock-->
<link rel="stylesheet" type="text/css" href="{$ABS_PATH}modules/rating/templates/rating.css" media="screen" />

<script>
	var ave_path = '{$ABS_PATH}';
</script>

<script type="text/javascript" src="{$ABS_PATH}modules/rating/js/rating.js"></script>
<div class="itemRatingBlock">
    <span>{#RATING_TXT#}</span>
    <div class="itemRatingForm">
      <ul class="itemRatingList">
          <li class="itemCurrentRating" id="itemCurrentRating{$doc_id_rating}" style="width:{$rating_persent}%;"></li>
          <li><a href="#" rel="{$doc_id_rating}" title="1 {#RATING_STARS_ONE#} 5" class="one-star">1</a></li>
          <li><a href="#" rel="{$doc_id_rating}" title="2 {#RATING_STARS#} 5" class="two-stars">2</a></li>
          <li><a href="#" rel="{$doc_id_rating}" title="3 {#RATING_STARS#} 5" class="three-stars">3</a></li>
          <li><a href="#" rel="{$doc_id_rating}" title="4 {#RATING_STARS#} 5" class="four-stars">4</a></li>
          <li><a href="#" rel="{$doc_id_rating}" title="5 {#RATING_STARS#} 5" class="five-stars">5</a></li>
      </ul>
      <div id="itemRatingLog{$doc_id_rating}" class="itemRatingLog">({$rating_count} {#RATING_VOTES#})</div>
      <div class="clr"></div>
    </div>
    <div class="clr"></div>
  </div>
<!-- end itemRatingBlock -->