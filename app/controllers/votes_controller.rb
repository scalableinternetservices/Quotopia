class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]
  

  def quote_count
    @requested_quote_id = params[:quote_id]
    @votes = Vote.where(quote_id: @requested_quote_id)
    @count = @votes.inject(0) { |result, vote| result + vote.value }
    render json: @count
  end 

  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @vote = Vote.new
  end

  # GET /votes/1/edit
  def edit
  end

  # POST /votes
  # POST /votes.json
  def create
    @vote = Vote.new(vote_params)
    @quote_id = @vote.quote_id

    respond_to do |format|
      if @vote.save
        format.html { redirect_to @vote, notice: 'Vote was successfully created.' }
        format.json { render :show, status: :created, location: @vote }
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PATCH/PUT /votes/1
  # PATCH/PUT /votes/1.json
  def update
    @quote_id = @vote.quote_id
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @vote }
        format.js {}
      else
        format.html { render :edit }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to votes_url, notice: 'Vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:value, :user_id, :quote_id)
    end
end
