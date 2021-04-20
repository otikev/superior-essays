class CreateOrderQualities < ActiveRecord::Migration[6.1]
  def change
    create_table :order_qualities do |t|
      t.string :quality

      t.timestamps
    end

    OrderQuality.new(quality: 'Standard').save!
    OrderQuality.new(quality: 'Premium').save!
    OrderQuality.new(quality: 'Platinum').save!
  end
end
