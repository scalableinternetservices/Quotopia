require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  fixtures :categories

  test "category content must not be empty" do
    category = Category.new
    assert category.invalid?
    assert category.errors[:content].any?
  end

  test "category is not valid without unique content" do
    category = Category.new(content: categories(:friendship).content, quote_id: categories(:friendship).quote_id)
    assert category.invalid?
    assert_equal ["has already been taken"], category.errors[:content]
  end
end
