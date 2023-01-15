class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :type

  validates :title, :description, presence: true
  validates :title, uniqueness: { case_sensitive: false }
  validates :title, length: { minimum: 10, maximum: 40 }
  validates :description, length: { minimum: 50, maximum: 300 }
  validates :user, presence: true

  scope :user_listings, ->(user) { where(user_id: user.id) }
  scope :by_type, ->(type) { where(type_id: type) }
  scope :seeking, -> { where(type_id: 2) }
  scope :offering, -> { where(type_id: 1) }

  # Ex:- scope :active, -> {where(:active => true)}
end
