# == Schema Information
#
# Table name: order_qualities
#
#  id         :bigint           not null, primary key
#  quality    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrderQuality < ApplicationRecord
    has_many :orders
end
