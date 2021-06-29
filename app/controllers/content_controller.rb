class ContentController < ApplicationController

    before_action :must_have_admin_user

    def edit
        ky = params[:key]
        @content = Content.where(key:ky).first
    end

    def admin
        @contents = Content.paginate(:page => params[:page]).order('id DESC')
    end

    def update
        @content = Content.where(key: params[:content][:key]).first
        @content.question = params[:content][:question]
        @content.answer = params[:content][:answer]
        @content.published = params[:content][:published]
        @content.title = params[:content][:title]
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

    private
    def content_params
        params.require(:content).permit(:title, :question, :answer)
    end
end
