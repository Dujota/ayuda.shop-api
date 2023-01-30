class ConversationsChannel < ApplicationCable::Channel
  def subscribed
    #createing a generic channel where all users connect
    # stream_from "conversations_channel"

    # creating a private channel for each user
    # stream_from "current_user_#{current_user.id}"
    stream_from "conversation_#{params[:conversation_id]}"
  end
  def unsubscribed
    stop_all_streams
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    debugger
  end
end
