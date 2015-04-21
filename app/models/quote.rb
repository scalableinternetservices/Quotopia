class Quote < ActiveRecord::Base
  belongs_to :author
  belongs_to :user
  has_many :votes
  has_many :users, :through => :votes
  has_many :comments
  has_and_belongs_to_many :categories
end
