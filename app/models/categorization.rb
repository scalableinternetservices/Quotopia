class Categorization < ActiveRecord::Base
  belongs_to :quote
  belongs_to :category
end
