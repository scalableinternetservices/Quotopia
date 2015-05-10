class AddContentHashToQuote < ActiveRecord::Migration
  def change
    change_table :quotes do |t|
      t.string :content_hash
      t.index :content_hash
    end
  end
end
