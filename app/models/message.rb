class Message < ApplicationRecord
  after_create_commit :transmit_to_conversation
  belongs_to :conversation
  belongs_to :user

  validates :content, presence: true

  private

  def transmit_to_conversation
    ActionCable.server.broadcast(
      # Broadcast to general open channel
      # "conversations_channel",
      # Broadcast to user/sender private channel
      "conversation_#{self.conversation_id}",
      { message: self }
    )
  end
end
