class UsersController < BaseController
  def show
  	@user = User.find(params[:id])
  end

  def smail
    UserMailer.with(user: "porubenko99@mail.ru").welcome_email.deliver_now

    @users = User.all
    render "index"
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
