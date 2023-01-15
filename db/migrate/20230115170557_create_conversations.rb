class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      # references listings
      t.references :listing, null: false, foreign_key: true, index: true
      t.timestamps
    end
    add_index :conversations, %i[listing_id users], unique: true
  end
end
