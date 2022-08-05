class AddNotifiedToContent < ActiveRecord::Migration[6.1]
  def change
    add_column :contents, :notified, :boolean, :default => false
  end
end
