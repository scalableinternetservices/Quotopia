class Quote < ActiveRecord::Base
  belongs_to :author
  # belongs_to :submitter, class_name: 'User', foreign_key: 'user_id' if keep tracking of user-submissions does not work
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
  	#@author = Author.where("name Like ?",  "%#{search}%").quotes.content
    #@quote = Quote.where("content LIKE ?", "%#{search}%")
    @quote = Quote.joins(:author)
                  .select("quotes.content, authors.name")
                  .where("authors.name LIKE ? or content LIKE ?", "%#{search}%", "%#{search}%")
                  .order("authors.created_at DESC;")
  end
end