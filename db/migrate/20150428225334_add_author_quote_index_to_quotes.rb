class AddAuthorQuoteIndexToQuotes < ActiveRecord::Migration
  def change
    add_index :quotes, ["content", "author_id"], :unique => true
  end
end
