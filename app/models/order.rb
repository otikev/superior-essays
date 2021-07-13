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
  has_one :review
  has_one :user_voucher

  has_many :messages, -> { order(created_at: :desc) }
  has_many :resources, -> { order(created_at: :desc) }
  has_many :client_resources, -> { where(resource_type_id: ResourceType.client.id) }, class_name: 'Resource'
  has_many :business_resources, -> { where(resource_type_id: ResourceType.business.id) }, class_name: 'Resource'
  has_many :indicators, -> { order(created_at: :desc) }

  belongs_to :subject
  belongs_to :user
  belongs_to :order_type
  belongs_to :order_status
  belongs_to :order_quality
  belongs_to :order_urgency
  belongs_to :paper_format
  belongs_to :english_type
  belongs_to :academic_level

 

  after_create do
    db_order = Order.where(id: id).first
    Indicator.generate_order_signal(SEConstants::Signals::ORDER_CREATED,db_order)
    send_order_creation_emails(db_order)
    link_voucher_if_exists(db_order)
    apply_discount_if_exists(db_order)
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

    if self.order_status.id == 3 && self.completed_on == nil
        self.completed_on = DateTime.now
    end

    generate_appropriate_signal_if_applies
    set_end_date
  end

  def is_closed?
    self.order_status_id == 4
  end

  def is_overdue?
    if due_date
      DateTime.now.utc > due_date
    else
      false
    end
  end

  def is_reviewed?
    @review = Review.where(order_id: id).first
    @review
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

  def discounted_price
    (self.price - self.discount).round(2)
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

  def self.upcoming_orders(limit)
    # Upcoming orders should not contain closed orders
      Order.select("id, key, topic, due_date, order_quality_id, order_status_id, paid_on, (due_date - now()) as pending_time").where("due_date is not null and order_status_id != 4").limit(limit).order("pending_time asc")
  end

  private

  def apply_discount_if_exists(order)
    user_voucher = order.user_voucher
    if user_voucher
      voucher = user_voucher.voucher
      puts "Voucher exists, applying #{voucher.value}% discount on $#{order.price}"
      
      if voucher.value == 100 #fully paid by voucher
        order.paid = true
        order.paid_on = DateTime.now
      else
        order.discount = ((voucher.value/100.0)*price).round(2)
      end
      order.save!
    end
  end

  def link_voucher_if_exists(order)
    user_voucher = user.get_user_voucher
    if user_voucher
      user_voucher.order_id = order.id
      user_voucher.save!
      puts "Voucher exists, linking..."
    end
  end

  def send_order_completed_emails(order)
    #Email support
    SeMailer.with(order: order, recipient: SEConstants::SUPPORT_EMAIL).delay.order_completed

    #Email the order owner
    email_updates = order.user.user_settings.where(name: SEConstants::UserSettings::EMAIL_UPDATES)
    if email_updates.first.value == "true"
      SeMailer.with(order: order, recipient: order.user.email).delay.order_completed
    end

    #Email all admins
    User.includes(:user_settings).where(admin: true).all.each do |admin|
      email_updates = admin.user_settings.where(name: SEConstants::UserSettings::EMAIL_UPDATES)
      if email_updates.first.value == "true"
          SeMailer.with(order: order, recipient: admin.email).delay.order_completed
      end
    end
  end

  def send_order_creation_emails(db_order)
    SeMailer.with(order: db_order, recipient: SEConstants::SUPPORT_EMAIL).delay.order_created
    User.includes(:user_settings).where(admin: true).all.each do |admin|
      email_updates = admin.user_settings.where(name: SEConstants::UserSettings::EMAIL_UPDATES)
      if email_updates.first.value == "true"
          SeMailer.with(order: db_order, recipient: admin.email).delay.order_created
      end
    end
  end

  def generate_appropriate_signal_if_applies
    db_order = Order.where(id: id).first

    if self.order_status_id == 4 # Closed
      if db_order.order_status_id != 4
        Indicator.generate_order_signal(SEConstants::Signals::ORDER_CLOSED,self)
      end
    elsif self.order_status_id == 2 # In progress
      if db_order.order_status_id == 3 #complete
        Indicator.generate_order_signal(SEConstants::Signals::ORDER_RETURNED,self)
      end
    elsif self.order_status_id == 3 # Complete
        if db_order.completed_on == nil
          Indicator.generate_order_signal(SEConstants::Signals::ORDER_COMPLETED,self)
          send_order_completed_emails(db_order)
        end
    end
  end

  def remaining_seconds
    if !due_date
      return self.order_urgency.minutes*60
    end

    end_datetime = due_date
    puts "End datetime = #{end_datetime}"
    puts "Now datetime = #{DateTime.now.utc}"
    diff = (end_datetime.utc - DateTime.now.utc).to_i
    puts "Difference(seconds) = #{diff}"
    diff
  end

  def set_end_date
    if self.due_date != nil
      puts "End datetime already set"
      return
    end

    urgency_minutes = self.order_urgency.minutes
    puts "urgency (minutes) = #{urgency_minutes}"

    if self.paid_on
      start_datetime = self.paid_on.utc
      puts "Start datetime = #{start_datetime}"
      end_datetime = start_datetime + urgency_minutes.minutes
      puts "End datetime = #{end_datetime}"
      self.update_attribute(:due_date, end_datetime)
    end
  end
end
