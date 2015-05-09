class HomeController < ApplicationController
  def index
    @quotes = Quote.joins(:author)
                   .select("quotes.id, quotes.content, authors.name")
                   .all.page(params[:page])
    @categories = Category.all
    @authors = Author.all
  end
end
