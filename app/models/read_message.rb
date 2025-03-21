# == Schema Information
#
# Table name: read_messages
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :integer
#  user_id    :integer
#
# Indexes
#
#  index_read_messages_on_message_id  (message_id)
#  index_read_messages_on_user_id     (user_id)
#
class ReadMessage < ApplicationRecord
end
