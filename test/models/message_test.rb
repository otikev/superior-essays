# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  category   :integer
#  key        :uuid
#  message    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer
#  user_id    :integer          default(0)
#

require "test_helper"

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
