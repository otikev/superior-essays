class SeMailer < ApplicationMailer

    def login_email
        @user = params[:user]
        mail(:to=>"oti.kevin@gmail.com", :subject=>"User Login : Superior Essays")
    end

end
