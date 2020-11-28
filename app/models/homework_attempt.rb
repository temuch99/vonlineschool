class HomeworkAttempt < ApplicationRecord
  belongs_to :lesson
  belongs_to :user

  has_many :homework_answers, dependent: :destroy
end
