class CreateCategoriesQuotes < ActiveRecord::Migration
  def change
    create_table :categories_quotes do |t|
    	t.integer :category_id
    	t.integer :quote_id
    end
  end
end
