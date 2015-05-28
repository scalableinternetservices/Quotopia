class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:new, :edit, :update, :destroy]

  def getAuthorsOrdered
    @authors = Author.joins("LEFT JOIN quotes on quotes.author_id = authors.id")
                     .select("authors.id as id, authors.name as author_name, count(quotes.author_id) as num_quotes")
                     .group("authors.id")
                     .order("num_quotes desc")
  end 
  # GET /authors
  # GET /authors.json
  def index
    @authors = getAuthorsOrdered

    @author = Author.new

    respond_to do |format|
      format.html
      format.json {render json: @authors}
    end
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
    @author_quotes = @author.quotes.all.page(params[:page])
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        @authors = getAuthorsOrdered

        format.html { redirect_to @author, notice: 'Author was successfully created.' }
        format.json { render :show, status: :created, location: @author }
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1
  # PATCH/PUT /authors/1.json
  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to @author, notice: 'Author was successfully updated.' }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url, notice: 'Author was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def author_params
      params.require(:author).permit(:name)
    end
end
