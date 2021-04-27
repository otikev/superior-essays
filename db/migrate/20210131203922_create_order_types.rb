class CreateOrderTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :order_types do |t|
      t.string :name

      t.timestamps
    end

    OrderType.new(name: 'Coursework').save!
    OrderType.new(name: 'Dissertation').save!
    OrderType.new(name: 'Essay').save!
    OrderType.new(name: 'Online Assignment').save!
    OrderType.new(name: 'Research Paper').save!
    OrderType.new(name: 'Term Paper').save!
    OrderType.new(name: 'Book Report').save!
    OrderType.new(name: 'Book Review').save!
    OrderType.new(name: 'Movie Review').save!
    OrderType.new(name: 'Research Summary').save!
    OrderType.new(name: 'Research Proposal').save!
    OrderType.new(name: 'Thesis').save!
    OrderType.new(name: 'Formatting').save!
    OrderType.new(name: 'Proofreading').save!
    OrderType.new(name: 'Case Study').save!
    OrderType.new(name: 'Article').save!
  end
end
