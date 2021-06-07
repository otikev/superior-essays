# == Schema Information
#
# Table name: order_types
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrderType < ApplicationRecord
  has_many :orders
end
