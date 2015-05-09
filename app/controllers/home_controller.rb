class HomeController < ApplicationController
  def index
    @quotes = Quote.all.page(params[:page])
    @categories = Category.all
  end
end
