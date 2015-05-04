class CreateFavoriteQuotes < ActiveRecord::Migration
  def change
    create_table :favorite_quotes do |t|
      t.references :quote, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
