class LessonsController < BaseController
	before_action :authenticate_user!, only: :show
	before_action :set_course, only: [:index, :show]
	before_action :set_breadcrumbs, only: [:index, :show]
	before_action :set_active_header_item, except: :destroy

	def index
		@lessons = @course.lessons.order(position: :asc).page(params[:page])
	end

	def show
		@lesson = Lesson.find(params[:id])

		#количество вопросов больше, чем количество доступных вопросов
		# @is_survey = @lesson.questions.count >= @lesson.survey_size
		@is_survey = @lesson.survey_end_at < Time.now

		#попытки
		@user_attempts = current_user.survey_attempts
		@not_done_attempts = @user_attempts.where(lesson_id: @lesson.id, done: false).count > 0
		@count_user_attempts = @user_attempts.where(lesson_id: @lesson.id, done: true).count
		@has_attempts = @lesson.attempts > @count_user_attempts
		@done_attempts = @count_user_attempts > 0
		add_breadcrumb @lesson.title, '#'
	end

	private
	def set_active_header_item
      @header[:courses][:active] = true
    end

	def set_course
		@course = Course.find(params[:course_id])
	end

	def set_breadcrumbs
		add_breadcrumb "Курсы", [:courses]
		add_breadcrumb @course.title, [@course]
		add_breadcrumb 'Занятия', [@course, :lessons]
	end
end
