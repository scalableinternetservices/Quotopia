class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!, :only => [:new]

  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.all
    @has_search = false

    if params[:search] && !params[:search].empty?
      @has_search = true
      @search_quotes = Quote.search(params[:search]).order("created_at DESC")
    else
      @search_quotes = nil #Quote.all.order('created_at DESC')
    end
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes
  # POST /quotes.json
  def create
    author_attributes = quote_params.delete("author_attributes")
    # category_attributes = quote_params.delete("category")

    #@categories = []


    @author = Author.find_or_create_by(name: author_attributes[:name])
    #@categories = Category.find_or_create_by(content: category_attributes[:content])

    @quote = Quote.new(quote_params)
    @quote.author = @author

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

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
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
