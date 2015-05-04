class AddAuthorQuoteIndexToQuotes < ActiveRecord::Migration
  def change
    #add_index :quotes, ["author_id", "content"], :length => 512, :unique => true
  end
end
