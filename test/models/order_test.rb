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
#  paid            :boolean          default("false")
#  token           :string
#  price           :integer
#

require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
