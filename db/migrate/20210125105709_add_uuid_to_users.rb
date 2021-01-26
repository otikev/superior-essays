class AddUuidToUsers < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'uuid-ossp'
    add_column :users, :key, :uuid, { default: 'uuid_generate_v4()' }
  end
end
