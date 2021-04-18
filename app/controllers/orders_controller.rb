class OrdersController < ApplicationController
  before_action :must_have_user, :paypal_init

  def new
    @order = Order.new
  end

  def create
      @order = Order.new(order_params)
      @order.user_id = @current_user.id
      @order.order_status = OrderStatus.where(name: "Todo").first
      @order.price = 10.0 # TODO: This will be a dynamic value as calculated by the cost calculator
      @order.save!
      flash[:notice] = "Order successfully created."
      redirect_to client_home_path
  end

  def pay
    ky = params[:key]
    order = Order.where(key:ky).first

    request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
    request.request_body({
      :intent => 'CAPTURE',
      :purchase_units => [
        {
          :amount => {
            :currency_code => 'USD',
            :value => order.price
          }
        }
      ]
    })

    begin
      response = @client.execute request
      order.token = response.result.id
      if order.save
        return render :json => {:token => response.result.id}, :status => :ok
      end
    rescue PayPalHttp::HttpError => ioe
      # HANDLE THE ERROR
    end
  end

  # PAYPAL CAPTURE ORDER
  def capture_order
    request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest::new params[:token]
    begin
      response = @client.execute request
      order = Order.find_by :token => params[:token]
      order.paid = response.result.status == 'COMPLETED'
      if order.save
        return render :json => {:status => response.result.status}, :status => :ok
      end
    rescue PayPalHttp::HttpError => ioe
      # HANDLE THE ERROR
    end
  end

  def fetch
    respond_to do |format|
      format.html
      format.json { render json: OrdersDatatable.new(view_context) }
    end
  end

  def show
    ky = params[:key]
    @order = Order.where(key:ky).first

    if !@order # order not found!
      redirect_to root_path and return false
    end
  end

  private

  def order_params
    params.require(:order).permit(:order_type_id, :topic, :instructions, :contact_phone)
  end

  def paypal_init
    @env = ENV["PAYPAL_ENV"]
    @client_id = ENV["PAYPAL_CLIENT_ID"]
    client_secret = ENV["PAYPAL_CLIENT_SECRET"]
    environment = PayPal::SandboxEnvironment.new @client_id, client_secret
    @client = PayPal::PayPalHttpClient.new environment
  end
end
