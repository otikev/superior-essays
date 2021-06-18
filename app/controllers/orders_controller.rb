class OrdersController < ApplicationController
  require "base64"

  before_action :must_have_user, :paypal_init
  skip_before_action :verify_authenticity_token, :only => [:create_order,:capture_order]

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = @current_user.id
    @order.order_status = OrderStatus.where(name: "Todo").first
    @order.save!

    if @order.price == params[:total_price].to_i
      puts "**** backend and frontend pricing is the same"
    else
      puts "!!!! backend pricing differs from frontend pricing!"
    end

    flash[:notice] = "Order successfully created."
    redirect_to client_orders_todo_path
  end

  def create_order
    ky = params[:key]
    order = Order.where(key:ky).first

    request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
    request.request_body({
      :intent => 'CAPTURE',
      :purchase_units => [
        {
          :amount => {
            :currency_code => 'USD',
            :value => order.price.to_s
          }
        }
      ]
    })
    
    begin
      response = @client.execute(request)
      result = response.result
      puts "Result = #{result}"

      order.token = result.id
      if order.save!
        return render :json => {:token => order.token}, :status => :ok
      end
    rescue => exception
      puts exception.backtrace
      raise # always reraise
    end
  end

  # PAYPAL CAPTURE ORDER
  def capture_order
    request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest::new params[:token]
    begin
      response = @client.execute request
      order = Order.find_by :token => params[:token]
      order.paid = response.result.status == 'COMPLETED'
      order.paid_on = DateTime.now
      if order.save
        Indicator.generate_order_signal(SEConstants::Signals::ORDER_PAID,order)
        send_order_paid_emails(order)
        return render :json => {:status => response.result.status}, :status => :ok
      end
    rescue PayPalHttp::HttpError => ioe
      puts ioe.status_code
      puts ioe.headers["debug_id"]
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
    @resource = Resource.new
    @message = Message.new
    
    if !@order # order not found!
      redirect_to root_path and return false
    end

    if @order.is_reviewed?
      @review = Review.where(order_id: @order.id).first
    else
      @review = Review.new
    end

    # Only admins can see any order. If the current order does not belong to the 
    # current user and the user is not an admin redirect to root
    # TODO: Update this to apply to users assigned to the order (writers) and Support
    if !@current_user.admin? 
      if @order.user_id != @current_user.id
        redirect_to root_path and return false
      end
    end

  end

  def download_resource
    resource = Resource.where(key: params[:key]).first
    if resource
      file = resource.get_file_from_s3
      extension = File.extname(resource.file).slice!(0)
      send_file file,filename: "#{resource.file}",type: "application/#{extension}"
    else
      not_found
    end
  end

  def review
    order = Order.where(key: params[:review][:order_key]).first
    if order
      Review.new(
        stars: params[:review][:stars].to_i, 
        message: params[:review][:message], 
        order_id: order.id, 
        user_id: @current_user.id
      ).save!
    else
      not_found
    end
    redirect_to orders_show_path(:key => order.key)
  end

  def update_status
    order = Order.where(key: params[:order][:key]).first
    if order
      order.order_status_id = params[:order][:order_status_id].to_i
      order.save!
    else
      not_found
    end
    redirect_to orders_show_path(:key => order.key)
  end

  def delete_resource
      resource = Resource.where(key: params[:resource][:key]).first
      order = resource.order
      if resource
        resource.delete
      else
        not_found
      end
      redirect_to orders_show_path(:key => order.key)
  end

  def upload_resource
    order = Order.where(id: params[:resource][:order_id]).first

    if !order # order not found!
      puts 'Cannot find order'
      redirect_to root_path and return false
    end

    accepted_formats = ['.pdf', '.doc', '.docx', '.txt']
    uploaded_io = params[:resource][:file]
    extension = File.extname(uploaded_io.original_filename)
    if accepted_formats.include? extension.downcase
      upload = Resource.upload_to_s3(params)
      if !upload.save
        flash[:danger] = Utils.get_error_string(upload,'File not uploaded')
        redirect_to orders_show_path(:key => order.key) and return false
      end
    else
      flash[:danger] = 'Invalid file type.'
      redirect_to orders_show_path(:key => order.key) and return false
    end

    redirect_to orders_show_path(:key => order.key)
  end

  private

  def resource_params
    params.require(:resource).permit(:order_id, :resource_type_id, :name,
      :description, :file)
  end

  def order_params
    params.require(:order).permit(:order_type_id, :topic, :instructions,
      :order_quality_id, :order_urgency_id, :pages, :academic_level_id,
      :english_type_id, :paper_format_id, :spacing, :subject_id, :sources_count)
  end

  def paypal_init
    @env = ENV["PAYPAL_ENV"]
    @client_id = ENV["PAYPAL_CLIENT_ID"]
    client_secret = ENV["PAYPAL_CLIENT_SECRET"]
    if @env == 'sandbox'
      environment = PayPal::SandboxEnvironment.new @client_id, client_secret
    else
      environment = PayPal::LiveEnvironment.new @client_id, client_secret
    end
    @client = PayPal::PayPalHttpClient.new environment

    puts "Paypal Client = #{@client.to_json}"
  end

  def send_order_paid_emails(db_order)
    SeMailer.with(order: db_order, recipient: SEConstants::SUPPORT_EMAIL).delay.order_paid
    User.includes(:user_settings).where(admin: true).all.each do |admin|
      email_updates = admin.user_settings.where(name: SEConstants::UserSettings::EMAIL_UPDATES)
      if email_updates.first.value == "true"
          SeMailer.with(order: db_order, recipient: admin.email).delay.order_paid
      end
    end
  end
end
