class Api::UsersController < Api::ApiController
	before_action :set_user

	def show
		attempts = []
		@user.survey_attempts.order(created_at: :asc).first(5).each do |attempt|
			attempts.append({result: attempt.result, 
							 questions: attempt.questions.count,
							 date: attempt.created_at.strftime("%F %T"),
							 lesson: attempt.lesson.title})
		end

		render json: attempts.to_json
	end

	private
	def set_user
		@user = User.find(params[:id])
	end
end
