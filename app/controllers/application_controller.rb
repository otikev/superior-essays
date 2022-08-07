class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  before_action :fetch_logged_in_user
  

  def fetch_logged_in_user
    puts "fetching logged in user..."
    @current_url = request.url

    if session[:auth_token] && session[:auth_token].length > 0
      @current_user = User.find_by!(key: session[:auth_token])
    end

    if @current_user && !@current_user.enabled
      session[:auth_token] = nil
      redirect_to root_path and return false
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

  def render_not_found
    render :file => "#{Rails.root}/public/error_404.html",  :status => 404
  end

end
