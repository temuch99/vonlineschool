class Lesson < ApplicationRecord
	belongs_to :course

	has_many :questions, dependent: :destroy
	has_many :survey_attempts, dependent: :destroy
	has_many :homework_attempts, dependent: :destroy

	validates :title, presence: true
	validates :survey_size, numericality: {only_integer: true, greater_than: 0}
	validates :survey_duration, numericality: {only_integer: true, greater_than: 0}

	mount_uploader :text_lection, FileUploader
	mount_uploader :homework, FileUploader

	acts_as_list

	def self.reorder(order_params)
	  	order_params.each_with_index do |id, index|
	      	Lesson.find(id).update!(position: index + 1)
	    end
	end
end
