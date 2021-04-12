# == Schema Information
#
# Table name: orders
#
#  id              :integer          not null, primary key
#  topic           :string
#  instructions    :text
#  key             :uuid
#  contact_phone   :string
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  order_status_id :integer
#  order_type_id   :integer
#  code            :string
#

class Order < ApplicationRecord
  require 'utils'

  belongs_to :user
  has_one :order_status
  has_one :order_type

  belongs_to :order_type
  belongs_to :order_status

  before_save do
    self.code = Utils.random_upcase_string(5)
  end

end
