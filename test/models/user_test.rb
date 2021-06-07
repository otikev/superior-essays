# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  admin      :boolean          default(FALSE)
#  email      :string
#  enabled    :boolean          default(TRUE)
#  first_name :string
#  key        :uuid
#  last_name  :string
#  user_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
