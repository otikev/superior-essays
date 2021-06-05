class SeMailer < ApplicationMailer

    def test_email
        puts "================= sending email ...."
        mail(:to=>"oti.kevin@gmail.com", :subject=>"Amazon SES Test Email")
    end

end
