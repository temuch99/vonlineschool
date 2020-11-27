class SurveyAnswer < ApplicationRecord
  belongs_to :survey_attempt
  belongs_to :question
end
