class Type < ApplicationRecord
  validates :tag, presence: true
  validates :tag, inclusion: %w[offer seek]
end
