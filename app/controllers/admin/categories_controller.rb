class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource
  # GET /categories
  def index
    run Category::Index
    render cell(Category::Cell::Index, result["model"])
  end

  # GET /categories/new
  def new
    run Category::Create::Present
    render cell(Category::Cell::New, result["model"])
  end

  # GET /categories/1/edit
  def edit
    run Category::Update::Present
    render cell(Category::Cell::Edit, result["model"])
  end

  # POST /categories
  def create
    run Category::Create do |result|
      return redirect_to admin_categories_path, notice: 'Category was successfully created.'
    end

    render cell(Category::Cell::New, @form)
    # render cell(Category::Cell::New, @form, layout: Home::Cell::Layout), layout: false
  end

  # PATCH/PUT /categories/1
  def update
    run Category::Update do |result|
      return redirect_to admin_categories_path, notice: 'Category was successfully updated.'
    end

    render cell(Category::Cell::Update, @form)
  end

  # DELETE /categories/1
  def destroy
    run Category::Delete
    redirect_to admin_categories_path, notice: 'Category was successfully destroyed.'
  end

  def create_params
  end
end
