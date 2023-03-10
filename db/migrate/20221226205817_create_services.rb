class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :access_token
      t.string :refresh_token
      t.string :image
      t.boolean :email_verified
      t.datetime :expires_at

      t.timestamps
    end
  end
end
