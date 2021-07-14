class LandingController < ApplicationController
    layout 'www'

    def home
        @clients_count = 763 + User.all.count
        @orders_count = 3052 + Order.all.count
        @support_hours_count = Message.all.count*25
    end

    def privacy

    end

    def terms

    end

    def contact
        contact = Contact.new(contact_params)
        contact.deliver
    end

    private

    def contact_params
        params.require(:contact).permit(:name, :email, :subject,
        :message)
    end
end
