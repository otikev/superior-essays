class ApplicationController < ActionController::Base
  before_action :fetch_logged_in_user

  def fetch_logged_in_user
    @current_url = request.url

    puts "Session = #{session.to_json}"
    if session[:auth_token] && session[:auth_token].length > 0
      puts "finding user..."
      @current_user = User.find_by!(password: session[:auth_token])
      puts "User = #{@current_user.to_json}"
    end
  end

  def must_have_user
    if !@current_user
      redirect_to root_path
    end
  end
end
