class ArchivesController < ApplicationController

    def list
        @contents = Content.where(:published => true).paginate(:page => params[:page]).order('id DESC')
    end

    def show
        @content = Content.friendly.find(params[:id])
        @previous_content = Content.find_by_id(@content.id+1)
        @next_content = Content.find_by_id(@content.id-1)
    end

end
