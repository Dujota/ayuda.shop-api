class Conversation < ApplicationRecord
  belongs_to :listing
  has_many :user_conversations, dependent: :destroy
  has_many :users, through: :user_conversations
  has_many :messages, dependent: :destroy

  validates :listing, presence: true
  # make sure that a conversation between the same users and the same listing is not created twice.
  valdidates_uniqueness_of :listing_id, scope: :users
end
