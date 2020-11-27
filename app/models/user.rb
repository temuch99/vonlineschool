class User < ApplicationRecord
	before_create :create_role
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :confirmable, :lockable, :recoverable, 
	devise :database_authenticatable, :registerable, 
	     :rememberable, :validatable, :trackable

	has_many :users_roles
	has_many :roles, through: :users_roles
	has_many :survey_attempts, dependent: :destroy

	def create_role
		self.roles << Role.find_by_name(:user)
	end

	def kill
		self.users_roles.destroy_all
		self.destroy
	end

	def is_admin?
		self.roles.exists?(name: :admin)
	end
end
