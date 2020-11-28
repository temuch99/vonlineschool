class HomeworkAnswer < ApplicationRecord
  belongs_to :homework_attempt

  mount_uploader :answer, AnswerUploader
end
