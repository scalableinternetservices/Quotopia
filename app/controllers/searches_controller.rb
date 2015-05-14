class SearchesController < ApplicationController
    
    def search 
      @has_search = false
    
      if params[:q] && !params[:q].empty?
        @has_search = true
        @search_quotes = Quote.search(params[:q]).page(params[:page])
      else
        @search_quotes = nil
      end
    end

    def search_typeahead
        q = params[:query]
    end
end 

