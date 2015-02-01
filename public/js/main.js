$(document).ready(function(){
	
	var screen_height = $(window).height();
	var screen_width = $(window).width();
	
	$('.breakup-container').css("width", screen_width);
	$('.breakup-container').css("height", screen_height);
	console.log(screen_height)
	
	$('.poster').css("width", screen_width);
	$('.poster').css("height", screen_height);
	
});