# == Schema Information
#
# Table name: order_urgencies
#
#  id         :bigint           not null, primary key
#  unit       :string
#  urgency    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class OrderUrgencyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
