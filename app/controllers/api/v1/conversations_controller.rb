class API::V1::ConversationsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]
  before_action :reject_message_to_self

  def create
    if Conversation.between(current_user.id, params[:recipient_id]).present?
      conversation =
        Conversation.between(current_user.id, params[:recipient_id]).first

      render json: { conversation: conversation }
    else
      message_recepient = User.find(params[:recipient_id])
      #Create a new conversation in the db, which also satisifes the validation of a conversation
      conversation =
        Conversation.new(
          listing_id: params[:listing_id],
          recipient_id: params[:recipient_id],
          sender_id: current_user.id
        )

      # add users to conversation
      conversation.users << current_user
      conversation.users << message_recepient

      # save conversation
      if conversation.save
        receiver_user_conversation =
          UserConversation.new(
            user_id: params[:recipient_id],
            conversation_id: conversation.id
          )

        receiver_user_conversation.save
        sender_user_conversation =
          UserConversation.new(
            user_id: current_user.id,
            conversation_id: conversation.id
          )
        sender_user_conversation.save
        # add user_conversations to conversation
        conversation.user_conversations << receiver_user_conversation
        conversation.user_conversations << sender_user_conversation

        render json: { conversation: conversation }
      else
        render json: { errors: conversation.errors.full_messages }
      end
    end
  end

  private

  def reject_message_to_self
    if params[:recipient_id] == current_user.id
      render json: {
               message: "You cannot message yourself",
               status: 422
             },
             status: :unprocessable_entity
    end
  end

  def conversation_params
    params.require(:conversation).permit(:listing_id, :recipient_id)
  end
end
