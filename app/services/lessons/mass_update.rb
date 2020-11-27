class Lessons::MassUpdate
	def self.create!(lessons_params)
		Lesson.transaction do
			lessons_params.each do |lesson_param|
				lesson = Lesson.find(lesson_param[:id])
				lesson.update!(position: lesson_param[:position])
			end
		end
	end
end