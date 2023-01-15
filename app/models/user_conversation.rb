class UserConversation < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :user, presence: true
  validates :conversation, presence: true
  validates_uniqueness_of :user_id, scope: :conversation_id
end
