class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :order_id
      t.integer :stars
      t.string :message
      t.timestamps
    end
    OrderStatus.new(name: 'Closed').save! # Add new status
  end
end
