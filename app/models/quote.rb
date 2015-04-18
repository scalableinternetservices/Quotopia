class Quote < ActiveRecord::Base
	has_and_belongs_to_many :categories
	has_many :comments
	belongs_to :author
end
