class Api::LessonsController < Api::ApiController
	before_action :set_user
	before_action :set_lesson

	def show
		attempts = []
		@user.survey_attempts.order(created_at: :asc).first(5).each do |attempt|
			attempts.append({result: attempt.result, 
							 percent: attempt.questions.count,
							 lesson: attempt.lesson.title})
		end
		# @lessons = []
		# @user.

		render json: attempts.to_json
	end

	private
	def set_user
		@user = User.find(params[:user_id])
	end
	def set_lesson
		@lesson = lesson.find(params[:id])
	end
end
