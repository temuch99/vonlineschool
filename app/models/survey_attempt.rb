class SurveyAttempt < ApplicationRecord
  belongs_to :user

  has_many :survey_answers, dependent: :destroy
  has_many :questions, through: :survey_answers

  belongs_to :lesson
end
