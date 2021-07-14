class ContentController < ApplicationController

    before_action :must_have_admin_user

    def edit
        ky = params[:key]
        @content = Content.where(key:ky).first
    end

    def admin
        @type = params[:type].to_i
        @published = params[:published] == "true"

        if !params[:published]
            @published = true
        end
        
        @type_name = ""

        if @type == SEConstants::ContentType::ARCHIVE
            @type_name = "Archive"
        elsif @type == SEConstants::ContentType::SAMPLE
            @type_name = "Samples"
        else
            @type = SEConstants::ContentType::ARCHIVE
            @type_name = "Archive"
        end

        @total_published_content = Content.total_items(@type, true)
        @total_unpublished_content = Content.total_items(@type, false)
        @contents = Content.where(content_type: @type, published: @published).paginate(:page => params[:page]).order('id DESC')
    end

    def update
        @content = Content.where(key: params[:content][:key]).first
        @content.question = params[:content][:question]
        @content.answer = params[:content][:answer]
        @content.published = params[:content][:published]
        @content.content_type = params[:content][:content_type]
        @content.title = params[:content][:title]
        @content.save!
        flash[:success] = "Content successfully updated"
        redirect_to content_admin_path(type: @content.content_type, published: @content.published)
    end

    def create
        @content = Content.new(content_params)
        @content.user_id = @current_user.id
        @content.save!
        flash[:success] = "Content successfully created"
        redirect_to content_edit_path(key: @content.key)
    end

    def new
        @content = Content.new
    end

    private
    def content_params
        params.require(:content).permit(:title, :question, :answer, :content_type)
    end
end
