class Course < ApplicationRecord
	has_many :lessons, dependent: :destroy
	has_many :sections, dependent: :destroy

	# has_many :quiz_questions, dependent: :destroy
	# has_many :extension_questions, dependent: :destroy

	has_many :course_accesses, dependent: :destroy
	has_many :users, through: :course_accesses

	has_many :teachers_courses, dependent: :destroy
	has_many :teachers, through: :teachers_courses, foreign_key: :user_id, dependent: :destroy

	validates :title, presence: true

	accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true

	mount_uploader :image, ImageUploader

	def users_without_access
		# User.all - self.users
		User.find_by_sql("SELECT * FROM users WHERE id NOT IN (SELECT user_id FROM course_accesses WHERE course_id=#{self.id});")
	end
end
