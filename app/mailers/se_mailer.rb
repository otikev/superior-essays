class SeMailer < ApplicationMailer
    include ActionView::Helpers::UrlHelper

    def login_email
        @user = params[:user]
        mail(:to=>"oti.kevin@gmail.com", :subject=>"User Login : Superior Essays")
    end

    def order_created
        puts "=============== order created email =================="
        @order = params[:order]
        recipient = params[:recipient]
        
        puts "##### send to email #{recipient}"
        mail(:to => recipient, :subject => "Order Created : #{@order.code} - #{@order.topic}")
        puts "======================================================"
    end

    def order_paid
        @order = params[:order]
        recipient = params[:recipient]
        mail(:to => recipient, :subject => "Order Paid : #{@order.code} - #{@order.topic}")
    end
end
