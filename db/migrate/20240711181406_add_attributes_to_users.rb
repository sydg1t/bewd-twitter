class AddAttributesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string, unique: true
    add_index :users, :username
    add_column :users, :email, :string, unique: true
    add_index :users, :email
    add_column :users, :password, :string
  end
end
