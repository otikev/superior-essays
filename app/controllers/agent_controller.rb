class AgentController < ApplicationController
    skip_before_action :fetch_logged_in_user
    skip_before_action :verify_authenticity_token

    def question_exists
        link = params[:url]
        @content = Content.where(source: link).first

        render plain: (@content != nil).to_s
    end

    def question_create
        puts "******************"
        puts params
        puts "******************"

        @content = Content.new
        @content.title = params[:title]
        @content.source = params[:link]
        @content.question = params[:question]
        @content.published = true
        @content.content_type=SEConstants::ContentType::ARCHIVE
        @content.save!

        render plain: 'Created'
    end
end
