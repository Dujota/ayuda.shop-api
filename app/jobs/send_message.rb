# send message reqsque task that brodcast to action cable
class SendMessage
  @queue = :conversations

  def self.perform(message_id)
    message = Message.find(message_id)

    ActionCable.server.broadcast(
      # Broadcast to general open channel
      # "conversations_channel",
      # Broadcast to user/sender private channel
      "conversation_#{message.conversation_id}",
      { message: message }
    )
  end
end
