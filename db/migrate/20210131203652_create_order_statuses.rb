class CreateOrderStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :order_statuses do |t|
      t.string :name

      t.timestamps
    end

    OrderStatus.new(name: 'Todo').save!
    OrderStatus.new(name: 'In Progress').save!
    OrderStatus.new(name: 'Complete').save!
  end
end
