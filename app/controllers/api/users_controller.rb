class Api::UsersController < Api::ApiController
	before_action :set_user

	def show
		# attempts = []
		courses = []
		@user.courses.each do |course|
			@p = @user.course_percent(course.id)
			courses.append({title: course.title, 
							percent: @p,
							_percent: 1 - @p})
		end

		render json: courses.to_json
	end

	private
	def set_user
		@user = User.find(params[:id])
	end
end
