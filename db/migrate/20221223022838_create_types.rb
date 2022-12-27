class CreateTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :types do |t|
      t.string :tag, null: false
      t.timestamps
    end

    add_index :types, :tag, unique: true
  end
end
