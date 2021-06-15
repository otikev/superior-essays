class CreateVouchers < ActiveRecord::Migration[6.1]
  def change
    create_table :vouchers do |t|
      t.integer :value
      t.timestamps
    end

    Voucher.new(value: 5).save!
    Voucher.new(value: 10).save!
    Voucher.new(value: 20).save!
    Voucher.new(value: 30).save!
    Voucher.new(value: 40).save!
    Voucher.new(value: 50).save!
    Voucher.new(value: 60).save!
    Voucher.new(value: 70).save!
    Voucher.new(value: 80).save!
    Voucher.new(value: 90).save!
    Voucher.new(value: 100).save!
  end
end