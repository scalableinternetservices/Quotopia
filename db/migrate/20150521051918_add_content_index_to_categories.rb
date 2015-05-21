class AddContentIndexToCategories < ActiveRecord::Migration
  def change
    add_index :categories, :content, {unique: true}
  end
end
