# == Schema Information
#
# Table name: user_vouchers
#
#  id           :bigint           not null, primary key
#  key          :uuid
#  voucher_hash :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  order_id     :integer
#  user_id      :integer
#  voucher_id   :integer
#
class UserVoucher < ApplicationRecord
end
