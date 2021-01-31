class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :order_type
      t.string :topic
      t.text :instructions
      t.uuid :key, default: -> { "uuid_generate_v4()" }
      t.string :contact_phone
      t.bigint :user_id, null: false

      t.timestamps
    end
  end
end
