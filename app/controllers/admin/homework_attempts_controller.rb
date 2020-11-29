class Admin::HomeworkAttemptsController < Admin::AdminController
	def index
		add_breadcrumb "Д/З", admin_homework_attempts_path
	end

	def show
		add_breadcrumb "Д/З", admin_homework_attempts_path
		@attempt = HomeworkAttempt.find(params[:id])
		@user = @attempt.user
		add_breadcrumb "Домашнее задание пользователя #{@user.first_name} #{@user.last_name}", "#"
	end

	def update
		attempt = HomeworkAttempt.find(params[:id])
		if attempt.update(result: params[:result], checked: true)
			HomeworkMailer.with(user: current_user).checked_homework.deliver_now
			flash[:success] = "Результат отправлен"
		else
			flash[:danger] = "Произошла ошибка"
		end

		redirect_to admin_homework_attempts_path
	end

	private
	def set_active_header_item
    	@header[:homeworks][:active] = true
    end
end