class SessionsController < ApplicationController

  def create
    puts "omniauth **************"
    @user = User.from_omniauth(auth)

    if !@user.enabled
      session[:auth_token] = nil
      redirect_to root_path and return false
    end

    @user.save!

    session[:auth_token] = @user.key
    
    if @user.admin?
      redirect_to admin_dashboard_path
    else
      redirect_to orders_new_path
    end
  end

  def logout
    session[:auth_token] = nil
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
