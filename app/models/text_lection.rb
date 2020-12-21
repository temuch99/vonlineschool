class TextLection < ApplicationRecord
	belongs_to :lesson

	mount_uploader :lection, FileUploader
end
