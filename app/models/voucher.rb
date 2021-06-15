# == Schema Information
#
# Table name: vouchers
#
#  id         :bigint           not null, primary key
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Voucher < ApplicationRecord
end
