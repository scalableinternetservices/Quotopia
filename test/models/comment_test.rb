require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  fixtures :comments, :quotes

  test "comment content must not be empty" do
    comment = Comment.new
    assert comment.invalid?
    assert comment.errors[:content].any?
  end

  test "should not save empty comment" do
    comment = Comment.new
    assert_not comment.save
  end

  test "comment is valid with content and associated quote" do
    comment = Comment.new(content: "hi", quote: quotes(:one))
    assert comment.valid
  end

  test "should save comment with content and associated quote" do
    comment = Comment.new(content: "hi", quote: quotes(:one))
    assert comment.save
  end

  test "comment is not valid without an associated quote" do
    comment = Comment.new(content: "hi")
    assert comment.invalid?
    assert comment.errors[:quote].any?
  end

  test "should not save comment without an associated quote" do
    comment = Comment.new(content: "hi")
    assert_not comment.save
  end
end
