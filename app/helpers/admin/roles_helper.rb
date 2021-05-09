module Admin::RolesHelper
	def users_without_admin_privs
		User.all - Role.find_by(name: :admin).users
	end

	def users_without_teacher_privs
		User.all - Role.find_by(name: :teacher).users
	end
end
