class TweetsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new]

  def new
  end

  def create
      current_user.tweet(twitter_params[:message])
      respond_to do |format|
        format.js {}
      end
      return
  end

  def twitter_params
    params.permit(:message)
  end
end
