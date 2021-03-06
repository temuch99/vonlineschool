Rails.application.routes.draw do
	#static pages
	root to: "static#main"
	get '/contacts', to: "static#contacts"

	#users
	devise_for :users, controllers: {
		sessions: 'users/sessions',
		registrations: 'users/registrations',
		passwords: 'users/passwords'
		# confirmations: "users/confirmations",
		# unlocks: "users/unlocks"
	}
	#user's profile
	resources :users, only: [:show, :index] do
		resources :course_statistics, only: :show
	end

	#rating
	resources :ratings, only: :index

	#API
	namespace :api do
		resources :users, only: :show do
			resources :courses, only: :show
		end

		resources :disciplines, only: :index do
			resources :questions, only: :show
		end
	end

	#courses
	resources :courses, only: [:show, :index] do

		#lessons
		resources :lessons, only: [:show, :index] do
			#surveys
			resources :survey_attempts, only: [:new, :create, :show, :destroy] do
				resources :questions, except: :new
			end

			#homeworks
			resources :homeworks, only: [:new, :create]
		end
	end

	#admin dashboard
	namespace :admin do
		#disciplines
		resources :disciplines, except: :show do

			resources :extension_questions do
			end
		end

		#courses
		root to: 'courses#index'
		resources :courses, except: :show do

			#banks
			# get "questions", to: "banks#index"

			#course access
			get 'all_access', to: 'course_accesses#all_access'
			resources :course_accesses, only: [:index, :destroy, :create]

			#lessons
			resources :lessons, except: :show do
				#questions
				resources :questions, except: :show

				#offline_survey_attempts
				resources :offline_survey_attempts, except: :show
			end
		end

		#homeworks
		resources :homework_attempts, only: [:show, :index, :update]

		#surveys
		resources :survey_attempts, only: [:index, :destroy]

		#api for sortable lessons
		namespace :api do
			namespace :lessons do
				resource :mass_update, only: :create
			end
		end
	end
end
