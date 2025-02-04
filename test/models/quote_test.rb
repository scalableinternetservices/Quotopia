require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  fixtures :quotes, :users

  test "quote content must not be empty" do
    quote = Quote.new
    assert quote.invalid?
    assert quote.errors[:content].any?
  end

  test "should not save quote without content" do
    quote = Quote.new
    assert_not quote.save
  end

  test "quote is not valid without unique content and author" do
    quote = Quote.new(content_hash: quotes(:thomas_aquinas_quote).content_hash,
                      content: quotes(:thomas_aquinas_quote).content,
                      author: quotes(:thomas_aquinas_quote).author)
    assert quote.invalid?
    assert_equal ["quote should be unique per author"], quote.errors[:content_hash]
  end

  test "should not save quote without unique content and author" do
    quote = Quote.new(content_hash: quotes(:thomas_aquinas_quote).content_hash, content: quotes(:thomas_aquinas_quote).content, author: quotes(:thomas_aquinas_quote).author)
    assert_not quote.save
  end

  test "quote is not valid without unique content (case insensitive) and author" do
    quote = Quote.new(content_hash: Digest::MD5.hexdigest(quotes(:thomas_aquinas_quote).content.downcase), content: quotes(:thomas_aquinas_quote).content.upcase,
                      author: quotes(:thomas_aquinas_quote).author)
    assert quote.invalid?
    assert_equal ["quote should be unique per author"], quote.errors[:content_hash]
  end

  test "should not save quote without unique content (case insensitive) and author" do
    quote = Quote.new(content_hash: Digest::MD5.hexdigest(quotes(:thomas_aquinas_quote).content.downcase),
                                                          content: quotes(:thomas_aquinas_quote).content.upcase,
                                                          author: quotes(:thomas_aquinas_quote).author)
    assert_not quote.save
  end

  test "should save quote with unique content and author" do
    quote = Quote.new(content: "MyString", author: Author.new(name: 'Roger'), user: users(:lonelyguy))
    assert quote.save
  end

  test "quote is not valid without an author" do
    quote = Quote.new(content: "MyString")
    assert quote.invalid?
    assert_equal ["can't be blank"], quote.errors[:author]
  end

  test "should not save quote without an author" do
    quote = Quote.new(content: "MyString")
    assert_not quote.save
  end

  test "quote is valid with unique content and non-unique author" do
    quote = Quote.new(content_hash: Digest::MD5.hexdigest("MyString"), content: "MyString", author: quotes(:thomas_aquinas_quote).author, user: users(:lonelyguy))
    assert quote.valid?
  end

  test "should save quote with unique content and non-unique author" do
    quote = Quote.new(content_hash: Digest::MD5.hexdigest("MyString"), content: "MyString", author: quotes(:thomas_aquinas_quote).author, user: users(:lonelyguy))
    assert quote.save
  end

  test "quote is valid with non-unique content and unique author" do
    quote = Quote.new(content: quotes(:one), author: Author.new(name: 'Roger'), user: users(:lonelyguy))
    assert quote.valid?
  end

  test "quote is valid with non-unique content (case-insensitive) and unique author" do
    quote = Quote.new(content: quotes(:one).content.upcase, author: Author.new(name: 'Roger'), user: users(:lonelyguy))
    assert quote.valid?
  end

  test "should save quote with non-unique content and unique author" do
    quote = Quote.new(content: quotes(:one), author: Author.new(name: 'Roger'), user: users(:lonelyguy))
    assert quote.save
  end

  test "should save quote with non-unique content (case-insensitive) and unique author" do
    quote = Quote.new(content: quotes(:one).content.upcase, author: Author.new(name: 'Roger'), user: users(:lonelyguy))
    assert quote.save
  end

end
