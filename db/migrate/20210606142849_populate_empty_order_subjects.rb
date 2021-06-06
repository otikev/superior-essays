class PopulateEmptyOrderSubjects < ActiveRecord::Migration[6.1]
  def change
    Order.where(subject_id: nil).each do |o|
      puts "Updating subject for order #{o.key}"
      o.update_attribute(:subject_id, 1)
    end
  end
end
