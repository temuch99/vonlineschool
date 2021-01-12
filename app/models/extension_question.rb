class ExtensionQuestion < ApplicationRecord
  belongs_to :course

  mount_uploader :task, ImageUploader
end
