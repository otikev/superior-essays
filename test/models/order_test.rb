# == Schema Information
#
# Table name: orders
#
#  id                :bigint           not null, primary key
#  charts_count      :integer          default(0)
#  code              :string
#  completed_on      :datetime
#  discount          :float            default(0.0)
#  due_date          :datetime
#  instructions      :text
#  key               :uuid
#  pages             :integer
#  paid              :boolean          default(FALSE)
#  paid_on           :datetime
#  price             :float
#  slides_count      :integer          default(0)
#  sources_count     :integer          default(0)
#  spacing           :integer          default(1)
#  token             :string
#  topic             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  academic_level_id :integer          default(1)
#  english_type_id   :integer          default(1)
#  order_quality_id  :integer
#  order_status_id   :integer
#  order_type_id     :integer
#  order_urgency_id  :integer
#  paper_format_id   :integer          default(1)
#  subject_id        :integer
#  user_id           :bigint           not null
#

require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
