class ApplicationController < ActionController::Base
  before_action :fetch_logged_in_user, :fetch_prices

  def fetch_logged_in_user
    @current_url = request.url

    puts "Session = #{session.to_json}"
    if session[:auth_token] && session[:auth_token].length > 0
      puts "finding user..."
      @current_user = User.find_by!(key: session[:auth_token])
      puts "User = #{@current_user.to_json}"
    end
  end

  def must_have_user
    if !@current_user
      puts "**************** User does not exist!"
      redirect_to root_path
    else
      puts "**************** User exists"
    end
  end

  def must_have_admin_user
    if @current_user && @current_user.admin?
      puts "**************** User exists"
    else
      puts "**************** User does not exist!"
      redirect_to root_path
    end
  end

  #Quick implementation to be refactored later
  def fetch_prices
    @pricing_matrix = Hash.new
    @pricing_matrix["urgency"] = ['10 days','7 days','5 days','4 days','3 days','48 hours','24 hours','12 hours','6 hours','3 hours']
    @pricing_matrix["standard_quality"] = [13,14,15,16,17,18,19,20,21,22]
    @pricing_matrix["premium_quality"] = [15,16,17,18,19,20,21,22,23,24]
    @pricing_matrix["platinum_quality"] = [17,18,19,20,21,22,23,24,25,26]
  end
end
