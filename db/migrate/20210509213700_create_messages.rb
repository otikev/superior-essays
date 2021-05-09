class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :order_id
      t.integer :user_id, default: 0
      t.string :message
      t.integer :type
      t.uuid :key, default: -> { "uuid_generate_v4()" }

      t.timestamps
    end
  end
end
