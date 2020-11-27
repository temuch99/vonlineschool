class Admin::AdminController < ApplicationController
	layout 'admin'

	before_action :authenticate_user!
	before_action :admin_access
	before_action :set_header, except: :destroy
	before_action :set_active_header_item, except: :destroy


	private
	def set_header
		@header = { 
			courses: { name: 'Курсы', path: admin_courses_path }
		}
	end

	def admin_access
		redirect_to root_url, notice: "Вы не являетесь администратором данного сайта" if !current_user.roles.exists?(name: :admin)
	end
end