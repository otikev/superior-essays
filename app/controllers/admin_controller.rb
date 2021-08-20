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
      flash[:danger] = @user_voucher.errors.full_messages[0]
    end
    redirect_to admin_user_path(:key => @user_voucher.user.key)
  end

  def enable_user
    @user = User.where(key:params[:key]).first
    @user.enabled = true
    @user.save!
    flash[:success] = "User enabled"
    redirect_to admin_user_path(:key => @user.key)
  end

  def disable_user
    @user = User.where(key:params[:key]).first

    if @user.key == @current_user.key
      flash[:warning] = "You cannot disable yourself!"
      redirect_to admin_user_path(:key => @user.key) and return false
    end

    if @user.email == "oti.kevin@gmail.com"
      flash[:warning] = "You cannot disable this user!"
      redirect_to admin_user_path(:key => @user.key) and return false
    end

    @user.enabled = false
    @user.save!
    flash[:success] = "User disabled"
    redirect_to admin_user_path(:key => @user.key)
  end

  private

  def user_voucher_params
    params.require(:user_voucher).permit(:user_id, :voucher_id)
  end
end
