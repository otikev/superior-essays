# == Schema Information
#
# Table name: user_settings
#
#  id         :bigint           not null, primary key
#  name       :string
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
require "test_helper"

class UserSettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
