class AddAdminFlagToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin, :boolean, { default: false }
    add_column :orders, :order_status_id, :integer
    add_column :orders, :order_type_id, :integer
    remove_column :orders, :order_type
  end
end
