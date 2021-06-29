class AddSlugToContents < ActiveRecord::Migration[6.1]
  def change
    add_column :contents, :slug, :string
    add_index :contents, :slug, unique: true
    remove_index :contents, :title, unique: true
  end
end
