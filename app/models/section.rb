class Section < ApplicationRecord
  belongs_to :course
  has_many :lessons, dependent: :destroy

  validates :title, presence: true

  acts_as_list
end
