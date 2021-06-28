class CreateContents < ActiveRecord::Migration[6.1]
  def change
    create_table :contents do |t|
      t.integer :user_id
      t.text :question
      t.text :answer
      t.boolean :published, default: -> { false }
      t.uuid :key, default: -> { "uuid_generate_v4()" }
      t.timestamps
    end
  end
end
