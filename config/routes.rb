Rails.application.routes.draw do
	#static pages
	root to: "static#main"
	get '/contacts', to: "static#contacts"

	#users
	devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
	devise_scope :user do
		get 'sign_in', :to => 'devise/sessions#new' , :as => :new_user_session
		get 'sign_out', :to => 'devise/sessions#destroy' , :as => :destroy_user_session
	end
	match '/users/:id/finish_signup/:token' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
	#user's profile
	resources :users do
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

			#course teachers
			resources :teacher_courses, only: [:index, :create, :destroy]

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

		#roles
		post 'add_admin', to: 'roles#add_admin'
		post 'add_teacher', to: 'roles#add_teacher'

		post 'remove_admin', to: 'roles#remove_admin'
		post 'remove_teacher', to: 'roles#remove_teacher'
		resources :roles, only: :index

		#api for sortable lessons
		namespace :api do
			namespace :lessons do
				resource :mass_update, only: :create
			end
		end
	end
end
