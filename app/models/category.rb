class Category < ActiveRecord::Base
  has_and_belongs_to_many :quotes

  validates :content, presence: true
  validates :content, uniqueness: { case_sensitive: false }
end
