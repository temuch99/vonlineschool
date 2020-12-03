class HomeworksController < BaseController
	before_action :authenticate_user!
	before_action :set_course
	before_action :set_lesson
	# before_action :has_attempts

	def new
	end

	## ПЛОХО реализовано, надо переделать
	def create
		if HomeworkAttempt.where(lesson_id: @lesson.id, user_id: current_user.id).any?
			HomeworkAttempt.where(lesson_id: @lesson.id, user_id: current_user.id).destroy_all
		end
		@homework_attempt = HomeworkAttempt.new(lesson_id: @lesson.id, user_id: current_user.id)
		if @homework_attempt.save
			params[:answer].each do |answer|
				HomeworkAnswer.create(answer: answer, homework_attempt_id: @homework_attempt.id)
			end

			redirect_to [@course, @lesson], notice: "Ваши ответы были отправлены, ожидайте ответа"
		else
			redirect_to [@course, @lesson], notice: "Не удалось отправить ваши ответы, обатитесь к администратору"
		end
	end

	private
	def set_course
		@course = Course.find(params[:course_id])
	end

	def set_lesson
		@lesson = Lesson.find(params[:lesson_id])
	end

	def set_active_header_item
		@header[:courses][:active] = true
	end

	def has_attempts
		redirect_to [@course, @lesson] if HomeworkAttempt.where(lesson_id: @lesson.id, user_id: current_user.id).any?
	end
end
