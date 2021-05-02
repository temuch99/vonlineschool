class Api::CoursesController < Api::ApiController
	before_action :set_user
	# def index
	# 	@courses = Course.all
	# 	render json: @courses
	# end
	def show
		course = Course.find(params[:id])
		done_lessons = @user.done_lessons(course.id)
		lessons = course.lessons.count - done_lessons
		render json: {
						title: course.title,
						undone_lessons: lessons,
						done_lessons: done_lessons
					}.to_json
	end
	private
	def set_user
		@user = User.find(params[:user_id])
	end
end
