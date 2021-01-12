class Admin::BanksController < Admin::AdminController
	def index
		@course = Course.find(params[:course_id])
	end

	private
	def set_active_header_item
      @header[:courses][:active] = true
    end
end
