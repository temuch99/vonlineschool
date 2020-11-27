class UserMailer < ApplicationMailer
	default from: 'temuch@vonlineschool.ru'

	def welcome_email
		@user = params[:user]
		@url  = 'vonlineschool.ru'
		mail(to: @user.email, subject: 'Добро пожаловать на сайт')
	end
end
