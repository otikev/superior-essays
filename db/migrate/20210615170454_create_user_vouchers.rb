class CreateUserVouchers < ActiveRecord::Migration[6.1]
  def change
    create_table :user_vouchers do |t|
      t.uuid :key, default: -> { "uuid_generate_v4()" }
      t.integer :user_id
      t.integer :voucher_id
      t.integer :order_id
      t.string :voucher_hash
      t.timestamps
    end
  end
end
