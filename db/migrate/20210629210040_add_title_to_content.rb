class AddTitleToContent < ActiveRecord::Migration[6.1]
  def change
    add_column :contents, :title, :string
    add_index :contents, :title, unique: true
  end
end
