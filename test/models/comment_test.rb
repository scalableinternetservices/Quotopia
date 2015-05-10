require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "comment content must not be empty" do
    comment = Comment.new
    assert comment.invalid?
    assert comment.errors[:content].any?
  end

  test "should not save empty comment" do
    comment = Comment.new
    assert_not comment.save
  end
end
