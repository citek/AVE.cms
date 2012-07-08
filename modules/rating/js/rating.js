$(document).ready(function(){
	$(".itemRatingForm a").click(function(e) {
	  var itemID = $(this).attr('rel');
	  var rating = $(this).text();
	  var log = $('#itemRatingLog' + itemID).addClass('formLogLoading');
	  e.stopPropagation();
	  $.ajax({
		type: "GET",
		url: ave_path+"index.php",
		data: "module=rating&action=vote&user_rating=" + rating + "&id=" + itemID,
		success: function(result) {
		// get rating after click
		   log.removeClass('formLogLoading');
		   log.text(result);

		   $.ajax({
			  type: "GET",
			  url: ave_path+"index.php",
			  data: "module=rating&action=getVotesPercent&id=" + itemID,
			  success: function(percentage) {
				  $('#itemCurrentRating' + itemID).css('width', percentage + "%");

			  setTimeout(function(){
				   $.ajax({
					  delay: {time: 5000},
					  type: "GET",
					  url: ave_path+"index.php",
					  data: "module=rating&action=getVotesNum&id=" + itemID,
					  success: function(mess) { log.text(mess);}
				   })

			  , 2000})

			  }
		   });

		},
		error: function(result) {
		alert("Произошла ошибка, повторите попытку позже.");
		}
		});

	});
});