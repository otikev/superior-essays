class CreateOrderUrgencies < ActiveRecord::Migration[6.1]
  def change
    create_table :order_urgencies do |t|
      t.integer :urgency
      t.string :unit

      t.timestamps
    end

    OrderUrgency.new(urgency: 10, unit: 'days').save!
    OrderUrgency.new(urgency: 7, unit: 'days').save!
    OrderUrgency.new(urgency: 5, unit: 'days').save!
    OrderUrgency.new(urgency: 4, unit: 'days').save!
    OrderUrgency.new(urgency: 3, unit: 'days').save!
    OrderUrgency.new(urgency: 48, unit: 'hours').save!
    OrderUrgency.new(urgency: 24, unit: 'hours').save!
    OrderUrgency.new(urgency: 12, unit: 'hours').save!
    OrderUrgency.new(urgency: 6, unit: 'hours').save!
    OrderUrgency.new(urgency: 3, unit: 'hours').save!
  end
end
