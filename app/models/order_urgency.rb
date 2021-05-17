# == Schema Information
#
# Table name: order_urgencies
#
#  id         :integer          not null, primary key
#  urgency    :integer
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrderUrgency < ApplicationRecord
    has_many :orders

    def display
        "#{urgency} #{unit}"
    end

    def hours
      case self.unit
        when "days"
          self.urgency*24
        when "hours"
          self.urgency
      end
    end

    def minutes
      hours*60
    end
end
