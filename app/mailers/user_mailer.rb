class UserMailer < ApplicationMailer
	default from: 'temuch@vonlineschool.ru'

	def welcome_email
		@user = params[:user]
		@url  = 'vonlineschool.ru'
		mail(to: @user, subject: 'Welcome to My Awesome Site')
	end
end
