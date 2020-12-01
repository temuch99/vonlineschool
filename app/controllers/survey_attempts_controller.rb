class SurveyAttemptsController < BaseController
	before_action :authenticate_user!
	before_action :set_course
	before_action :set_lesson
	before_action :is_started, only: :show
	before_action :has_attempts

	before_action :has_time, only: [:new, :create]

	def new
		if SurveyAttempt.where(lesson_id: @lesson.id, user_id: current_user.id, done: false).count > 0
			@survey_attempt = SurveyAttempt.find_by(lesson_id: @lesson.id, user_id: current_user.id, done: false)
		end
	end

	def create
		@survey_attempt = current_user.survey_attempts.build(lesson_id: @lesson.id,
															 survey_end_at: Time.at(Time.now.to_i + @lesson.survey_duration * 60))
		if @survey_attempt.save
			@survey_attempt.questions = @lesson.questions.take(@lesson.survey_size)
			redirect_to [@course, @lesson, @survey_attempt, :questions]
		else
			redirect_to [@course, @lesson], notice: "Не удалось начать тест, обатитесь к администратору"
		end
	end

	def show
		@survey_attempt = SurveyAttempt.find(params[:id])
		@answers = @survey_attempt.survey_answers
	end

	def destroy
		@survey_attempt = SurveyAttempt.find(params[:id])

		result = 0
		@survey_attempt.survey_answers.each do |answer|
			result += answer.answer == answer.question.correct_answer ? 1 : 0
		end

		if @survey_attempt.update(done: :true, result: result)
			redirect_to [@course, @lesson], notice: "Вы завершили прохождение теста"
		else
			redirect_to [@course, @lesson], alert: "Попытка тестирования не была завершена"
		end
	end

	private
	def has_time
		redirect_to [@course, @lesson], notice: "Время проведения теста закончилось" if @lesson.survey_end_at < Time.now
		redirect_to [@course, @lesson], notice: "Время проведения теста закончилось" if @survey_attempt.survey_end_at < Time.now
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

	def has_attempts
		count_user_attempts = SurveyAttempt.where(lesson_id: @lesson.id, user_id: current_user.id).count
		redirect_to [@course, @lesson], notice: "У Вас закончились попытки" if count_user_attempts > @lesson.attempts
	end

	def set_active_header_item
		@header[:courses][:active] = true
	end
end
