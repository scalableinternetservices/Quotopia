class Quote < ActiveRecord::Base
  belongs_to :author
  belongs_to :user
  has_many :votes
  has_many :users, :through => :votes
  has_many :comments
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :author

  validates :content, presence: true
  validates :content, uniqueness: true
  validates :author, presence: true

	def self.search(search)
  		@quotes = Quote.where("content LIKE ?", "%#{search}%") 
  				  #.joins(:author)
  				  #.where("content LIKE ?",  "%#{search}%")
  				  #.where("content LIKE ?", "%#{search}%") 
	end
end