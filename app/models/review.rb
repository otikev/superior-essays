# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  message    :string
#  stars      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer
#  user_id    :integer
#
class Review < ApplicationRecord
    has_one :order
    has_one :user

    belongs_to :order
    belongs_to :user
end
