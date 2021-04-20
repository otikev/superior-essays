# == Schema Information
#
# Table name: order_urgencies
#
#  id         :integer          not null, primary key
#  urgency    :integer
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class OrderUrgencyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
