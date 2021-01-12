class Admin::QuizQuestionsController < Admin::AdminController
	before_action :set_course
	before_action :set_question, only: [:edit, :update, :destroy]

	def index
		@questions = @course.quiz_questions.page(params[:page])
	end

	def new
		add_breadcrumb "Новый вопрос", [:new, :admin, @course, :quiz_question]

		@question = @course.quiz_questions.build
		@question.quiz_answers.build if @question.quiz_answers.empty?
	end

	def create
		@question = @course.quiz_questions.build(question_params)

		if @question.save
			redirect_to [:admin, @course, :quiz_questions], notice: "Вопрос создан"
		else
			add_breadcrumb "Новый вопрос", [:new, :admin, @course, :quiz_question]
			@question.quiz_answers.build if @question.quiz_answers.empty?

			flash.now[:alert] = "Произошла ошибка"
			render 'new'
		end
	end

	def edit
		@question.quiz_answers.build if @question.quiz_answers.empty?
		add_breadcrumb "Редактировать", [:edit, :admin, @course, @question]
	end

	def update
		if @question.update(question_params)
			redirect_to [:admin, @course, :quiz_questions], notice: "Вопрос обновлен"
		else
			add_breadcrumb "Редактировать", [:edit, :admin, @course, @question]
			@question.quiz_answers.build if @question.quiz_answers.empty?

			flash.now[:alert] = "Произошла ошибка"
			render 'edit'
		end
	end

	def destroy
		if @question.destroy
			redirect_to [:admin, @course, :quiz_questions], notice: "Вопрос удален"
		else
			redirect_to [:admin, @course, :quiz_questions], alert: "Не удалось удалить вопрос"
		end
	end

	private
    def set_course
		@course = Course.find(params[:course_id])

		add_breadcrumb "Курсы", :admin_courses_path
		add_breadcrumb @course.title, "#"
    end

    def set_question
    	@question = QuizQuestion.find(params[:id])
    end

    def set_active_header_item
		@header[:courses][:active] = true
    end

    def question_params
		params.require(:quiz_question).permit(:question, :number, quiz_answers_attributes: 
											[:answer, :is_correct, :position, :_destroy, :id])
    end
end
