class Admin::Api::Lessons::MassUpdatesController < Admin::Api::AdminController
	def create
		# puts lessons_params
		::Lessons::MassUpdate.create!(lessons_params)

		head :no_content
	end

	private
		def lessons_params
			params.permit(lessons: [:id, :position])[:lessons].values
		end
end