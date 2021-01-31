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

  private

  def auth
    request.env['omniauth.auth']
  end
end
