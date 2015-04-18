class Author < ActiveRecord::Base
	has_many :quotes
end
