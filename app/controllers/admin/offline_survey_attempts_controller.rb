class Admin::OfflineSurveyAttemptsController < Admin::AdminController
	before_action :set_course
	before_action :set_lesson
	before_action :set_attempt, only: [:edit, :update, :destroy]

	def index
		@attempts = @lesson.offline_survey_attempts.page(params[:page])
	end

	def new
		add_breadcrumb "Новая оценка", [:new, :admin, @course, @lesson, :offline_survey_attempt]

		@attempt = @lesson.offline_survey_attempts.build
	end

	def create
		@attempt = @lesson.offline_survey_attempts.build(attempt_params)

		if @attempt.save
			redirect_to [:admin, @course, @lesson, :offline_survey_attempts], notice: "Оценка записана"
		else
			add_breadcrumb "Новая оценка", [:new, :admin, @course, @lesson, :offline_survey_attempt]

			flash.now[:alert] = "Произошла ошибка"
			render 'new'
		end
	end

	def edit
		add_breadcrumb "Редактировать", [:edit, :admin, @course, @lesson, @attempt]
	end

	def update
		if @attempt.update(attempt_params)
			redirect_to [:admin, @course, @lesson, :offline_survey_attempts], notice: "Оценка обновлена"
		else
			add_breadcrumb "Редактировать", [:edit, :admin, @course, @lesson, @attempt]

			flash.now[:alert] = "Произошла ошибка"
			render 'edit'
		end
	end

	def destroy
		if @attempt.destroy
			redirect_to [:admin, @course, @lesson, :offline_survey_attempts], notice: "Оценка удалена"
		else
			redirect_to [:admin, @course, @lesson, :offline_survey_attempts], alert: "Не удалось удалить оценку"
		end
	end

	private

    def set_course
		@course = Course.find(params[:course_id])

		add_breadcrumb "Курсы", :admin_courses_path
		add_breadcrumb @course.title, [:admin, @course]
    end

    def set_lesson
		@lesson = Lesson.find(params[:lesson_id])

		add_breadcrumb "Уроки", [:admin, @course, :lessons]
		add_breadcrumb @lesson.title, [:admin, @course, @lesson]
    end

    def set_attempt
    	@attempt = OfflineSurveyAttempt.find(params[:id])
    end

    def set_active_header_item
		@header[:courses][:active] = true
    end

    def attempt_params
		params.require(:offline_survey_attempt).permit(:result, :user_id)
    end
end
