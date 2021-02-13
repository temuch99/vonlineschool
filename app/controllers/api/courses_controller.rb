class Api::CoursesController < Api::ApiController
	def index
		@courses = Course.all
		render json: @courses
	end
end
