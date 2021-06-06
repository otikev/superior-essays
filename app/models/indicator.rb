class Indicator < ApplicationRecord

    def self.generate_user_signal(signal_id,user)
        Indicator.new(signal_id: signal_id, user_id: user.id).save!
    end

    def self.generate_order_signal(signal_id,order)
        Indicator.new(signal_id: signal_id, order_id: order.id).save!
    end
end
