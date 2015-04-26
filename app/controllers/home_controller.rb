class HomeController < ApplicationController
  def index
    @quotes = Quote.all
    @has_search = false

    if params[:search] && !params[:search].empty?
      @has_search = true
      @search_quotes = Quote.search(params[:search]).order("created_at DESC")
    else
      @search_quotes = nil #Quote.all.order('created_at DESC')
    end
  end
end
