class SiteController < ApplicationController

  def home
    if @current_user && @current_user.admin?
      redirect_to admin_orders_todo_path
    elsif @current_user && !@current_user.admin?
      redirect_to client_orders_todo_path
    end
  end

  def pricing
    @order = Order.new
  end
end
