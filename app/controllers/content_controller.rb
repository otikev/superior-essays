class ContentController < ApplicationController

    before_action :must_have_admin_user, :only => [:create, :new, :admin, :edit, :update]

    def edit
        ky = params[:key]
        @content = Content.where(key:ky).first
    end

    def admin
        @contents = Content.paginate(:page => params[:page]).order('id DESC')
    end
    
    def client
        @contents = Content.where(:published => true).paginate(:page => params[:page]).order('id DESC')
    end

    def update
        @content = Content.where(key: params[:content][:key]).first
        @content.question = params[:content][:question]
        @content.answer = params[:content][:answer]
        @content.published = params[:content][:published]
        @content.save!
        redirect_to content_admin_path
    end

    def create
        @content = Content.new(content_params)
        @content.user_id = @current_user.id
        @content.save!
        redirect_to content_admin_path
    end

    def new
        @content = Content.new
    end

    def show

    end

    private
    def content_params
        params.require(:content).permit(:question, :answer)
    end
end
