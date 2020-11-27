class UsersController < BaseController
  def show
  	@user = User.find(params[:id])
  end

  def index
  	# !!!!!!!Подумать, как вытащить только пользователей
  	@users = User.all
  end

  private
  def set_active_header_item
  	@header[:users][:active] = true
  end
end
