# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  category   :integer
#  key        :uuid
#  message    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer
#  user_id    :integer          default(0)
#

class Message < ApplicationRecord
  #type = 1:user message,

  has_one :order
  has_one :user

  belongs_to :order
  belongs_to :user


  def feed_display
    if category == MESSAGE_TYPE_USER_MESSAGE
      if user.admin?
        "#{created_at} : Admin : #{message}"
      else
        "#{created_at} : Client : #{message}"
      end
      
    else
      "#{created_at} : #{message}"
    end
  end

  def self.unread_for_user(user)
    puts "==============================="
    #TODO: Cache this result to avoid unnecessarilly hitting the DB
    user_orders = ""
    if user.admin?
      query = "SELECT * FROM messages where user_id != #{user.id} and " # dont show messages that I posted
      query+="id not in (select message_id as id from read_messages where user_id = #{user.id}) " # show messages I've not read
      query+="order by id asc"
      
      unread_messages = Message.find_by_sql(query)
    else
      # TODO: Update this to apply to users assigned to the order (writers)
      query = "SELECT * FROM messages where order_id in (select id as order_id from orders where user_id = #{user.id}) " # Only messages in orders that i created
      query+="and user_id != #{user.id} " # dont show messages that I posted
      query+="and id not in (select message_id as id from read_messages where user_id = #{user.id}) " # show messages I've not read
      query+="order by id asc"

      unread_messages = Message.find_by_sql(query)
    end
    puts "***** #{query}"
    puts unread_messages.to_json
    puts "==============================="
    unread_messages
  end

  def mark_as_read_for_user(user)
    if !is_read_for_user?(user)
      ReadMessage.new(user_id: user.id, message_id: self.id).save
    end
  end

  def is_read_for_user?(user)
    ReadMessage.where(user_id: user.id, message_id: self.id).first != nil
  end

end
