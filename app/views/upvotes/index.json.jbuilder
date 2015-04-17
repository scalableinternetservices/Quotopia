json.array!(@upvotes) do |upvote|
  json.extract! upvote, :id
  json.url upvote_url(upvote, format: :json)
end
