class ArchivesController < ApplicationController

    def list
        @contents = Content.where(:published => true, :content_type => SEConstants::ContentType::ARCHIVE).paginate(:page => params[:page]).order('id DESC')
    end

    def show
        @content = Content.where(:content_type => SEConstants::ContentType::ARCHIVE).friendly.find(params[:id])
        @previous_content = @content.previous
        @next_content = @content.next
    end
end