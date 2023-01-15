class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :type

  # Conversations feature is tied to a listing and is destroyed when a listing is destroyed
  has_many :conversations, dependent: :destroy
  # Messages are not destroyed when a listing is destroyed
  has_many :messages, through: :conversations
  has_many :user_conversations, through: :conversations

  validates :user, presence: true
  validates :title, :description, presence: true
  validates :title, uniqueness: { case_sensitive: false }
  validates :title, length: { minimum: 10, maximum: 40 }
  validates :description, length: { minimum: 50, maximum: 300 }

  scope :user_listings, ->(user) { where(user_id: user.id) }
  scope :by_type, ->(type) { where(type_id: type) }
  scope :seeking, -> { where(type_id: 2) }
  scope :offering, -> { where(type_id: 1) }

  # Ex:- scope :active, -> {where(:active => true)}
end
