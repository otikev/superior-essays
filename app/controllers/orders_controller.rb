class OrdersController < ApplicationController
  before_action :must_have_user

  def new
    @order = Order.new
  end

  def create
      @order = Order.new(order_params)
      @order.user_id = @current_user.id
      @order.save
      flash[:notice] = "Order successfully created."
      redirect_to client_home_path
  end

  private
  def order_params
    params.require(:order).permit(:order_type, :topic, :instructions,:contact_phone)
  end
end
