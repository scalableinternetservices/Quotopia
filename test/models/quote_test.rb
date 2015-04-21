require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  fixtures :quotes

  test "quote content must not be empty" do
    quote = Quote.new
    assert quote.invalid?
    assert quote.errors[:content].any?
  end

  test "quote is not valid without unique content" do
    quote = Quote.new(content: quotes(:thomas_aquinas_quote).content)
    assert quote.invalid?
    assert_equal ["has already been taken"], quote.errors[:content]
  end
end
