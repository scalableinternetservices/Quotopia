json.array!(@quotes) do |quote|
  json.extract! quote, :id, :content, :author_id, :user_id
  json.url quote_url(quote, format: :json)
end
