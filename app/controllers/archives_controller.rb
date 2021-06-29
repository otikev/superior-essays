class ArchivesController < ApplicationController

    def list
        @contents = Content.where(:published => true).paginate(:page => params[:page]).order('id DESC')
    end

    def show
        if params[:id]
            @content = Content.find_by_name(params[:id])
        else
            @content = Content.order("created_at desc").first
        end
    end

end
