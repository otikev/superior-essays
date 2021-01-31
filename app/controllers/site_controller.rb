class SiteController < ApplicationController

  def home
    if @current_user && !@current_user.admin?
      redirect_to client_home_path
    end
  end

end
