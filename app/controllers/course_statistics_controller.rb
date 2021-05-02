class CourseStatisticsController < BaseController
	before_action :set_user
	def show
		@course = Course.find(params[:id])
		
		add_breadcrumb "Пользователи", [:users]
		add_breadcrumb @user.full_name, [@user]
		add_breadcrumb "Статистика по курсу #{@course.title}"
	end

	private
	def set_user
		@user = User.find(params[:user_id])
	end
	def set_active_header_item
		@header[:users][:active] = true
	end
end
