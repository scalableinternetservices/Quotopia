class HomeController < ApplicationController
  def index
    @quotes = Quote.all.page(params[:page])
  end
end
