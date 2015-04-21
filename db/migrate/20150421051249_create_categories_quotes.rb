class CreateCategoriesQuotes < ActiveRecord::Migration
  def change
    create_table :categories_quotes do |t|
        t.integer :category_id, index: true
        t.integer :quote_id, index: true
    end
  end
end
