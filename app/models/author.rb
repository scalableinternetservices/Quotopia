class Author < ActiveRecord::Base
  has_many :quotes, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
