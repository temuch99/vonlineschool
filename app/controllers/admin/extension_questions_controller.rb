class Admin::ExtensionQuestionsController < Admin::AdminController
	before_action :set_course
	before_action :set_question, only: [:edit, :update, :destroy]

	def index
		@questions = @course.extension_questions.page(params[:page])
	end

	def new
		add_breadcrumb "Новый вопрос", [:new, :admin, @course, :extension_question]

		@question = @course.extension_questions.build
	end

	def create
		@question = @course.extension_questions.build(question_params)

		if @question.save
			redirect_to [:admin, @course, :extension_questions], notice: "Вопрос создан"
		else
			add_breadcrumb "Новый вопрос", [:new, :admin, @course, :extension_question]

			flash.now[:alert] = "Произошла ошибка"
			render 'new'
		end
	end

	def edit
		add_breadcrumb "Редактировать", [:edit, :admin, @course, @question]
	end

	def update
		if @question.update(question_params)
			redirect_to [:admin, @course, @lesson, :extension_questions], notice: "Вопрос обновлен"
		else
			add_breadcrumb "Редактировать", [:edit, :admin, @course, @question]

			flash.now[:alert] = "Произошла ошибка"
			render 'edit'
		end
	end

	def destroy
		if @question.destroy
			redirect_to [:admin, @course, :questions], notice: "Вопрос удален"
		else
			redirect_to [:admin, @course, :questions], alert: "Не удалось удалить вопрос"
		end
	end

	private
    def set_course
		@course = Course.find(params[:course_id])

		add_breadcrumb "Курсы", :admin_courses_path
		add_breadcrumb @course.title, "#"
    end

    def set_question
    	@question = ExtensionQuestion.find(params[:id])
    end

    def set_active_header_item
		@header[:courses][:active] = true
    end

    def question_params
		params.require(:extension_question).permit(:task, :correct_answer, :number)
    end
end
