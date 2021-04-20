# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string
#  first_name :string
#  last_name  :string
#  email      :string
#  enabled    :boolean          default("true")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  key        :uuid
#  admin      :boolean          default("false")
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
