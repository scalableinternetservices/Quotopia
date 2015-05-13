class Category < ActiveRecord::Base
  # has_and_belongs_to_many :quotes
  has_many :categorizations
  has_many :quotes, :through => :categorizations

  validates :content, presence: true
  validates :content, uniqueness: { case_sensitive: false }

end