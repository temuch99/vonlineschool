class QuestionsController < BaseController
	before_action :authenticate_user!
	before_action :set_course
	before_action :set_lesson
	before_action :set_survey_attempt
	before_action :set_question, only: [:edit, :update, :destroy]
	before_action :set_answers, only: [:index, :edit, :update]
	before_action :is_started

	before_action :has_time

	def edit
		@question = Question.find(params[:id])
		@survey_answer = SurveyAnswer.find_by(question_id: @question.id,
											  survey_attempt_id: @survey_attempt.id)
	end

	def index
	end

	def update
		@survey_answer = SurveyAnswer.find_by(question_id: @question.id, 
											  survey_attempt_id: @survey_attempt.id)
		if @survey_answer.update(survey_answer_params)
			# выбрать следующий вопрос
			question = @survey_answer.question
			qs = @survey_attempt.questions
			q_index = qs.index(question)
			if q_index + 1 < qs.count
				next_question = qs[q_index + 1]
				redirect_to [:edit, @course, @lesson, @survey_attempt, next_question]
			else
				redirect_to [@course, @lesson, @survey_attempt]
			end
		else
			flash.now[:alert] = "Ответ на вопрос не удалось сохранить"
			render 'edit'
		end
	end

	private
	def has_time
		redirect_to [@course, @lesson], notice: "Время проведения теста закончилось" if @lesson.survey_end_at < Time.now
	end
	
	def set_active_header_item
		@header[:courses][:active] = true
	end

	def is_started
		attempts = current_user.survey_attempts.where(lesson_id: @lesson.id, done: false).count
		redirect_to [@course, @lesson], notice: "Вы еще не начинали тест" if attempts == 0
	end

	def set_course
		@course = Course.find(params[:course_id])
	end

	def set_lesson
		@lesson = Lesson.find(params[:lesson_id])
	end

	def set_survey_attempt
		@survey_attempt = SurveyAttempt.find(params[:survey_attempt_id])
		@timer = @survey_attempt.survey_end_at.to_i - Time.now.to_i
	end

	def set_question
		@question = Question.find(params[:id])
	end

	def set_answers
		@answers = @survey_attempt.survey_answers
	end

	def survey_answer_params
		params.require(:survey_answer).permit(:answer)
	end
end
