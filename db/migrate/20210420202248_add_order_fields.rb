class AddOrderFields < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :pages, :integer
    add_column :orders, :order_quality_id, :integer
    add_column :orders, :order_urgency_id, :integer

    Order.all.each do |o|
      code = Utils.random_upcase_string(5)
      o.update_attribute(:pages, 1)#default to 1
      o.update_attribute(:order_quality_id, 1)#default to 1
      o.update_attribute(:order_urgency_id, 1)#default to 1
    end

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
