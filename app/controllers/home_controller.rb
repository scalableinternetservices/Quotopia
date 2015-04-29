class HomeController < ApplicationController
  def index
    @quotes = Quote.all.page(params[:page]).per(2)
  end
end
