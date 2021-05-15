class ClientController < ApplicationController
  before_action :must_have_user

  def home

  end

  def orders_todo
    @order_status = OrderStatus.where(name: "Todo").first
    respond_to do |format|
      format.html
      format.json { render json: OrdersDatatable.new(view_context) }
    end
  end

  def orders_in_progress
    @order_status = OrderStatus.where(name: "In Progress").first
    respond_to do |format|
      format.html
      format.json { render json: OrdersDatatable.new(view_context) }
    end
  end

  def orders_complete
    @order_status = OrderStatus.where(name: "Complete").first
    respond_to do |format|
      format.html
      format.json { render json: OrdersDatatable.new(view_context) }
    end
  end

end
