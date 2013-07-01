$(document).ready(function() {     
	$('.home-page-menu-item a').each(function() {        
		 // IS this the active link?         
		if ($(this).attr('href') == $(location).attr('pathname'))            
		$(this).parent().addClass("active")     
	}) 
})