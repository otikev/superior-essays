class ApplicationController < ActionController::Base
  before_action :fetch_logged_in_user

  def fetch_logged_in_user
    @current_url = request.url

    if session[:auth_token] && session[:auth_token].length > 0
      @current_user = User.find_by!(key: session[:auth_token])
    end
  end

  def must_have_user
    if !@current_user
      puts "**************** User does not exist!"
      redirect_to root_path
    end
  end

  def must_have_admin_user
    if !@current_user || !@current_user.admin?
      puts "**************** User does not exist!"
      redirect_to root_path
    end
  end
end
