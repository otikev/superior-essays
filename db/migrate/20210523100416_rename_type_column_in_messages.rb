class RenameTypeColumnInMessages < ActiveRecord::Migration[6.1]
  def change
    rename_column :messages, :type, :category
  end
end
