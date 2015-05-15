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

    def typeahead
        @q = params[:q]
        @authors = Author.select("authors.name as value")
                         .where("authors.name LIKE ?", "%#{@q}%")
        
        @categories = Category.select("categories.content as value")
                              .where("categories.content LIKE ?", "%#{@q}%")
        
        #Uncomment this to add searching on Quotes.content
        #@quotes = Quote.select("quotes.content as value")
        #               .where("quotes.content LIKE ?", "%#{@q}%")
        
        #might want to ensure capitalization in @categories?
        puts render json: @authors + @categories #+ @quotes

    end
end 

