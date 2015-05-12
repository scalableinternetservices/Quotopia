class Comment < ActiveRecord::Base
  belongs_to :quote
  belongs_to :user

  validates :content, presence: true
  validates :quote, presence: true
end
