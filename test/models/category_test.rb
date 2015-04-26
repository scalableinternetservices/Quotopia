require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  fixtures :categories

  test "category content must not be empty" do
    category = Category.new
    assert category.invalid?
    assert category.errors[:content].any?
  end

  test "shoud not save category without a name" do
    category = Category.new
    assert_not category.save
  end

  test "category is not valid without unique content" do
    category = Category.new(content: categories(:friendship).content, quote_id: categories(:friendship).quote_id)
    assert category.invalid?
    assert_equal ["has already been taken"], category.errors[:content]
  end

  test "should not save category without unique content" do
    category = Category.new(content: categories(:friendship).content, quote_id: categories(:friendship).quote_id)
    assert_not category.save
  end

  test "category is not valid without unique content (case-insensitive)" do
    category = Category.new(content: categories(:friendship).content.upcase, quote_id: categories(:friendship).quote_id)
    assert category.invalid?
    assert_equal ["has already been taken"], category.errors[:content]
  end

  test "should not save category without unique content (case-insensitive)" do
    category = Category.new(content: categories(:friendship).content.upcase, quote_id: categories(:friendship).quote_id)
    assert_not category.save
  end
end
