class TweetsController < ApplicationController
  def new

  end

  def create
      current_user.tweet(twitter_params[:content])
      redirect_to :root
  end

  def twitter_params
    params.require(:tweet).permit(:content)
  end
end
