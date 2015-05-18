class TweetsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new]

  def new
  end

  def create
      @response = current_user.tweet(twitter_params[:content])
      if @response.nil?
        redirect_to tweets_error_path
      end
      return
  end

  def twitter_params
    params.permit(:message)
  end
end
