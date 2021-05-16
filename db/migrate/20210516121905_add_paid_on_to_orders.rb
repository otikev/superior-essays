class AddPaidOnToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :paid_on, :datetime

    Order.all.each do |o|
      o.update_attribute(:paid_on, o.created_at)
    end

  end
end
