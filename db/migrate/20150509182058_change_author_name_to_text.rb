class ChangeAuthorNameToText < ActiveRecord::Migration
  def change
    change_column :authors, :name, :text
  end
end
