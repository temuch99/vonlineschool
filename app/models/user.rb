class User < ApplicationRecord
	before_create :create_role
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable, :confirmable,
	     :recoverable, :rememberable, :validatable, :trackable, :lockable

	has_many :users_roles
	has_many :roles, through: :users_roles
	has_many :survey_attempts, dependent: :destroy

	def create_role
		self.roles << Role.find_by_name(:user)
	end

	def is_admin?
		self.roles.exists?(name: :admin)
	end
end
