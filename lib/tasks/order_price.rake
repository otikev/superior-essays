namespace :orders do
    desc 'Create order types and order statuses'
    task default_price: :environment do
  

        Order.all.each do |o|
            if !o.price
                o.update_attribute(:price, 10.0) # set a default of $10
                puts "Updated order #{o.code}"
            end
           
        end
      
    end
  
  end
  