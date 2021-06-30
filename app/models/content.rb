# == Schema Information
#
# Table name: contents
#
#  id         :bigint           not null, primary key
#  answer     :text
#  key        :uuid
#  published  :boolean          default(FALSE)
#  question   :text
#  slug       :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_contents_on_slug  (slug) UNIQUE
#
class Content < ApplicationRecord
    extend FriendlyId

    self.per_page = 10
    
    friendly_id :title, use: :slugged

    def next
        next_content = Content.where("id < ? and published = true",self.id).order('id DESC').first
        return nil if !next_content
        puts "Next content = #{next_content.id}"
        next_content
    end

    def previous
        previous_content = Content.where("id > ? and published = true",self.id).order('id ASC').first
        return nil if !previous_content
        puts "Previous content = #{previous_content.id}"
        previous_content
    end
end
