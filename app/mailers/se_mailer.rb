class SeMailer < ApplicationMailer
    include ActionView::Helpers::UrlHelper

    def login_email
        @user = params[:user]
        mail(:to=>"oti.kevin@gmail.com", :subject=>"User Login : Superior Essays")
    end

    def order_created
        @order = params[:order]
        recipient = params[:recipient]
        
        puts "##### send order created mail to #{recipient}"
        mail(:to => recipient, :subject => "Order Created : #{@order.code} - #{@order.topic}")
    end

    def order_paid
        @order = params[:order]
        recipient = params[:recipient]

        puts "##### send order paid mail to #{recipient}"
        mail(:to => recipient, :subject => "Order Paid : #{@order.code} - #{@order.topic}")
    end

    def file_uploaded
        @order = params[:order]
        @resource = params[:resource]
        recipient = params[:recipient]

        puts "##### send file uploaded mail to #{recipient}"
        mail(:to => recipient, :subject => "File Uploaded : #{@resource.file}")
    end

    def order_completed
        @order = params[:order]
        recipient = params[:recipient]

        puts "##### send order completed mail to #{recipient}"
        mail(:to => recipient, :subject => "Order Completed : #{@order.code} - #{@order.topic}")
    end

end
