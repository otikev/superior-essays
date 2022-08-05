# == Schema Information
#
# Table name: contents
#
#  id           :bigint           not null, primary key
#  answer       :text
#  content_type :integer
#  key          :uuid
#  notified     :boolean          default(FALSE)
#  published    :boolean          default(FALSE)
#  question     :text
#  slug         :string
#  source       :string
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#
# Indexes
#
#  index_contents_on_slug  (slug) UNIQUE
#
class Content < ApplicationRecord
    extend FriendlyId
    require 'base64'

    self.per_page = 10
    
    friendly_id :title, use: :slugged

    def next
        next_content = Content.where("id < ? and content_type = ? and published = true", self.id, self.content_type).order('id DESC').first
        return nil if !next_content
        puts "Next content = #{next_content.id}"
        next_content
    end

    def previous
        previous_content = Content.where("id > ? and content_type = ? and published = true", self.id, self.content_type).order('id ASC').first
        return nil if !previous_content
        puts "Previous content = #{previous_content.id}"
        previous_content
    end

    def self.total_items(content_type, is_published)
        Content.where("content_type = ? and published = ?", content_type, is_published).count
    end

    def decode_source
        if base64?(source)
            decoded = Base64.decode64(source)
        else
            decoded = source
        end
        decoded
    end

    def self.bot_creation_email_notification(host)
        new_contents = Content.where("notified = ? and source is not null").order('id ASC').all
        
        if new_contents && new_contents.count > 0
            User.includes(:user_settings).where(admin: true).all.each do |admin|
                email_updates = admin.user_settings.where(name: SEConstants::UserSettings::EMAIL_UPDATES)
                if email_updates.first.value == "true"
                    SeMailer.with(content: new_contents,recipient: admin.email, recipient_name: admin.first_name, host: params[:host]).delay.new_content_notification
                    new_contents.update_all(notified: true)
                end
              end
        end
    end

    private
    def base64?(value)
        value.is_a?(String) && Base64.strict_encode64(Base64.decode64(value)) == value
    end
end
