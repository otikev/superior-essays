class AddContentIdToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :content_id, :integer
  end
end
