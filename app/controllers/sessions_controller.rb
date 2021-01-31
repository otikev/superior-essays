class SessionsController < ApplicationController

  def omniauth
    @user = User.from_omniauth(auth)
    @user.save

    session[:auth_token] = @user.password
    redirect_to client_home_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
