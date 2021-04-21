class CreatePaperFormats < ActiveRecord::Migration[6.1]
  def change
    create_table :paper_formats do |t|
      t.string :name
      t.uuid :key, default: -> { "uuid_generate_v4()" }

      t.timestamps
    end

    PaperFormat.new(name: 'APA').save!
    PaperFormat.new(name: 'MLA').save!
    PaperFormat.new(name: 'Havard').save!
    PaperFormat.new(name: 'Chicago').save!
    PaperFormat.new(name: 'Turabian').save!
    PaperFormat.new(name: 'Oxford').save!
    PaperFormat.new(name: 'Vancouver').save!
    PaperFormat.new(name: 'CBE').save!
    PaperFormat.new(name: 'AGCL').save!
    PaperFormat.new(name: 'Other').save!

    add_column :orders, :paper_format_id, :integer, { default: 1 }
  end
end
