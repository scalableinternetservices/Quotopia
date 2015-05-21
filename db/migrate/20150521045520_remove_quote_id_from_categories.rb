class RemoveQuoteIdFromCategories < ActiveRecord::Migration
  def change
    remove_foreign_key :categories, column: :quote_id
    remove_index :categories, :quote_id
    remove_column :categories, :quote_id, :integer
  end
end
