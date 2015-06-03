class QuotesController < ApplicationController
  require 'digest/md5'

  before_action :set_quote, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:new, :edit, :update, :destroy]

  # GET /quotes
  # GET /quotes.json
  # Deprecated
  def index
    @has_search = false

    if params[:search] && !params[:search].empty?
      @has_search = true
      @search_quotes = Quote.search(params[:search]).page(params[:page])
    else
      @search_quotes = nil
    end
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
    @comment = Comment.new
    @categories = @quote.categories.map {|c| '#' + c.content.gsub(/\s+/, "")}.join(' ')
    @tweet = "#{@quote.content} -#{@quote.author.name} #{@categories}".truncate(140)
  end


  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /quotes/1/edit
  def edit
    @quote = Quote.find(params[:id])
  end

  # POST /quotes
  # POST /quotes.json
  def create
    if params[:cancel].present?
      redirect_to root_url
      return
    end

    author_name = quote_params[:author_attributes][:name]
    @author = Author.where(name: author_name).first_or_create

    @quote = Quote.new(quote_params.except("author_attributes"))
    @quote.author = @author
    @quote.user_id = (current_user.nil?)? nil : current_user.id
    @quote.content_hash = Digest::MD5.hexdigest(quote_params[:content].downcase)

    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote, notice: 'Quote was successfully created.' }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  def favorite
    
  end

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    if params[:cancel].present?
      redirect_to root_url
      return
    end

    author_name = quote_params[:author_attributes][:name]
    @author = Author.where(name: author_name).first_or_create
    @quote.attributes = quote_params.except("author_attributes")
    @quote.author = @author
    @quote.content_hash = Digest::MD5.hexdigest(quote_params[:content].downcase)

    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote, notice: 'Quote was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: 'Quote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PUT /quotes/:content/:author/:user_id
  # PUT /quotes/:content/:author/:user_id.json
  def destroy_from_params
    @author = Author.where(name: params[:author]).first
    @quote = Quote.where(content: params[:content], author_id: @author.id).first
    if !@quote.nil?
      @quote.destroy
    end
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Quote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      params.require(:quote).permit(:content, :user_id,  :category_list, :author_attributes => [:name])
    end

end
