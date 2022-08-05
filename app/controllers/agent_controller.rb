class AgentController < ApplicationController
    skip_before_action :fetch_logged_in_user
    skip_before_action :verify_authenticity_token
    before_action :validate_agent_token

    def start
        SeMailer.with(recipient: "oti.kevin@gmail.com", host: params[:host]).delay.agent_started
        render plain: 'OK'
    end

    def batch_complete
        puts "batch complete *****"
        Content.bot_creation_email_notification(host)
        render plain: 'OK'
    end

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

    private
    def validate_agent_token
        header_token = request.headers["HTTP_SE_AGENT_TOKEN"]
        env_token = ENV["SE_AGENT_TOKEN"]

        if !env_token
            env_token = "randomvaluefortestthatisusedwhenthereisnotokensetintheenvironmentvariables"
        end

        if header_token != env_token
            puts "Invalid agent token"
            render plain: 'unauthorised', :status => :unauthorized
        else
            puts "Agent token is valid"
        end
    end
end
