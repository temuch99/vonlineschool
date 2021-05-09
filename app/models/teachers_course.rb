class TeachersCourse < ApplicationRecord
	belongs_to :teacher_course, class_name: "Course", foreign_key: :course_id
	belongs_to :teacher, class_name: "User", foreign_key: :user_id
end
