class LandingController < ApplicationController
    layout 'www'

    def home
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
