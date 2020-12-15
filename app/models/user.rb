class User < ApplicationRecord
	before_create :create_role
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :confirmable, :lockable, :recoverable, 
	devise :database_authenticatable, :registerable, 
	     :rememberable, :validatable, :trackable

	has_many :users_roles, dependent: :destroy
	has_many :roles, through: :users_roles
	has_many :survey_attempts, dependent: :destroy
	has_many :homework_attempts, dependent: :destroy

	def create_role
		self.roles << Role.find_by_name(:user)
	end

	def is_user?
		self.roles.exists?(name: :user)
	end

	def is_admin?
		self.roles.exists?(name: :admin)
	end

	def scores
		self.survey_attempts.select("lesson_id").group("lesson_id").maximum("result").values.sum
	end
end
