class RatingsController < BaseController
	def index
		# потом изменить
		# @users = User.select {|u| !u.is_admin?}
		@users = User.all
		@users = @users.sort_by {|u| u.scores}
		@users = @users.reverse
	end

	private
	def set_active_header_item
      @header[:ratings][:active] = true
    end
end
