class Conversation < ApplicationRecord
  belongs_to :listing
  belongs_to :sender, foreign_key: :sender_id, class_name: "User"
  belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"

  has_many :user_conversations, dependent: :destroy
  has_many :users, through: :user_conversations
  has_many :messages, dependent: :destroy

  # make sure that a conversation is created with a listing
  validates :listing, presence: true
  # make sure that a conversation between the same users and the same listing is not created twice.
  # validates :users, uniqueness: { scope: :listing }
  # validates :listing_id, uniqueness: { scope: :users }
  validates_uniqueness_of :sender_id, scope: :recipient_id
  scope :between,
        ->(sender_id, recipient_id) {
          where(sender_id: sender_id, recipient_id: recipient_id).or(
            where(sender_id: recipient_id, recipient_id: sender_id)
          )
        }
end
