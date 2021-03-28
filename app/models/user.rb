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
	has_many :offline_survey_attempts, dependent: :destroy

	mount_uploader :avatar, ImageUploader

	def full_name
		"#{self.first_name} #{self.last_name}"
	end

	def create_role
		self.roles << Role.find_by_name(:user)
	end

	def is_user?
		self.roles.exists?(name: :user)
	end

	def is_admin?
		self.roles.exists?(name: :admin)
	end

	def survey_scores
		self.survey_attempts.select("lesson_id").group("lesson_id").maximum("result").values.sum
	end

	def homework_scores
		self.homework_attempts.select("lesson_id").group("lesson_id").maximum("result").values.sum
	end

	def offline_scores
		self.offline_survey_attempts.select("lesson_id").group("lesson_id").maximum("result").values.sum
	end

	def scores
		self.survey_scores + self.homework_scores + self.offline_scores
	end

	def done_lesson?(lesson)
		ha = self.homework_attempts.where(lesson_id: lesson.id).count > 0
		sa = self.survey_attempts.where(lesson_id: lesson.id).count > 0
		# oa = lesson.is_offline_survey ? self.offline_survey_attempts.where(lesson_id: lesson.id).count > 0 : false
		ha & sa #& oa
	end
end
