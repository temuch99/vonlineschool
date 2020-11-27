document.addEventListener('turbolinks:load', function() {	
	$('.sections_sortable').sortable({
		axis: 'y',
		handle: '.handle',
		stop: function(event, ui) {
			let inputs = $('.sections_sortable .course_sections_position input');
			i = 1;
			inputs.each(function(key, item) {
				item.value = i;
				i += 1;
				console.log(item.value)
			})
		}
	})
})