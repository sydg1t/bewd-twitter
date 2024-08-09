class AddAttributesToSessions < ActiveRecord::Migration[6.1]
  def change
    add_column :sessions, :token, :string
    add_column :sessions, :user_id, :integer, foreign_key: true
    add_index  :sessions, :username, unique: true
    
  end
end
