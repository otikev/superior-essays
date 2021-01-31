namespace :orders do
  desc 'Create order types and order statuses'
  task setup: :environment do

    OrderStatus.new(name: 'Todo').save!
    OrderStatus.new(name: 'In Progress').save!
    OrderStatus.new(name: 'Complete').save!


    OrderType.new(name: 'Coursework').save!
    OrderType.new(name: 'Dissertation').save!
    OrderType.new(name: 'Essay').save!
    OrderType.new(name: 'Online Assignment').save!
    OrderType.new(name: 'Research Paper').save!
    OrderType.new(name: 'Term Paper').save!


    puts 'Created order types and order statuses'
  end

end
