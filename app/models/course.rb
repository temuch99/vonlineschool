class Course < ApplicationRecord
	has_many :lessons, dependent: :destroy
	has_many :sections, dependent: :destroy

	validates :title, presence: true

	accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true

	mount_uploader :image, ImageUploader
end
