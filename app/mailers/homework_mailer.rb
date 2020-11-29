class HomeworkMailer < ApplicationMailer
	default from: 'temuch@vonlineschool.ru'

	def checked_homework
		@user = params[:user]
		mail(to: @user.email, subject: 'Домашнее задание')
	end
end
