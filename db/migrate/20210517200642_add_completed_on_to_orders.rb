class AddCompletedOnToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :completed_on, :datetime

    Order.all.each do |o|
      if o.order_status.id == 3 #complete
          o.update_attribute(:completed_on, o.paid_on)
      end
    end
  end
end
