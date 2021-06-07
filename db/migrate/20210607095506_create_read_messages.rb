class CreateReadMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :read_messages do |t|
      t.integer :user_id
      t.integer :message_id

      t.timestamps
    end
    add_index :read_messages, :user_id
    add_index :read_messages, :message_id
  end
end
