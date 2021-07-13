class AdminController < ApplicationController
  before_action :must_have_admin_user

  def dashboard
    @upcoming_orders = Order.upcoming_orders(10)
    @todo_orders_count = Order.where(order_status_id: 1).count
    @in_progress_orders_count = Order.where(order_status_id: 2).count
    @complete_orders_count = Order.where(order_status_id: 3).count
    @all_order_data = Indicator.all_order_data(10.days)
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

  def user
    @user = User.where(key:params[:key]).first
    @user_voucher = UserVoucher.new
    @user_voucher.user_id = @user.id
  end

  def assign_voucher
    @user_voucher = UserVoucher.new(user_voucher_params)
    if @user_voucher.save
      flash[:success] = "Voucher created"
    else
      flash[:danger] = "Voucher not created"
    end
    user = User.where(id: @user_voucher.user_id).first
    redirect_to admin_user_path(:key => user.key)
  end

  private

  def user_voucher_params
    params.require(:user_voucher).permit(:user_id, :voucher_id)
  end
end
