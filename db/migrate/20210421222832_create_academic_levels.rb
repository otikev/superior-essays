class CreateAcademicLevels < ActiveRecord::Migration[6.1]
  def change
    create_table :academic_levels do |t|
      t.string :name

      t.timestamps
    end

    AcademicLevel.new(name: 'High School').save!
    AcademicLevel.new(name: 'Masters').save!
    AcademicLevel.new(name: 'College').save!
    AcademicLevel.new(name: 'University').save!
    AcademicLevel.new(name: 'PhD').save!

    add_column :orders, :academic_level_id, :integer, { default: 1 }
  end
end
