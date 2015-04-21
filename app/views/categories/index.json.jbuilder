json.array!(@categories) do |category|
  json.extract! category, :id, :content, :quote_id
  json.url category_url(category, format: :json)
end
