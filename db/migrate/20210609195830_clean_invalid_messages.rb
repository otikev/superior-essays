class CleanInvalidMessages < ActiveRecord::Migration[6.1]
  def change
    puts "Cleaning messages!!!"
    Message.all.each do |m|
      if m.user_id != m.order.user_id
        if !m.user.admin?
          puts "invalid message found. Deleting..."
          m.delete
        end
      end
    end

    puts "Finished cleaning messages"
  end
end
