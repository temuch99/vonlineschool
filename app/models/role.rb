class Role < ApplicationRecord
	has_many :users_roles
	has_many :users, through: :users
end
