class AddTwoColumnIndexToVotes < ActiveRecord::Migration
  def change
      add_index :votes, ["quote_id", "user_id"], :unique => true
  end
end
