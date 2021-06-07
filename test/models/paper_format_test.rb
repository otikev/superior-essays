# == Schema Information
#
# Table name: paper_formats
#
#  id         :bigint           not null, primary key
#  key        :uuid
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class PaperFormatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
