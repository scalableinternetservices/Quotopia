class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :quotes
  has_many :votes
  has_many :quotes, :through => :votes
  has_many :comments
  has_many :favorite_quotes
  has_many :favorites, through: :favorite_quotes, source: :quote  # quotes that a user favorites
  # has_many :submissions
  # has_many :quotes, through: :submissions
  # has_many :submissions, class_name: 'Quote', foreign_key: 'quote_id' if keep tracking of user-submissions does not work
end
