class Message < ApplicationRecord
  after_create_commit :send_message
  belongs_to :conversation
  belongs_to :user

  validates :content, presence: true

  private

  def send_message
    Resque.enqueue(SendMessage, self.id)
  end
end
