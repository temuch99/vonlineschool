class Admin::QuestionsController < Admin::AdminController
	before_action :set_course
	before_action :set_lesson
	before_action :set_question, only: [:edit, :update, :destroy]

	def index
		@questions = @lesson.questions.page(params[:page])
	end

	def new
		add_breadcrumb "Новый вопрос", [:new, :admin, @course, @lesson, :question]

		@question = @lesson.questions.build
	end

	def create
		@question = @lesson.questions.build(question_params)

		if @question.save
			redirect_to [:admin, @course, @lesson, :questions], notice: "Вопрос создан"
		else
			add_breadcrumb "Новый вопрос", [:new, :admin, @course, @lesson, :question]

			flash.now[:alert] = "Произошла ошибка"
			render 'new'
		end
	end

	def edit
		add_breadcrumb "Редактировать", [:edit, :admin, @course, @lesson, @question]
	end

	def update
		if @question.update(question_params)
			redirect_to [:admin, @course, @lesson, :questions], notice: "Вопрос обновлен"
		else
			add_breadcrumb "Редактировать", [:edit, :admin, @course, @lesson, @question]

			flash.now[:alert] = "Произошла ошибка"
			render 'edit'
		end
	end

	def destroy
		if @question.destroy
			redirect_to [:admin, @course, @lesson, :questions], notice: "Вопрос удален"
		else
			redirect_to [:admin, @course, @lesson, :questions], alert: "Не удалось удалить вопрос"
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

    def set_question
    	@question = Question.find(params[:id])
    end

    def set_active_header_item
		@header[:courses][:active] = true
    end

    def question_params
		params.require(:question).permit(:task, :correct_answer)
    end
end
