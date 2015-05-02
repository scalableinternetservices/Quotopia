class AddAuthorContentIndexToQuotes < ActiveRecord::Migration
  def change
    add_index :quotes, ["author_id", "content_hash"], :unique => true
  end
end
