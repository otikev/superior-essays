# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  user_id    :integer          default("0")
#  message    :string
#  category   :integer
#  key        :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
    #TODO: Cache this result to avoid unnecessarilly hitting the DB
    unread_messages = Message.find_by_sql("SELECT * FROM messages where user_id != #{user.id} and id not in (select message_id from read_messages where user_id = #{user.id}) order by id asc")
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
