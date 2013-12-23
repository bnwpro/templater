//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function() {
	$('.datetime-picker').each(function() {
		$(this).datetimepicker( {
			showSecond: false,
			dateFormat: 'MM, d',
			timeFormat: 'h:mm TT',
			controlType: 'select',
			//addSliderAccess: true,
		    //sliderAccessArgs: { touchonly: false },
			altField: $(this).closest('div').find('.alt_time_to_db'),
			altFieldTimeOnly: false,
			altFormat: 'yy-mm-dd',
			altTimeFormat: 'HH:mm:ss'
		});
	});
	$('.date-picker').each(function() {
		$(this).datepicker( {
			dateFormat: 'M, d',
			altField: $(this).closest('div').find('.alt_time_to_db'),
			altFormat: 'yy-mm-dd'
		});
	});
});