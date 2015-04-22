module FormHelper
  def setup_quote(quote)
    quote.author ||= Author.new
    quote
  end
end