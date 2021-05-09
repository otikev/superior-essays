# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  user_id    :integer          default("0")
#  message    :string
#  type       :integer
#  key        :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ApplicationRecord

  has_one :order
  has_one :user

  belongs_to :order
  belongs_to :user

end
