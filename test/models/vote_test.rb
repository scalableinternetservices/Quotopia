require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  fixtures :votes, :quotes, :users

  test "vote is not valid without a value" do
    vote = Vote.new
    assert vote.invalid?
    assert vote.errors[:value].any?
  end

  test "should not save vote without a value" do
    vote = Vote.new
    assert_not vote.save
  end

  test "vote is not valid without a quote and a user" do
    vote = Vote.new(value: 1)
    assert vote.invalid?
    assert_equal ["a vote must reference both a quote and a user"], vote.errors[:quote]
  end

  test "should not save vote without a quote and a user" do
    vote = Vote.new(value: 1)
    assert_not vote.save
  end

  test "vote is not valid without a quote" do
    vote = Vote.new(value: 1, user: votes(:upvote).user)
    assert vote.invalid?
    assert_equal ["a vote must reference both a quote and a user"], vote.errors[:quote]
  end

  test "should not save vote without a quote" do
    vote = Vote.new(value: 1, user: votes(:upvote).user)
    assert_not vote.save
  end

  test "vote is not valid without a user" do
    vote = Vote.new(value: 1, quote: votes(:upvote).quote)
    assert vote.invalid?
    assert_equal ["a vote must reference both a quote and a user"], vote.errors[:user]
  end

  test "should not save vote without a user" do
    vote = Vote.new(value: 1, quote: votes(:upvote).quote)
    assert_not vote.save
  end

  # User has never voted and this quote has never been voted on
  test "vote is valid with unique quote and unique user" do
    vote = Vote.new(value: 1, quote: quotes(:one), user: users(:quotopia))
    assert vote.valid?
  end

  test "should save vote with unique quote and unique user" do
    vote = Vote.new(value: 1, quote: quotes(:one), user: users(:quotopia))
    assert vote.save
  end

  # Quote has never been voted on, but user has voted before
  test "vote is valid with unique quote and non-unique user" do
    vote = Vote.new(value: 1, quote: quotes(:one), user: users(:bruhpls))
    assert vote.valid?
  end

  test "should save vote with unique quote and non-unique user" do
    vote = Vote.new(value: 1, quote: quotes(:one), user: users(:bruhpls))
    assert vote.save
  end

  # Quote has been voted on, but user has never voted before
  test "vote is valid with non-unique quote and unique user" do
    vote = Vote.new(value: 1, quote: quotes(:thomas_aquinas_quote), user: users(:quotopia))
    assert vote.valid?
  end

  test "should save vote with non-unique quote and unique user" do
    vote = Vote.new(value: 1, quote: quotes(:thomas_aquinas_quote), user: users(:quotopia))
    assert vote.save
  end

  # Quote has been voted on before and user has voted before
  test "vote is valid with non-unique quote and non-unique user" do
    vote = Vote.new(value: 1, quote: quotes(:one), user: users(:bruhpls))
    assert vote.valid?
  end

  test "should save vote with non-unique quote and non-unique user" do
    vote = Vote.new(value: 1, quote: quotes(:one), user: users(:bruhpls))
    assert vote.save
  end

  test "vote is not valid if a user has voted on this quote already with same value" do
    vote = Vote.new(value: votes(:upvote).value, quote: votes(:upvote).quote, user: votes(:upvote).user)
    assert vote.invalid?
  end

  test "should not save vote if a user has voted on this quote with same value" do
    vote = Vote.new(value: votes(:upvote).value, quote: votes(:upvote).quote, user: votes(:upvote).user)
    assert_not vote.save
  end

  test "vote is valid if a user has voted on this quote already and is re-voting with opposite value" do
    vote = votes(:upvote)
    vote.value = -1
    assert vote.valid?
  end

  test "should save vote if a user has voted on this quote already and is re-voting with opposite value" do
    vote = votes(:upvote)
    vote.value = -1
    assert vote.save
  end
end
