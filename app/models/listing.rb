class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :type

  validates :title, :description, presence: true
  validates :title, uniqueness: { case_sensitive: false }
  validates :title, length: { minimum: 10, maximum: 40 }
  validates :description, length: { minimum: 50, maximum: 300 }
end
