class CreateResources < ActiveRecord::Migration[6.1]
  def change
    create_table :resources do |t|
      t.integer :order_id
      t.integer :resource_type_id, default: 1
      t.string :name
      t.string :internal_resource_url
      t.string :description
      t.string :file
      t.uuid :key, default: -> { "uuid_generate_v4()" }

      t.timestamps
    end
  end
end
