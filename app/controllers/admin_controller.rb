class AdminController < ApplicationController
  before_action :must_have_admin_user

  def dashboard
    @upcoming_orders = Order.upcoming_orders(10)
    @todo_orders_count = Order.where(order_status_id: 1).count
    @in_progress_orders_count = Order.where(order_status_id: 2).count
    @complete_orders_count = Order.where(order_status_id: 3).count
    @created_orders_data = Indicator.retrieve_order_data(10.days)
  end

  def users_clients
    @role = "client"
    respond_to do |format|
      format.html
      format.json { render json: UsersDatatable.new(view_context) }
    end
  end

  def users_admins
    @role = "admin"
    respond_to do |format|
      format.html
      format.json { render json: UsersDatatable.new(view_context) }
    end
  end

  def orders_todo
    @order_status = OrderStatus.where(name: "Todo").first
    respond_to do |format|
      format.html
      format.json { render json: AdminOrdersDatatable.new(view_context) }
    end
  end

  def orders_in_progress
    @order_status = OrderStatus.where(name: "In Progress").first
    respond_to do |format|
      format.html
      format.json { render json: AdminOrdersDatatable.new(view_context) }
    end
  end

  def orders_complete
    @order_status = OrderStatus.where(name: "Complete").first
    respond_to do |format|
      format.html
      format.json { render json: AdminOrdersDatatable.new(view_context) }
    end
  end

  def orders_closed
    @order_status = OrderStatus.where(name: "Closed").first
    respond_to do |format|
      format.html
      format.json { render json: AdminOrdersDatatable.new(view_context) }
    end
  end
end
