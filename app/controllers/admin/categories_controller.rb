class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  load_and_authorize_resource
  # GET /categories
  # def index
  #   @categories = Category.all
  # end
  def index
    run Category::Index
    render cell(Category::Cell::Index, result["model"], layout: Home::Cell::Layout), layout: false
    #render cell(Category::Cell::Index, result["model"]), layout: true
  end

  # GET /categories/new
  # def new
  #   @category = Category.new
  # end
  def new
    run Category::Create::Present
    render cell(Category::Cell::New, result["model"], layout: Home::Cell::Layout), layout: false
  end

  # GET /categories/1/edit
  def edit
  end
  # def edit
  #   run Category::Update::Present
  #   render cell(Category::Cell::Edit, result["model"], layout: Home::Cell::Layout)
  # end

  # POST /categories
  # def create
  #   @category = Category.new(category_params)
  #   if @category.save
  #     redirect_to admin_categories_url, notice: 'Category was successfully created.'
  #   else
  #     render :new
  #   end
  # end
  def create
    run Category::Create do |result|
      return redirect_to admin_categories_path
    end

    render cell(Category::Cell::New, @form), layout: false
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to admin_categories_url, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end
  # def update
  #   run Category::Update do |result|
  #     return redirect_to admin_categories_path
  #   end

  #   render cell(Category::Cell::Update, @form), layout: false
  # end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to admin_categories_url, notice: 'Category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :description)
    end
end
