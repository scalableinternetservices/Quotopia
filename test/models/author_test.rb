require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  fixtures :authors

  test "author name must not be empty" do
    author = Author.new
    assert author.invalid?
    assert author.errors[:name].any?
  end

  test "author is not valid without unique name" do
    author = Author.new(name: authors(:thomas_aquinas).name)
    assert author.invalid?
    assert_equal ["has already been taken"], author.errors[:name]
  end
end
