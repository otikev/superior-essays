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
#  completed_on      :datetime
#  subject_id        :integer
#

class Order < ApplicationRecord
  require 'utils'

  has_one :subject
  has_one :order_status
  has_one :order_type
  has_one :order_quality
  has_one :order_urgency
  has_one :paper_format
  has_one :english_type
  has_one :academic_level

  belongs_to :subject
  belongs_to :user
  belongs_to :order_type
  belongs_to :order_status
  belongs_to :order_quality
  belongs_to :order_urgency
  belongs_to :paper_format
  belongs_to :english_type
  belongs_to :academic_level

  has_many :messages, -> { order(created_at: :desc) }
  has_many :resources, -> { order(created_at: :desc) }
  has_many :client_resources, -> { where(resource_type_id: ResourceType.client.id) }, class_name: 'Resource'
  has_many :business_resources, -> { where(resource_type_id: ResourceType.business.id) }, class_name: 'Resource'
  has_many :indicators, -> { order(created_at: :desc) }

  after_create do
    Indicator.generate_order_signal(SEConstants::Signals::ORDER_CREATED,self)
  end

  before_save do
    if self.code == nil
      self.code = Utils.random_upcase_string(5)
    end

    base_price = 0
    if order_quality_id == 1
      base_price = SEConstants::OrderBasePrice::STANDARD
    elsif order_quality_id == 2
      base_price = SEConstants::OrderBasePrice::PREMIUM
    elsif order_quality_id == 3
      base_price = SEConstants::OrderBasePrice::PLATINUM
    end

    if academic_level_id == 2
      base_price = base_price + SEConstants::AcademicLevelDelta::MASTERS
    elsif academic_level_id == 3
      base_price = base_price + SEConstants::AcademicLevelDelta::COLLEGE
    elsif academic_level_id == 4
      base_price = base_price + SEConstants::AcademicLevelDelta::UNIVERSITY
    elsif academic_level_id == 5
      base_price = base_price + SEConstants::AcademicLevelDelta::PHD
    end

    self.price = (base_price+self.order_urgency_id-1)*self.pages

    if self.spacing == 1
      self.price = self.price*2
    end

    if self.order_status.id != 3 #complete
      self.completed_on = nil
    elsif self.completed_on == nil
      puts "Completing order!"
      self.completed_on = DateTime.now
      Indicator.generate_order_signal(SEConstants::Signals::ORDER_COMPLETED,self)
    end
  end

  def is_overdue?
    DateTime.now.utc > end_date
  end

  def end_date
    urgency_minutes = self.order_urgency.minutes
    puts "urgency = #{urgency_minutes}"

    start_datetime = DateTime.now

    if self.paid_on
      start_datetime = self.paid_on.utc
    end
    puts "Start datetime = #{start_datetime}"
    end_datetime = start_datetime + urgency_minutes.minutes
    puts "End datetime = #{end_datetime}"
    end_datetime
  end

  def remaining_minutes
    diff = (remaining_seconds/60).to_i
    puts "Difference(minutes) = #{diff}"
    diff
  end

  def remaining_hours
    diff = (remaining_minutes/60).to_i
    puts "Difference(hours) = #{diff}"
    diff
  end

  def spacing_text
    display = ''
    if spacing == 1
      display = 'Single Spaced'
    elsif spacing == 2
      display = 'Double Spaced'
    end
    display
  end

  def remaining_time_text
    mins = remaining_minutes
    puts "mins(all) = #{(mins).abs}"
    days = (mins).abs/1440
    remaining_mins = (mins).abs%1440
    hours = remaining_mins/60
    mins = remaining_mins%60

    puts "days = #{days}, hours = #{hours}, mins = #{mins}"

    due = ""
    if days > 1
      due = "#{days} Days "
    elsif days > 0
      due = "#{days} Day "
    end

    if hours > 1
      due = due+"#{hours} Hours "
    elsif hours > 0
      due = due+"#{hours} Hour "
    end

    if mins > 0
      due = due+"#{mins} Minutes"
    end
    due
  end

  private

  def remaining_seconds
    end_datetime = end_date
    puts "End datetime = #{end_datetime}"
    puts "Now datetime = #{DateTime.now.utc}"
    diff = (end_datetime.utc - DateTime.now.utc).to_i
    puts "Difference(seconds) = #{diff}"
    diff
  end

end
