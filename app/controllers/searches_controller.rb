class SearchesController < ApplicationController
    
    def search 
      @has_search = false
    
      if params[:search] && !params[:search].empty?
        @has_search = true
        @search_quotes = Quote.search(params[:search]).page(params[:page])
      else
        @search_quotes = nil
      end
    end
end 

