class SeMailer < ApplicationMailer
    include ActionView::Helpers::UrlHelper

    def login_email
        @user = params[:user]
        mail(:to=>"oti.kevin@gmail.com", :subject=>"User Login : Superior Essays")
        Indicator.generate_system_signal(SEConstants::Signals::EMAILS_QUEUED)
    end

    def order_created
        @order = params[:order]
        recipient = params[:recipient]
        
        puts "##### send order created mail to #{recipient}"
        mail(:to => recipient, :subject => "Order Created : #{@order.code} - #{@order.topic}")
        Indicator.generate_system_signal(SEConstants::Signals::EMAILS_QUEUED)
    end

    def order_paid
        @order = params[:order]
        recipient = params[:recipient]

        puts "##### send order paid mail to #{recipient}"
        mail(:to => recipient, :subject => "Order Paid : #{@order.code} - #{@order.topic}")
        Indicator.generate_system_signal(SEConstants::Signals::EMAILS_QUEUED)
    end

    def file_uploaded
        @order = params[:order]
        @resource = params[:resource]
        recipient = params[:recipient]

        puts "##### send file uploaded mail to #{recipient}"
        mail(:to => recipient, :subject => "File Uploaded : #{@resource.file}")
        Indicator.generate_system_signal(SEConstants::Signals::EMAILS_QUEUED)
    end

    def order_completed
        @order = params[:order]
        recipient = params[:recipient]

        puts "##### send order completed mail to #{recipient}"
        mail(:to => recipient, :subject => "Order Completed : #{@order.code} - #{@order.topic}")
        Indicator.generate_system_signal(SEConstants::Signals::EMAILS_QUEUED)
    end

    def user_review
        @review = params[:review]
        @order = params[:order]
        recipient = params[:recipient]

        puts "##### send user review mail to #{recipient}"
        mail(:to => recipient, :subject => "Client Review : #{@order.code} - #{@order.topic}")
        Indicator.generate_system_signal(SEConstants::Signals::EMAILS_QUEUED)
    end

    def contact_form
        @contact = params[:contact]
        recipient = params[:recipient]
        mail(:to=> recipient, :subject=>"Contact Form : #{@contact.subject}")
        Indicator.generate_system_signal(SEConstants::Signals::EMAILS_QUEUED)
    end

end
