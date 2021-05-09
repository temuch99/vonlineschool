module Admin::CourseHelper
	def my_courses
		if current_user.roles.exists?(name: :admin)
			Course.all
		else
			current_user.teacher_courses
		end
	end
end
