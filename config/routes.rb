Rails.application.routes.draw do
	#static pages
	root to: "static#main"
	get '/contacts', to: "static#contacts"

	#users
	devise_for :users, controllers: {
		sessions: 'users/sessions',
		registrations: 'users/registrations',
		passwords: 'users/passwords',
		confirmations: "users/confirmations",
		unlocks: "users/unlocks"
	}
	#user's profile
	resources :users, only: [:show, :index]

	#courses
	resources :courses, only: [:show, :index] do
		#lessons
		resources :lessons, only: [:show, :index] do
			#surveys
			resources :survey_attempts, only: [:new, :create, :show, :destroy] do
				resources :questions, except: :new
			end
		end
	end

	#admin dashboard
	namespace :admin do
		#courses
		root to: 'courses#index'
		resources :courses, except: :show do
			#lessons
			resources :lessons, except: :show do
				#questions
				resources :questions, except: :show
			end
		end

		#api for sortable lessons
		namespace :api do
			namespace :lessons do
				resource :mass_update, only: :create
			end
		end
	end
end
