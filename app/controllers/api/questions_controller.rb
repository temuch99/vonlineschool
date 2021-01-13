class Api::QuestionsController < Api::ApiController
	before_action :set_course

	def show
		question = @course.quiz_questions.take(1)[0]
		render json: {
			question: question.question.url,
			number: question.number,
			answers: question.quiz_answers
		}
	end

	private
	def set_course
		@course = Course.find(params[:course_id])
	end
end
