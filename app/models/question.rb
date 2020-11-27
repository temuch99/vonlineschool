class Question < ApplicationRecord
	belongs_to :lesson
	has_many :survey_answers, dependent: :destroy

	validates :correct_answer, presence: true
	validates :task, presence: true

	mount_uploader :task, ImageUploader
end
