class ExtensionQuestion < ApplicationRecord
  belongs_to :discipline

  mount_uploader :task, ImageUploader
end
