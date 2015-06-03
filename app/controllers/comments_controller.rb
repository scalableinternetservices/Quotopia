class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:new, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @quote = Quote.find(params[:quote_id])
    @comments = @quote.comments
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @quote = Quote.find(params[:quote_id])
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    @quote = Quote.find(params[:quote_id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @quote = Quote.find(params[:quote_id])
    @userid = (current_user.nil?) ? nil : current_user.id
    @comment = Comment.new(content: comment_params[:content], quote_id: @quote.id, user_id: @userid)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to quote_path(params[:quote_id]), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to quote_path(params[:quote_id]), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/:quote_id/comments/1
  # DELETE /quotes/:quote_id/comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to quote_path(params[:quote_id]), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /comments/:content/:quote_id/:user_id
  # POST /comments/:content/:quote_id/:user_id.json
  def destroy_from_params
    @comment = Comment.where(content: params[:content], quote_id: params[:quote_id], user_id: params[:user_id]).first
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to quote_path(params[:quote_id]), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content)
    end
end
