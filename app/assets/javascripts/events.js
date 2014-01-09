//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function() {
	$('.datetime-picker').each(function() {
		var alt_time = $(this).closest('div').find('.alt_time_to_db');
		$(this).datetimepicker( {
			showSecond: false,
			dateFormat: 'MM, d',
			timeFormat: 'h:mm TT',
			controlType: 'select',
			//addSliderAccess: true,
		    //sliderAccessArgs: { touchonly: false },
			altField: alt_time,
			altFieldTimeOnly: false,
			altFormat: 'yy-mm-dd',
			altTimeFormat: 'HH:mm:ss'
		});
		$(this).change(function() {
			if (!$(this).val()) alt_time.val('');
		})
	});
	$('.date-picker').each(function() {
		var alt_time = $(this).closest('div').find('.alt_time_to_db');
		$(this).datepicker( {
			dateFormat: 'M, d',
			altField: alt_time,
			altFormat: 'yy-mm-dd'
		});
		$(this).change(function() {
			if (!$(this).val()) alt_time.val('');
		})
	});
		
	$('#to_pdf').on('ajax:beforeSend', function(e, data, status, xhr) {
		var generate = true;
		var go = confirm('Render All PDFs for this campaign?');
		if (go == true) {
			$('#progress-bar').css('visibility', 'visible');
			$(function() {
				interval = setInterval(updateBar, 250);
			})
		} else if (go == false) {
			generate = false;
		}
		return generate;
	})
	$('#to_pdf').on('ajax:error', function(e, data, status, xhr) {
		alert('There was an error while rendering PDFs.  Make sure the Block Calendar has been uploaded and that the Gift Profile data is complete.');
	})
	$('#to_pdf').on('ajax:success', function(e, data, status, xhr) {
		alert('PDFs rendered and saved!');
	})
	$('#to_pdf').on('ajax:complete', function(e, data, status, xhr) {
		$('#progress-bar').css('visibility', 'hidden');
		$('#progress-bar').css('width', '10px');
		clearInterval(interval);
		progress_bar_width = 10;
		document.location.reload();
		//alert('PDFs rendered and saved!');
	})
	
	var progress_bar_width = 10;
	function updateBar() {
		$('#progress-bar').css('width', progress_bar_width+'px');
		progress_bar_width += 10;
		if (progress_bar_width == 300) {
			progress_bar_width = 10;
		}
		return
	}
});