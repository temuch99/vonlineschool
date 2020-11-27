document.addEventListener('turbolinks:load', function() {	
	$('.lessons_sortable').sortable({
		axis: 'y',
		handle: '.handle',
		stop: function() {
			let data = [];

			let inputs = $('.lessons_sortable .lesson');
			i = 1;
			inputs.each(function(lesson, position) {
				let les = inputs[lesson];

				let lesson_id = les.dataset.id;
				let lesson_pos = i;
				i += 1;

				data.push({
					id: lesson_id,
					position: lesson_pos
				})
				les.children[1].innerHTML = lesson_pos;
			})

			$.ajax({
				type: "POST",
				url: $('.lessons_sortable').data('update-url'),
				data: {
					'lessons': data
				},
				dataType: 'json'
			})
		}
	})
})