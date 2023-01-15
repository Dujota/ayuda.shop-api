class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.references :listing,
                   null: false,
                   foreign_key: true,
                   index: true,
                   unique: true
      t.timestamps
    end
  end
end
