require 'utils'

class AddCodeToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :code, :string
    Order.all.each do |o|
      code = Utils.random_upcase_string(5)
      o.update_attribute(:code, code)
    end
  end
end