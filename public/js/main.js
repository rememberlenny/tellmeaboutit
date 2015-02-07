$(document).ready(function(){
	
	var screen_height = $(window).height();
	var screen_width = $(window).width();
	
	$('.breakup-container').css("width", screen_width);
	$('.breakup-container').css("height", screen_height);
	console.log(screen_height)

	if (screen_width>600) {
		//set the width and height of the poster image
		$('.poster').css("width", screen_width);
		$('.poster').css("height", screen_height);
		
		
		//set the position of the opening text
		$(".breakup-pullquote").css("top", screen_height/5.2);
	} else {
		//set the width and height of the poster image
		$(".poster").css("height", "auto");

		//set the position of the opening text
		$(".breakup-pullquote").css("top", 10);

	}
	

		
});