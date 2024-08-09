
json.tweets do
  json.array! @tweets.order(created_at: :desc) do |tweet|
    json.id tweet.id
    json.username tweet.user.username
    json.message tweet.message
  end
end
