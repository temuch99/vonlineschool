class Admin::ExtensionQuestionsController < Admin::AdminController
	before_action :set_discipline
	before_action :set_question, only: [:edit, :update, :destroy]

	def index
		@questions = @discipline.extension_questions.page(params[:page])
	end

	def new
		add_breadcrumb "Новый вопрос", [:new, :admin, @discipline, :extension_question]

		@question = @discipline.extension_questions.build
	end

	def create
		@question = @discipline.extension_questions.build(question_params)

		if @question.save
			redirect_to [:admin, @discipline, :extension_questions], notice: "Вопрос создан"
		else
			add_breadcrumb "Новый вопрос", [:new, :admin, @discipline, :extension_question]

			flash.now[:alert] = "Произошла ошибка"
			render 'new'
		end
	end

	def edit
		add_breadcrumb "Редактировать", [:edit, :admin, @discipline, @question]
	end

	def update
		if @question.update(question_params)
			redirect_to [:admin, @discipline, :extension_questions], notice: "Вопрос обновлен"
		else
			add_breadcrumb "Редактировать", [:edit, :admin, @discipline, @question]

			flash.now[:alert] = "Произошла ошибка"
			render 'edit'
		end
	end

	def destroy
		if @question.destroy
			redirect_to [:admin, @discipline, :extension_questions], notice: "Вопрос удален"
		else
			redirect_to [:admin, @discipline, :extension_questions], alert: "Не удалось удалить вопрос"
		end
	end

	private
    def set_discipline
		@discipline = Discipline.find(params[:discipline_id])

		add_breadcrumb "Курсы", :admin_disciplines_path
		add_breadcrumb @discipline.title, "#"
    end

    def set_question
    	@question = ExtensionQuestion.find(params[:id])
    end

    def set_active_header_item
		@header[:disciplines][:active] = true
    end

    def question_params
		params.require(:extension_question).permit(:task, :correct_answer, :number)
    end
end
