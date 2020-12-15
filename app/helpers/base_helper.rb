module BaseHelper
	def set_header
		@header = { 
			main: { name: 'Главная', path: root_path },
			contacts: { name: 'Контакты', path: contacts_path },
			users: {name: "Пользователи", path: users_path},
			courses: {name: "Курсы", path: courses_path},
			ratings: { name: "Рейтинг", path: ratings_path }
		}

		if user_signed_in? and current_user.roles.exists?(name: :admin)
			@header[:admin] = { name: 'Админка', path: admin_root_path }
		end
	end

end
