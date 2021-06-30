class ArchivesController < ApplicationController

    def list
        @contents = Content.where(:published => true).paginate(:page => params[:page]).order('id DESC')
    end

    def show
        @content = Content.friendly.find(params[:id])
        puts "Current content = #{@content.id}"
        @previous_content = @content.previous
        @next_content = @content.next
    end
end