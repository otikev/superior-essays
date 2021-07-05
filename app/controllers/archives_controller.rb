class ArchivesController < ApplicationController

    def list
        @contents = Content.where(:published => true).paginate(:page => params[:page]).order('id DESC')
    end

    def show
        @content = Content.friendly.find(params[:id])
        @previous_content = @content.previous
        @next_content = @content.next
        puts "Current content = #{@content.id}"
    end
end