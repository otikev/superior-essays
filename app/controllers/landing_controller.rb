class LandingController < ApplicationController
    layout 'www'

    def home
        @clients_count = 763 + User.all.count*3
        @orders_count = 3052 + Order.all.count*3
        @support_hours_count = Message.all.count*25
    end

    def privacy

    end

    def terms

    end
end
