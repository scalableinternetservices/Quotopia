module QuotesHelper
  def cache_key_for_quotes(quotes, tab, page)
    max_updated_at = quotes.maximum(:updated_at).try(:utc).try(:to_s, :number)
    if page.nil?
      page = 1
    end
    "quotes/tab-#{tab}/page-#{page}/#{max_updated_at}"
  end

  def cache_key_for_quote(quote, tab, page)
    updated_at = quote.updated_at.try(:utc).try(:to_s, :number)
    "quote/tab-#{tab}/#{quote.id}/#{updated_at}"
  end

  def cache_key_for_author_quote(author, quote, page)
    author_updated_at = author.updated_at.try(:utc).try(:to_s, :number)
    quote_updated_at = quote.updated_at.try(:utc).try(:to_s, :number)
    if page.nil?
      page = 1
    end
    "author/page-#{page}/#{author.id}/#{author_updated_at}/#{quote.id}/#{quote_updated_at}"
  end
end
