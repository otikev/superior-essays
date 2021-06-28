# == Schema Information
#
# Table name: contents
#
#  id         :bigint           not null, primary key
#  answer     :text
#  key        :uuid
#  published  :boolean          default(FALSE)
#  question   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Content < ApplicationRecord

end
