class Course < ApplicationRecord
	has_many :lessons, dependent: :destroy
	has_many :sections, dependent: :destroy

	has_many :quiz_questions, dependent: :destroy
	has_many :extension_questions, dependent: :destroy

	has_many :course_accesses, dependent: :destroy
	has_many :users, through: :course_accesses

	validates :title, presence: true

	accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true

	mount_uploader :image, ImageUploader

	def users_without_access
		User.all - self.users
	end
end
