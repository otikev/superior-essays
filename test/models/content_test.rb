# == Schema Information
#
# Table name: contents
#
#  id         :bigint           not null, primary key
#  answer     :text
#  key        :uuid
#  published  :boolean          default(FALSE)
#  question   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
require "test_helper"

class ContentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
