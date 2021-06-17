class SeMailer < ApplicationMailer
    include ActionView::Helpers::UrlHelper

    def login_email
        @user = params[:user]
        mail(:to=>"oti.kevin@gmail.com", :subject=>"User Login : Superior Essays")
    end

    def order_created
        puts "=============== order created email =================="
        @order = params[:order]
        User.includes(:user_settings).where(admin: true).all.each do |admin|
            puts "############# Admin user #{admin.to_json}"
            email_updates = admin.user_settings.where(name: SEConstants::UserSettings::EMAIL_UPDATES)
            puts "###### Email settings = #{email_updates.to_json}"
            if email_updates.first.value == "true"
                puts "##### send to email #{admin.email}"
                mail(:to => admin.email, :subject => "Order Created : #{@order.topic}")
            end
        end
        puts "======================================================"
    end

end
