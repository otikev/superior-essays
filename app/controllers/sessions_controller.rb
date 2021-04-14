class SessionsController < ApplicationController

  def omniauth
    @user = User.from_omniauth(auth)
    @user.save

    session[:auth_token] = @user.password

    if @user.admin?
      redirect_to admin_home_path
    else
      redirect_to client_home_path
    end
  end

  def logout
    if session[:auth_token] && session[:auth_token].length > 0
      user = User.find_by!(password: session[:auth_token])
      user&.update_attribute(:password, nil)
      session.delete(:auth_token)
    end
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
