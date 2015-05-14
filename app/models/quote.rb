class Quote < ActiveRecord::Base
  belongs_to :author
  # belongs_to :submitter, class_name: 'User', foreign_key: 'user_id' if keep tracking of user-submissions does not work
  belongs_to :user
  has_many :votes, dependent: :destroy
  has_many :users, :through => :votes
  has_many :comments, dependent: :destroy
  has_many :categorizations
  has_many :categories, :through => :categorizations
  has_many :favorite_quotes
  has_many :favorited_by, through: :favorite_quotes, source: :user  # users that favorite a quote

  accepts_nested_attributes_for :author
  accepts_nested_attributes_for :categories

  validates :content, presence: true
  validates :content_hash, uniqueness: {scope: :author, case_sensitive: false,
                    message: "quote should be unique per author"}
  validates :author, presence: true

  # This determines how many quotes to display per page
  paginates_per 7

	def self.search(search)
    @quote = Quote.joins(:author, :categories)
                  .select("quotes.id, quotes.content, authors.name as author_name, authors.id as author_id")
                  .where("categories.content LIKE ?", "#{search}")

    if @quote.empty?
      @quote = Quote.joins(:author)
                    .select("quotes.id, quotes.content, authors.name as author_name, authors.id as author_id")
                    .where("authors.name LIKE ? or content LIKE ?", "%#{search}%", "%#{search}%")
    end

    return @quote
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
