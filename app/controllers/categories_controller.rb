class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:new, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @sorted = Category.select("categories.*, sum((case when categorizations.category_id is not null then 1 else 0 end)) AS category_count")
                  .joins("LEFT JOIN categorizations ON categorizations.category_id = categories.id")
                  .group(:id)
                  .order("category_count DESC, created_at")
    @category = Category.new

    respond_to do |format|
      format.html
      format.json {render json: @sorted}
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @quotes = @category.quotes.joins(:author)
                              .select("quotes.id, quotes.content, authors.name as author_name, authors.id as author_id")
                              .all
                              .page(params[:page])
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        @sorted = Category.select("categories.*, sum((case when categorizations.category_id is not null then 1 else 0 end)) AS category_count")
                      .joins("LEFT JOIN categorizations ON categorizations.category_id = categories.id")
                      .group(:id)
                      .order("category_count DESC, created_at")
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:content, :quote_id)
    end
end
