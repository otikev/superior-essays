# == Schema Information
#
# Table name: contents
#
#  id           :bigint           not null, primary key
#  answer       :text
#  content_type :integer
#  key          :uuid
#  notified     :boolean          default(FALSE)
#  published    :boolean          default(FALSE)
#  question     :text
#  slug         :string
#  source       :string
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#
# Indexes
#
#  index_contents_on_slug  (slug) UNIQUE
#
require "test_helper"

class ContentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
