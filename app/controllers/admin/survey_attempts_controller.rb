class Admin::SurveyAttemptsController < Admin::AdminController
	before_action :breadcrumb

	def index
		@attempts = SurveyAttempt.all
	end

	def destroy
		@attempt = SurveyAttempt.find(params[:id])
		if @attempt.destroy
			redirect_to admin_survey_attempts_path, notice: "Попытка пользователя удалена"
		else
			redirect_to admin_survey_attempts_path, alert: "Не удалось удалить попытку пользователя"
		end
	end

	private
	def set_active_header_item
    	@header[:surveys][:active] = true
    end

    def breadcrumb
    	add_breadcrumb "Результаты тестов", admin_survey_attempts_path
    end
end
