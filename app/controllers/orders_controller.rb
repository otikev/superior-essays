class OrdersController < ApplicationController
  before_action :must_have_user

  def new
    @order = Order.new
  end

  def create
      @order = Order.new(order_params)
      @order.user_id = @current_user.id
      @order.order_status = OrderStatus.where(name: "Todo").first
      @order.save!
      flash[:notice] = "Order successfully created."
      redirect_to client_home_path
  end

  def fetch
    respond_to do |format|
      format.html
      format.json { render json: OrdersDatatable.new(view_context, @current_user) }
    end
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:order_type_id, :topic, :instructions, :contact_phone)
  end
end
