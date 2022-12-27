class AddNameLocaleFamilyNameGivenNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, default: nil
    add_column :users, :family_name, :string, default: nil
    add_column :users, :given_name, :string, default: nil
    add_column :users, :locale, :string, default: nil
  end
end
