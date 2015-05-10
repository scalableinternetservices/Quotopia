class AddExtraColumnToQuote < ActiveRecord::Migration
  def change
	change_table :quotes do |t|
		t.text :extra
	end
  end
end
