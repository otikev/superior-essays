class ChangePriceToFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :price, :float
  end
end
