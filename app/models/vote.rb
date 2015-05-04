class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :quote

  validates :value, presence: true
  validates :quote, presence: {scope: :user,
                              message: "a vote must reference both a quote and a user"}
  validates :quote, uniqueness: {scope: :user,
                                message: "a vote for a quote should be unique per user"}
  validates :user, presence: {scope: :quote,
                 message: "a vote must reference both a quote and a user"}
  validates :user, uniqueness: {scope: :quote,
                 message: "a vote for a quote should be unique per user"}

  def self.quote_count(requested_quote_id)
    @votes = Vote.where(quote_id: requested_quote_id)
    @count = @votes.inject(0) { |result, vote| result + vote.value }
  end

  def self.already_voted(requested_quote_id, requested_user_id)
        @vote = Vote.where(quote_id: requested_quote_id, user_id: requested_user_id).first()
  end
end
