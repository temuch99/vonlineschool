class QuizQuestion < ApplicationRecord
	belongs_to :course
	has_many :quiz_answers

	accepts_nested_attributes_for :quiz_answers, reject_if: :all_blank, allow_destroy: true
	
	mount_uploader :question, ImageUploader

	def get_correct
		self.quiz_answers.select { |answer| answer.is_correct }.map { |answer| answer.answer }
	end
end
