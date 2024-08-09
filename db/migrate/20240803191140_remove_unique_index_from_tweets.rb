class RemoveUniqueIndexFromTweets < ActiveRecord::Migration[6.1]
  def change
    remove_index :tweets, name: "index_tweets_on_user_id"

    add_index :tweets, :user_id
  end
end
