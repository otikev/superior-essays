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

    def self.all_order_data(days)
        created = retrieve_order_created_data(days)
        paid = retrieve_order_paid_data(days)
        completed = retrieve_order_completed_data(days)
        closed = retrieve_order_closed_data(days)

        data = []
        pivot_date = Date.today - days
        num_of_days = Date.today - pivot_date

        (num_of_days.to_i+1).times do
            hash = Hash.new
            hash["date"] = pivot_date.strftime('%Y-%m-%d')

            val = created.detect {|k,v| k == pivot_date }
            hash["created"] = val ? val[1] : 0

            val = paid.detect {|k,v| k == pivot_date }
            hash["paid"] = val ? val[1] : 0

            val = completed.detect {|k,v| k == pivot_date }
            hash["completed"] = val ? val[1] : 0

            val = closed.detect {|k,v| k == pivot_date }
            hash["closed"] = val ? val[1] : 0

            data.push(hash)
            pivot_date = pivot_date + 1.day
        end

        data
    end

    private

    def self.retrieve_order_created_data(days)
        records = Indicator.where("created_at >= ?", days.ago)
        .where(signal_id: SEConstants::Signals::ORDER_CREATED)
        .order("DATE(created_at)")
        .group("DATE(created_at)")
        .count
    end

    def self.retrieve_order_paid_data(days)
        records = Indicator.where("created_at >= ?", days.ago)
        .where(signal_id: SEConstants::Signals::ORDER_PAID)
        .order("DATE(created_at)")
        .group("DATE(created_at)")
        .count
    end

    def self.retrieve_order_completed_data(days)
        records = Indicator.where("created_at >= ?", days.ago)
        .where(signal_id: SEConstants::Signals::ORDER_COMPLETED)
        .order("DATE(created_at)")
        .group("DATE(created_at)")
        .count
    end

    def self.retrieve_order_closed_data(days)
        records = Indicator.where("created_at >= ?", days.ago)
        .where(signal_id: SEConstants::Signals::ORDER_CLOSED)
        .order("DATE(created_at)")
        .group("DATE(created_at)")
        .count
    end
end
