class UserConversation < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :user, presence: true
  validates :conversation, presence: true
end
