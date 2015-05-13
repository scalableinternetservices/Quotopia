class HomeController < ApplicationController
  # Return data depending on which tab is selected, defaults to "Trending"
  def index
    if params[:tab] == "all-time"
      @quotes = Quote.joins("LEFT JOIN( select quote_id, sum(value) as
          value_sum from votes group by quote_id) as sums on quotes.id
          = sums.quote_id")
                      .joins(:author)
                      .order("COALESCE(sums.value_sum,0) DESC")
                      .select("quotes.id, quotes.content, authors.name")
                      .all.page(params[:page])
      @tab_id = "all-time"
    elsif params[:tab] == "new"
        @quotes = Quote.joins(:author)
                     .select("quotes.id, quotes.content, authors.name")
                     .order("quotes.created_at DESC")
                     .all.page(params[:page])
        @tab_id = "new"

     # default to trending if no tab paramenter
     else
       if ActiveRecord::Base.connection.adapter_name.downcase.starts_with? 'mysql'
         @interval_check = "now() - INTERVAL 1 DAY"
       else
         @interval_check = "datetime('now','1 day')"
       end

       @quotes = Quote.joins("LEFT JOIN( select quote_id, sum(value) as
         value_sum from votes WHERE created_at >= " + @interval_check +
         " group by quote_id) as sums on quotes.id = sums.quote_id")
                       .joins(:author)
                       .order("COALESCE(sums.value_sum,0) DESC")
                       .select("quotes.id, quotes.content, authors.name")
                       .all.page(params[:page])

       @tab_id = "trending"
      end
  end
end
