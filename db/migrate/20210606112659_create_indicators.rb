class CreateIndicators < ActiveRecord::Migration[6.1]
  def change
    create_table :indicators do |t|
      t.integer :signal_id, null: false
      t.integer :user_id
      t.integer :order_id
      t.timestamps
    end
  end
end
