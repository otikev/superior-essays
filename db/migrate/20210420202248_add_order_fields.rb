class AddOrderFields < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :pages, :integer
    add_column :orders, :order_quality_id, :integer
    add_column :orders, :order_urgency_id, :integer

    Order.all.each do |o|
      code = Utils.random_upcase_string(5)
      o.update_attribute(:pages, 1)#default to 1
      o.update_attribute(:order_quality_id, 1)#default to 1
      o.update_attribute(:order_urgency_id, 1)#default to 1
    end
  end
end
