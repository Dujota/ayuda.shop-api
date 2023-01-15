class API::V1::MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)
    @message.user = current_user

    if @message.save
      render json: { message: @message }
    else
      render json: { errors: @message.errors.full_messages }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :conversation_id)
  end
end
