class TweetsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new]

  def new
  end

  def create
      current_user.tweet(twitter_params[:message])
      respond_to do |format|
        if current_user.twitter_errors.nil?
          format.js {}
        else
          format.js {render js: "alert('Failed');"}
        end
      end
      return
  end

  def twitter_params
    params.permit(:message)
  end
end
