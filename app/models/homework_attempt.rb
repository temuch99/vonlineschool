class HomeworkAttempt < ApplicationRecord
  belongs_to :lesson
  belongs_to :user

  has_many :homework_answers, dependent: :destroy
  has_many :homework_remarks, dependent: :destroy
end
