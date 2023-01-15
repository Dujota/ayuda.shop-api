class CreateUserConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :user_conversations do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :conversation, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
