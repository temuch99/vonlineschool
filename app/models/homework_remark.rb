class HomeworkRemark < ApplicationRecord
  belongs_to :homework_attempt

  mount_uploader :remark, AnswerUploader
end
