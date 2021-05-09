class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :vkontakte

  def vkontakte
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      # sign_in_and_redirect @user, event: :authentication
      sign_in @user
      set_flash_message(:notice, :success, kind: "vkontakte") if is_navigational_format?
      redirect_to(@user.activated ? root_url : finish_signup_path(@user.id, @user.activation_token))
    else
      session["devise.vkontakte_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_session_url
    end
  end

  def failure
    redirect_to root_path
  end
end