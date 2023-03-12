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

    def archives
        @contents = Content.where(:published => true, :content_type => SEConstants::ContentType::ARCHIVE).paginate(:page => params[:page]).order('id DESC')
    end

    def show
        @content = Content.where(:published => true, :content_type => SEConstants::ContentType::ARCHIVE).friendly.find(params[:id])
        @previous_content = @content.previous
        @next_content = @content.next
    end
end
