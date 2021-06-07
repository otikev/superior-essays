# == Schema Information
#
# Table name: order_statuses
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrderStatus < ApplicationRecord
  has_many :orders
end
