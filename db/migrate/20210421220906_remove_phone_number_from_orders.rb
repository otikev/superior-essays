class RemovePhoneNumberFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :contact_phone, :string
    add_column :orders, :sources_count, :integer, { default: 0 }
    add_column :orders, :charts_count, :integer, { default: 0 }
    add_column :orders, :slides_count, :integer, { default: 0 }
    add_column :orders, :spacing, :integer, { default: 1 }
  end
end