class Admin::RolesController < Admin::AdminController
	before_action :can_access
	before_action :check_add_user, only: [:add_admin, :add_teacher]
	before_action :check_remove_user, only: [:remove_admin, :remove_teacher]

	def index
		@teachers = Role.find_by(name: :teacher).users
		@admins = Role.find_by(name: :admin).users
	end

	def add_admin
		User.find(role_params[:user_id]).roles << Role.find_by(name: :admin)
		redirect_to admin_roles_path, notice: "Привилегия добавлена"
	end

	def add_teacher
		User.find(role_params[:user_id]).roles << Role.find_by(name: :teacher)
		redirect_to admin_roles_path, notice: "Привилегия добавлена"
	end

	def remove_admin
		UsersRole.find_by(user_id: params[:user_id], role_id: Role.find_by(name: :admin).id).destroy
		redirect_to admin_roles_path, notice: "Привилегия удалена"
	end

	def remove_teacher
		UsersRole.find_by(user_id: params[:user_id], role_id: Role.find_by(name: :teacher).id).destroy
		redirect_to admin_roles_path, notice: "Привилегия удалена"
	end

	private
	def check_remove_user
		if User.find(params[:user_id]).nil?
			redirect_to admin_roles_path, notice: "Ошибка"
		end
	end

	def check_add_user
		if User.find(role_params[:user_id]).nil?
			redirect_to admin_roles_path, notice: "Ошибка"
		end
	end

	def set_active_header_item
		@header[:users][:active] = true
	end

	def role_params
		params.require(:users).permit(:user_id)
	end

	def can_access
		unless current_user.is_admin?
			redirect_to admin_root_path, notice: "У вас нет доступа к этой странице"
		end
	end
end
