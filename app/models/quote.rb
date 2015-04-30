class Quote < ActiveRecord::Base
  belongs_to :author
  # belongs_to :submitter, class_name: 'User', foreign_key: 'user_id' if keep tracking of user-submissions does not work
  belongs_to :user
  has_many :votes
  has_many :users, :through => :votes
  has_many :comments
  # has_and_belongs_to_many :categories
  has_many :categorizations
  has_many :categories, :through => :categorizations

  accepts_nested_attributes_for :author
  accepts_nested_attributes_for :categories

  validates :content, presence: true
  validates :content, uniqueness: {scope: :author, case_sensitive: false,
                    message: "quote should be unique per author"}
  validates :author, presence: true

  # This determines how many quotes to display per page
  paginates_per 7

	def self.search(search)
    @quote = Quote.joins(:author)
                  .select("quotes.content, authors.name")
                  .where("authors.name LIKE ? or content LIKE ?", "%#{search}%", "%#{search}%")
  end

  def category_list=(categories_string)
    category_names = categories_string.split(",").collect{ |category|
      category.strip.downcase
    }.uniq
    @categories = category_names.collect{ |name| Category.find_or_create_by(content: name)}
    self.categories = @categories
  end

  def category_list
    self.categories.collect do |category|
      category.content
      end.join(", ")
    end

end