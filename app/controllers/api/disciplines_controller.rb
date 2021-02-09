class Api::DisciplinesController < Api::ApiController
	def index
		@disciplines = Discipline.all
		render json: @disciplines
	end
end
