//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery(window).on('mercury:ready', function() {
   //$('#to_pdf').hide();
   var link = $('#edit_link');
   Mercury.saveUrl = link.data('save-url');
   //link.hide();
});
jQuery(window).on('mercury:saved', function() {
  /*$('#to_pdf').show();
  link.show();*/
});

$(document).ready(function() {
	var clone;
	$('#add-page').click(function(e) {
		e.preventDefault();
		var new_page = $("<div id='page_6' class='print-page'><hr><%= image_tag get_image_path, :alt => 'logo', :id => 'logo' %></div>");
		$(".print-page").last().append(new_page);
		clone = $(".print-page").last().clone();
	})
	$('#remove-page').click(function(e) {
		e.preventDefault();
		clone = $(".print-page").last().clone();
		$(".print-page").last().remove();
		
	})
	$('#undo').click(function(e) {
		e.preventDefault();
		$(clone).add().appendTo(document.body);
	})
	
	$('#to_pdf').on('ajax:success', function(e, data, staus, hxr) {
		//var loc = window.location;
		//var trim_url = loc.match(/^\/./);
		//alert(window.location);
		alert('PDF for this Responsibility document Saved!');
	})
})
