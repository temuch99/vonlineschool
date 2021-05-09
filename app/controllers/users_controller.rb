class UsersController < BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :finish_signup]
  before_action :check_token, only: [:finish_signup]

  def index
    @users = User.all
  end

  # GET /users
  def new
  end

  # POST
  def create
    user = User.find_by(nickname: params[:session][:nickname])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to root_url, notice: "Вы успешно вошли в систему"
    else
      flash.now[:danger] = "Ошибка в Нике или Пароля"
      render 'new'
    end
  end

  # GET /users/:id.:format
  def show
    # authorize! :read, @user
  end

  # GET /users/:id/edit
  def edit
    # authorize! :update, @user
  end

  # PATCH/PUT /users/:id.:format
  def update
    # authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Ваш профиль был обновлен' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # # GET/PATCH /users/:id/finish_signup
  def finish_signup
    # authorize! :update, @user 
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        sign_in(@user, :bypass => true)
        @user.update(activated: true)
        redirect_to @user, notice: 'Ваш профиль был обновлен'
      else
        @show_errors = true
      end
    end
  end

  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
  
  private
  def set_user
    @user = User.find(params[:id])
  end

  def check_token
    unless @user.activation_token == params[:token]
      redirect_to root_url, notice: "Вы не имеете права обновлять профиль пользователя"
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, 
                                  :nickname, :password, :password_confirmation)
  end

  def set_active_header_item
  	@header[:users][:active] = true
  end
end
