# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  user_id    :integer          default("0")
#  message    :string
#  category   :integer
#  key        :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
