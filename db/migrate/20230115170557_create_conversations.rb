class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.references :listing,
                   null: false,
                   foreign_key: true,
                   index: true,
                   unique: true
      t.references :recipient,
                   foreign_key: {
                     to_table: :users
                   },
                   index: true,
                   null: false
      t.references :sender,
                   foreign_key: {
                     to_table: :users
                   },
                   index: true,
                   null: false

      t.timestamps
    end
  end
end
