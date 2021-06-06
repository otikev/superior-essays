class AddDueDateToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :due_date, :datetime
  end
end
