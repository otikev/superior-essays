# == Schema Information
#
# Table name: contents
#
#  id         :bigint           not null, primary key
#  answer     :text
#  key        :uuid
#  published  :boolean          default(FALSE)
#  question   :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_contents_on_title  (title) UNIQUE
#
class Content < ApplicationRecord
    self.per_page = 10
    
    validates_uniqueness_of :title

    def to_param
        title
    end
end
