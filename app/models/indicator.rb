# == Schema Information
#
# Table name: indicators
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer
#  signal_id  :integer          not null
#  user_id    :integer
#
class Indicator < ApplicationRecord

    def self.generate_user_signal(signal_id,user)
        Indicator.new(signal_id: signal_id, user_id: user.id).save!
    end

    def self.generate_order_signal(signal_id,order)
        Indicator.new(signal_id: signal_id, order_id: order.id).save!
    end

    def self.generate_system_signal(signal_id)
        Indicator.new(signal_id: signal_id).save!
    end
end
