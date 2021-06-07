# == Schema Information
#
# Table name: indicators
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer
#  signal_id  :integer          not null
#  user_id    :integer
#
require "test_helper"

class IndicatorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
