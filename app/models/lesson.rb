class Lesson < ApplicationRecord
	belongs_to :course
	belongs_to :section

	has_many :questions, dependent: :destroy
	has_many :survey_attempts, dependent: :destroy
	has_many :homework_attempts, dependent: :destroy

	validates :title, presence: true
	validates :survey_size, numericality: {only_integer: true, greater_than: 0}
	validates :survey_duration, numericality: {only_integer: true, greater_than: 0}

	# mount_uploaders :text_lections, FileUploader
	has_many :text_lections, dependent: :destroy
	accepts_nested_attributes_for :text_lections, reject_if: :all_blank, allow_destroy: true

	mount_uploader :homework, FileUploader

	acts_as_list

	def self.reorder(order_params)
	  	order_params.each_with_index do |id, index|
	      	Lesson.find(id).update!(position: index + 1)
	    end
	end
end
