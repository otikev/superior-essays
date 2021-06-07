class MessagesController < ApplicationController
  before_action :must_have_user

  def create
    message = Message.new(message_params)
    message.user_id = @current_user.id
    message.save!
    flash[:success] = "Message posted"
    redirect_to orders_show_path(key: message.order.key)
  end

  def unread
    @unread_messages = Message.unread_for_user(@current_user)
  end
  
  private

  def message_params
    params.require(:message).permit(:order_id, :message, :category)
  end

end
