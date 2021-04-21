class CreateEnglishTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :english_types do |t|
      t.string :name

      t.timestamps
    end

    EnglishType.new(name: 'English US').save!
    EnglishType.new(name: 'English UK').save!

    add_column :orders, :english_type_id, :integer, { default: 1 }
  end
end
