class Api::QuestionsController < Api::ApiController
	before_action :set_course

	def show
		question = @course.extension_questions.where(number: params[:id]).take(1)[0]
		if question
			render json: {
				question: question.task.url,
				number: question.number,
				answer: question.correct_answer
			}
		else
			not_found
		end
		# question = @course.quiz_questions.take(1)[0]
		# render json: {
		# 	question: question.question.url,
		# 	number: question.number,
		# 	answers: question.quiz_answers
		# }
	end

	private
	def set_course
		@course = Course.find(params[:course_id])
	end

	def not_found
		raise ActionController::RoutingError.new('Not Found')
	end

end
