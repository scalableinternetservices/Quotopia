class HomeController < ApplicationController
  def index
    @quotes = Quote.all
  end
end
