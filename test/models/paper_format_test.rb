# == Schema Information
#
# Table name: paper_formats
#
#  id         :integer          not null, primary key
#  name       :string
#  key        :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class PaperFormatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
