class HomeController < ApplicationController
  def index
    @quotes = Quote.all.page(params[:page]).per(5)
  end
end
