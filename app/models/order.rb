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
#

class Order < ApplicationRecord
  require 'utils'

  has_one :order_status
  has_one :order_type
  has_one :order_quality
  has_one :order_urgency
  has_one :paper_format
  has_one :english_type
  has_one :academic_level

  belongs_to :user
  belongs_to :order_type
  belongs_to :order_status
  belongs_to :order_quality
  belongs_to :order_urgency
  belongs_to :paper_format
  belongs_to :english_type
  belongs_to :academic_level

  has_many :resources

  before_save do
    self.code = Utils.random_upcase_string(5)

    base_price = 0
    if order_quality_id == 1
      base_price = STANDARD_BASE_PRICE
    elsif order_quality_id == 2
      base_price = PREMIUM_BASE_PRICE
    elsif order_quality_id == 3
      base_price = PLATINUM_BASE_PRICE
    end

    self.price = (base_price+self.order_urgency_id-1)*self.pages

    if self.spacing == 1
      self.price = self.price*2
    end
  end
end
