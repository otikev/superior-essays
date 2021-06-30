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
end
