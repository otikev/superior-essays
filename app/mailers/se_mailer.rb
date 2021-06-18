class SeMailer < ApplicationMailer
    include ActionView::Helpers::UrlHelper

    SUPPORT_EMAIL = "superioressayspro@gmail.com"

    def login_email
        @user = params[:user]
        mail(:to=>"oti.kevin@gmail.com", :subject=>"User Login : Superior Essays")
    end

    def order_created
        puts "=============== order created email =================="
        @order = params[:order]
        recipients = [SUPPORT_EMAIL]
        User.includes(:user_settings).where(admin: true).all.each do |admin|
            email_updates = admin.user_settings.where(name: SEConstants::UserSettings::EMAIL_UPDATES)
            if email_updates.first.value == "true"
                recipients.push(admin.email)
            end
        end
        
        puts "##### send to email #{recipients}"
        mail(:bcc => recipients, :subject => "Order Created : #{@order.topic}")
        puts "======================================================"
    end

    def order_paid

    end
end
