# == Schema Information
#
# Table name: resources
#
#  id                    :integer          not null, primary key
#  order_id              :integer
#  key                   :uuid
#  name                  :string
#  internal_resource_url :string
#  description           :string
#  file                  :string
#  resource_type_id      :integer          default("1")
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require "test_helper"

class ResourceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
