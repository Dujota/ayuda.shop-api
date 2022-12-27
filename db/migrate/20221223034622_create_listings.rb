class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :type, null: false, foreign_key: true

      t.string :title, limit: 40, null: false
      t.text :description, limit: 300, null: false

      t.timestamps
    end
    add_index :listings, :title, unique: true
  end
end
