# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  message    :string
#  stars      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer
#  user_id    :integer
#
require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
