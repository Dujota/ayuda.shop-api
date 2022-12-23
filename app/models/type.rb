class Type < ApplicationRecord
  validates :type, presence: true
  validates :type, inclusion: %w[offer seek]
end
