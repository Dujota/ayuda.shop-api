class API::V1::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, onlu: %i[index create]

  def index
    @messages = @conversation.messages
    render json: { messages: @messages }
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.user = current_user

    if @message.save
      ActionCable.server.broadcast(
        # Broadcast to general open channel
        # "conversations_channel",
        # Broadcast to user/sender private channel
        "conversation_#{params[:conversation_id]}",
        @message
      )
      render json: { message: @message }
    else
      render json: { errors: @message.errors.full_messages }
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:content, :conversation_id)
  end
end
