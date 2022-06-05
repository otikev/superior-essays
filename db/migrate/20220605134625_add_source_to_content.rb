class AddSourceToContent < ActiveRecord::Migration[6.1]
  def change
    add_column :contents, :source, :string
  end
end