require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  fixtures :comments, :quotes, :users

  test "comment content must not be empty" do
    comment = Comment.new
    assert comment.invalid?
    assert comment.errors[:content].any?
  end

  test "should not save empty comment" do
    comment = Comment.new
    assert_not comment.save
  end

  test "comment is valid with content, associated quote and user" do
    comment = Comment.new(content: "hi", quote: quotes(:one), user: users(:bruhpls))
    assert comment.valid?
  end

  test "should save comment with content, associated quote and user" do
    comment = Comment.new(content: "hi", quote: quotes(:one), user: users(:bruhpls))
    assert comment.save
  end

  test "comment is not valid without an associated quote" do
    comment = Comment.new(content: "hi", user: users(:lonelyguy))
    assert comment.invalid?
    assert comment.errors[:quote].any?
  end

  test "should not save comment without an associated quote" do
    comment = Comment.new(content: "hi", user: users(:lonelyguy))
    assert_not comment.save
  end

  test "comment is not valid without an associated user" do
    comment = Comment.new(content: "hi", quote: quotes(:one))
    assert comment.invalid?
    assert_equal ["user should be logged in to comment"], comment.errors[:user]
  end

  test "should not save comment without an associated user" do
    comment = Comment.new(content: "hi", quote: quotes(:one))
    assert_not comment.save
  end

  test "comment is not valid without both an associated user and quote" do
    comment = Comment.new(content: "hi")
    assert comment.invalid?
    assert comment.errors.full_messages.any?
  end

  test "comment should not save without both an associated user and quote" do
    comment = Comment.new(content: "hi")
    assert_not comment.save
  end

  test "user can make more than one comment" do
    comment = Comment.new(content: "hi", quote: quotes(:one), user: users(:lonelyguy))
    assert comment.valid?
  end
end
