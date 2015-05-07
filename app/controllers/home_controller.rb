class HomeController < ApplicationController
  def index
    @quotes = Quote.all.page(params[:page])
    @categories = Category.all
    @authors = Author.all
  end
end
