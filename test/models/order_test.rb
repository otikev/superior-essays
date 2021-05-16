# == Schema Information
#
# Table name: orders
#
#  id                :integer          not null, primary key
#  topic             :string
#  instructions      :text
#  key               :uuid
#  user_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  order_status_id   :integer
#  order_type_id     :integer
#  code              :string
#  paid              :boolean          default("false")
#  token             :string
#  price             :integer
#  pages             :integer
#  order_quality_id  :integer
#  order_urgency_id  :integer
#  sources_count     :integer          default("0")
#  charts_count      :integer          default("0")
#  slides_count      :integer          default("0")
#  spacing           :integer          default("1")
#  paper_format_id   :integer          default("1")
#  english_type_id   :integer          default("1")
#  academic_level_id :integer          default("1")
#  paid_on           :datetime
#

require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
