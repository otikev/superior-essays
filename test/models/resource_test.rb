# == Schema Information
#
# Table name: resources
#
#  id                    :bigint           not null, primary key
#  description           :string
#  file                  :string
#  internal_resource_url :string
#  key                   :uuid
#  name                  :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  order_id              :integer
#  resource_type_id      :integer          default(1)
#  user_id               :integer
#

require "test_helper"

class ResourceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
