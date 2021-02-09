class Discipline < ApplicationRecord
	has_many :extension_questions, dependent: :destroy
end
