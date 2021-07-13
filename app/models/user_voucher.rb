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
    has_one :user
    has_one :voucher
    has_one :order

    belongs_to :user
    belongs_to :voucher
    belongs_to :order, optional: true

    validate :no_unused_user_vouchers_for_user, :on => :create

    after_create do
        db_record = UserVoucher.where(id: id).first
        send_order_creation_emails(db_record)
    end

    def used?
        order_id != nil
    end

    private

    def no_unused_user_vouchers_for_user
        unused_vouchers = user.user_vouchers.where(order_id: nil).count
        if unused_vouchers > 0
            errors.add(:discount, "User has unused vouchers")
        end
    end

    def send_order_creation_emails(db_record)
        SeMailer.with(user_voucher: db_record, recipient: user.email).delay.user_voucher
    end
end
