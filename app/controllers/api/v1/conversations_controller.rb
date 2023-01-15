class API::V1::ConversationsController < ApplicationController
  before_action :authenticate_user, only: [:create]

  def create
    # 1. Create a new conversation in the db.
    conversation = Conversation.new(listing_id: params[:listing_id])
    # 2. Create a new user_conversation in the db.
    # 3. Create a new message in the db.
    # 4. Send a message to the listing owner.
    # 5. Send a message to the current user.
  end

  private

  def conversation_params
    params.require(:conversation).permit(:listing_id)
  end
end
