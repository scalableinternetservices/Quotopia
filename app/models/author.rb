class Author < ActiveRecord::Base
  has_many :quotes

  validates :name, presence: true
  validates :name, uniqueness: true
end
