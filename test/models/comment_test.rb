require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "comment content must not be empty" do
    comment = Comment.new
    assert comment.invalid?
    assert comment.errors[:content].any?
  end
end
